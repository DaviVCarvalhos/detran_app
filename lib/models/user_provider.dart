import 'package:detranapp/models/Veiculo.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:detranapp/models/App_User.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  void login(User user) {
    _currentUser = user;
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

        return App_User.fromMap(Map<String, dynamic>.from(data));
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar dados do usuário: $e');
      return null;
    }
  }
}
