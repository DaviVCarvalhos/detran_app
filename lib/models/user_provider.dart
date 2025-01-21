import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:detranapp/models/App_User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  App_User? _app_user;
  App_User? get app_user => _app_user;

  void login(User user) async {
    _currentUser = user;
    _app_user = await getUserDataFromDatabase();
    await saveUserSession(_app_user!);
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

  Future<void> saveUserSession(App_User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', user.id);
    await prefs.setString('email', user.email);
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

  // Função para buscar os dados do usuário no Realtime Database
  Future<App_User?> getUserDataFromDatabase() async {
    if (_currentUser == null) {
      return null;
    }

    final uid = _currentUser!.uid;
    final databaseReference = FirebaseDatabase.instance.ref('users/$uid');

    try {
      final snapshot = await databaseReference.get();

      if (snapshot.value != null) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        App_User app_user =
            App_User.fromMap(uid, Map<String, dynamic>.from(data));

        if (data['biometria'] == true) {
          return app_user;
        }
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
