import 'package:detranapp/models/Veiculo.dart';
import 'package:detranapp/widgets/VeiculoDetails.dart';
import 'package:flutter/material.dart';

class ConsultarVeiculoPage extends StatefulWidget {
  final Function(Veiculo) onVeiculoAdicionado; // Callback

  const ConsultarVeiculoPage({Key? key, required this.onVeiculoAdicionado})
      : super(key: key);

  @override
  _ConsultarVeiculoPageState createState() => _ConsultarVeiculoPageState();
}

class _ConsultarVeiculoPageState extends State<ConsultarVeiculoPage> {
  final TextEditingController placaController = TextEditingController();
  final TextEditingController renavamController = TextEditingController();
  Veiculo? veiculo;

  void consultarVeiculo() {
    final String placa = placaController.text;
    final String renavam = renavamController.text;

    setState(() {
      veiculo = Veiculo(
          placa: placa,
          renavam: renavam,
          modelo: 'VW JETTA 2.0T (Importado)',
          anoFabricacao: '2013',
          nomeProprietario: 'Ian');
    });
  }

  void adicionarVeiculo() {
    if (veiculo != null) {
      widget.onVeiculoAdicionado(veiculo!); // Chama o callback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${veiculo!.modelo} adicionado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Placa',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                  controller: placaController,
                  decoration: InputDecoration(border: OutlineInputBorder())),
              const SizedBox(height: 16),
              const Text('Renavam',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextField(
                  controller: renavamController,
                  decoration: InputDecoration(border: OutlineInputBorder())),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: consultarVeiculo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                  ),
                  child: const Text('Consultar',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              if (veiculo != null) ...[
                const SizedBox(height: 32),
                const Text('Detalhes do Veículo:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                VeiculoDetails(veiculo: veiculo!),
              ],
            ],
          ),
        ),
        if (veiculo != null &&
            veiculo!.nomeProprietario ==
                'Ian') //Futuramente sera um usuario e verificara nome e cpf para poder adicionar
          Positioned(
            right: 16,
            bottom: 16,
            child: SizedBox(
              width: 56,
              height: 56,
              child: FloatingActionButton(
                onPressed: adicionarVeiculo,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ),
      ],
    );
  }
}
