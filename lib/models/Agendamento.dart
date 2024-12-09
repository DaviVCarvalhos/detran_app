class Agendamento {
  final String id;
  final String categoria;
  final String data;
  final String horario;
  final String servico;
  final String userId;
  final String local;

  Agendamento(
      {required this.id,
      required this.categoria,
      required this.data,
      required this.horario,
      required this.servico,
      required this.userId,
      required this.local});

  factory Agendamento.fromJson(String id, Map<String, dynamic> json) {
    return Agendamento(
        id: id,
        categoria: json['categoria'],
        data: json['data'],
        horario: json['horario'],
        servico: json['servico'],
        userId: json['userId'],
        local: json['local']);
  }
}
