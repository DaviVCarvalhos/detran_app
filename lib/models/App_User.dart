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

  factory App_User.fromMap(String id, Map<String, dynamic> map) {
    try {
      return App_User(
        id: id,
        cpf: map['cpf'] ?? '',
        nome: map['nome'] ?? '',
        email: map['email'] ?? '',
        phone_number: map['telefone'] ?? '',
        datanascimento: DateTime.tryParse(map['dataNascimento'] ?? '') ??
            DateTime(1970, 1, 1),
      );
    } catch (e) {
      throw Exception('Erro ao converter os dados do usuário: $e');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'telefone': phone_number,
      'dataNascimento': datanascimento.toIso8601String(),
    };
  }
}
