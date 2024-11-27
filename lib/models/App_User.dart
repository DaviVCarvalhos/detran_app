import 'package:detranapp/models/Veiculo.dart';

class App_User {
  App_User(
      {required this.id,
      required this.cpf,
      required this.datanascimento,
      required this.nome,
      required this.email,
      required this.phone_number});

  String id;
  String cpf;
  String nome;
  String email;
  String phone_number;
  DateTime datanascimento;
  List<Veiculo> veiculos = [];

  factory App_User.fromMap(Map<String, dynamic> map) {
    return App_User(
      id: map['id'],
      cpf: map['cpf'],
      nome: map['nome'],
      email: map['email'],
      phone_number: map['phone_number'],
      datanascimento: DateTime.parse(map['datanascimento']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'phone_number': phone_number,
      'datanascimento': datanascimento.toIso8601String(),
    };
  }
}
