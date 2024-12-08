class Infracao {
  final String id;
  final String renavam;
  final String placa;
  final String cpf;
  final String nInfracao;
  final bool quitada;

  Infracao({
    required this.id,
    required this.renavam,
    required this.placa,
    required this.cpf,
    required this.nInfracao,
    required this.quitada,
  });

  Infracao copyWith({String? id, String? renavam, String? placa, String? cpf, String? nInfracao, bool? quitada}) {
    return Infracao(
      id: id ?? this.id,
      renavam: renavam ?? this.renavam,
      placa: placa ?? this.placa,
      cpf: cpf ?? this.cpf,
      nInfracao: nInfracao ?? this.nInfracao,
      quitada: quitada ?? this.quitada,
    );
  }

  factory Infracao.fromJson(String id, Map<String, dynamic> json) {
    return Infracao(
      id: id,
      renavam: json['renavam'],
      placa: json['placa'],
      cpf: json['cpf'],
      nInfracao: json['nInfracao'],
      quitada: json['quitada'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'renavam': renavam,
      'placa': placa,
      'cpf': cpf,
      'nInfracao': nInfracao,
      'quitada': quitada,
    };
  }
}
