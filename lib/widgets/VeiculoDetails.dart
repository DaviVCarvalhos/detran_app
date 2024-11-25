import 'package:detranapp/models/Veiculo.dart';
import 'package:flutter/material.dart';

class VeiculoDetails extends StatelessWidget {
  late final Veiculo veiculo;

  VeiculoDetails(Veiculo veiculo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detalhes do Veículo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Placa:', veiculo.placa),
              _buildDetailRow('Renavam:', veiculo.renavam),
              _buildDetailRow('Modelo:', veiculo.modelo),
              _buildDetailRow('Ano:', veiculo.anoFabricacao),
              _buildDetailRow('Proprietário:', veiculo.nomeProprietario),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
