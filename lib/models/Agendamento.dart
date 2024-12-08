class Agendamento {
  final String id;
  final String categoria;
  final String data;
  final String hora;
  final String status;
  final String userId;
  final String local;

  Agendamento({
    required this.id,
    required this.categoria,
    required this.data,
    required this.hora,
    required this.status,
    required this.userId,
    required this.local
  });

  factory Agendamento.fromJson(String id, Map<String, dynamic> json) {
    return Agendamento(
      id: id,
      categoria: json['categoria'],
      data: json['data'],
      hora: json['hora'],
      status: json['status'],
      userId: json['userId'],
      local: json['local']
    );
  }
}
