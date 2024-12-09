class Infracao {
  final String id;
  final String descricao;
  final String placa;
  final double valor;
  final bool quitada;
  final String userId;

  Infracao({
    required this.id,
    required this.descricao,
    required this.placa,
    required this.valor,
    required this.quitada,
    required this.userId,
  });

  factory Infracao.fromJson(String id, Map<String, dynamic> json) {
    return Infracao(
      id: id,
      descricao: json['descricao'],
      placa: json['placa'],
      valor: json['valor'],
      quitada: json['quitada'] ?? false,
      userId: json['userId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descricao': descricao,
      'placa': placa,
      'valor': valor,
      'quitada': quitada,
      'userId' : userId
    };
  }
}
