class Veiculo {
  Veiculo({
    required this.id,
    required this.placa,
    required this.renavam,
    required this.modelo,
    required this.anoFabricacao,
    required this.nomeProprietario,
    this.proprietarioAnterior,
  });

  String id;
  String placa;
  String renavam;
  String modelo;
  String anoFabricacao;
  String nomeProprietario;
  String? proprietarioAnterior;

  factory Veiculo.fromJson(String id, Map<String, dynamic> data) {
    return Veiculo(
        id: id,
        placa: data['placa'],
        modelo: data['modelo'],
        anoFabricacao: data['anoFabricacao'],
        nomeProprietario: data['nomeProprietario'],
        renavam: data['renavam'],
        proprietarioAnterior: data['proprietarioAnterior']);
  }

  Map<String, dynamic> toJson() {
    return {
      'placa': placa,
      'renavam': renavam,
      'modelo': modelo,
      'anoFabricacao': anoFabricacao,
      'nomeProprietario': nomeProprietario,
      if (proprietarioAnterior != null)
        'proprietarioAnterior': proprietarioAnterior,
    };
  }
}
