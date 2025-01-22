import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:detranapp/models/App_User.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool _shouldRememberUser = false;

  bool get shouldRememberUser => _shouldRememberUser;

  App_User? _app_user;
  App_User? get app_user => _app_user;

  void login(User user, bool rememberUser) async {
    _currentUser = user;
    _app_user = await getUserDataFromDatabase();
    await saveUserSession(_app_user!, rememberUser);
    String? token = await _getStoredToken();
    if (token != null) {
      await saveDeviceToken(token);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    _app_user = null;
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  Future<void> saveDeviceToken(String token) async {
    final _baseUrl = 'https://detranapp-75e56-default-rtdb.firebaseio.com/';
    try {
      final checkResponse = await http.get(Uri.parse('$_baseUrl/tokens.json'));

      if (checkResponse.statusCode == 200) {
        final Map<String, dynamic>? tokensData = jsonDecode(checkResponse.body);

        if (tokensData != null) {
          final tokenExists =
              tokensData.values.any((data) => data['token'] == token);

          if (tokenExists) {
            print("Token já registrado");
            return;
          }
        }
      } else {
        print(
            "Erro ao verificar tokens: ${checkResponse.statusCode} - ${checkResponse.body}");
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/tokens.json'),
        body: jsonEncode({
          'token': token,
          'userId': _app_user!.id,
        }),
      );

      if (response.statusCode == 200) {
        print("Token enviado");
      } else {
        print(
            "Erro ao enviar token: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Erro ao enviar token: $e");
    }
  }

  Future<String?> _getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('device_token');
  }

  Future<void> saveUserSession(App_User user, bool rememberUser) async {
    _shouldRememberUser = rememberUser;

    if (rememberUser) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', user.id);
      prefs.setString('email', user.email);
    }
    notifyListeners();
  }

  // Remove os dados da sessão se o usuário desmarcar "manter-se conectado"
  Future<void> clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('email');
    _shouldRememberUser = false;
    notifyListeners();
  }

  Future<Map<String, String>?> getUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    String? email = prefs.getString('email');
    if (id != null && email != null) {
      return {'id': id, 'email': email};
    }
    return null;
  }

  Future<void> checkUserSession() async {
    Map<String, String>? session = await getUserSession();
    print(session);
    if (session != null) {
      String userId = session['id']!;
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null && firebaseUser.uid == userId) {
        _currentUser = firebaseUser;
        _app_user = await getUserDataFromDatabase();
      }
    }
    notifyListeners();
  }

  Future<App_User?> getUserDataFromDatabase() async {
    if (_currentUser == null) {
      print('Usuário não autenticado');
      return null;
    }

    final uid = _currentUser!.uid;
    final databaseReference = FirebaseDatabase.instance.ref('users/$uid');

    try {
      final snapshot = await databaseReference.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        print('Dados do usuário encontrados: $data');

        App_User app_user =
            App_User.fromMap(uid, Map<String, dynamic>.from(data));

        app_user.profileImagePath = data["profileImagePath"];
        print(app_user.profileImagePath);
        app_user = app_user;

        if (data['biometria'] == true) {
          return app_user;
        } else {
          print('A chave "biometria" não é verdadeira ou não existe');
        }
      } else {
        print('Dados do usuário não encontrados no banco de dados');
      }
    } catch (e) {
      print('Erro ao buscar dados do usuário: $e');
    }
    return null;
  }

  Future<void> updateUserInFirebase(
      App_User updatedUser, BuildContext context) async {
    final databaseReference =
        FirebaseDatabase.instance.ref('users/${updatedUser.id}');
    try {
      await databaseReference.update(updatedUser.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar o perfil: $e')),
      );
    }
  }

  Future<String> uploadProfileImage(XFile file) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_pictures')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    await storageRef.putFile(File(file.path));

    String imageUrl = await storageRef.getDownloadURL();

    if (_currentUser != null) {
      final userId = _currentUser!.uid;
      final userRef = FirebaseDatabase.instance.ref('users/$userId');
      try {
        await userRef.update({
          'profileImagePath': imageUrl,
        });
        print('Imagem de perfil atualizada com sucesso!');
        return imageUrl;
      } catch (e) {
        print('Erro ao atualizar a imagem de perfil: $e');
        return '';
      }
    }
    return '';
  }

  Future<void> deleteCurrentUser() async {
    try {
      _currentUser = FirebaseAuth.instance.currentUser;
      if (_currentUser != null) {
        await _currentUser!.delete();
      }
    } catch (e) {
      throw Exception('Erro ao deletar usuário: $e');
    }
  }
}
