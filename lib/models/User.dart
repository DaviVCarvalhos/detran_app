import 'package:detranapp/models/Veiculo.dart';

class User {
  User(
      {required this.cpf,
      required this.datanascimento,
      required this.nome,
      required this.email,
      required this.phone_number});

  String cpf;
  String nome;
  String email;
  String phone_number;
  DateTime datanascimento;
  List<Veiculo> veiculos = [];
}
