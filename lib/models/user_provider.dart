import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:detranapp/models/App_User.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  App_User? _app_user;
  App_User? get app_user => _app_user;

  void login(User user) async {
    _currentUser = user;
    _app_user = await getUserDataFromDatabase();
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    FirebaseAuth.instance.signOut();
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
        return app_user;
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar dados do usuário: $e');
      return null;
    }
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
}
