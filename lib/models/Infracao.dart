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
    bool quitadaValue = false;
    var quitadaRaw = json['quitada'];
    if (quitadaRaw is bool) {
      quitadaValue = quitadaRaw;
    } else if (quitadaRaw is int) {
      quitadaValue = quitadaRaw == 1;
    }

    return Infracao(
      id: id,
      descricao: json['descricao'] ?? '',
      placa: json['placa'] ?? '',
      valor: (json['valor'] ?? 0.0).toDouble(),
      quitada: quitadaValue,
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'placa': placa,
      'valor': valor,
      'quitada': quitada,
      'userId': userId
    };
  }
}
