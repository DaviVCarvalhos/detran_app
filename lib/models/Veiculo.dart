class Veiculo {
  Veiculo({
    required this.placa,
    required this.renavam,
    required this.modelo,
    required this.anoFabricacao,
    required this.nomeProprietario,
  });

  String placa;
  String renavam;
  String modelo;
  String anoFabricacao;
  String nomeProprietario;
  String? proprietarioAnterior;
}
