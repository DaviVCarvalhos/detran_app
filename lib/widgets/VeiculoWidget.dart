import 'package:detranapp/Pages/Veiculo/VeiculoPage.dart';
import 'package:detranapp/models/User.dart';
import 'package:detranapp/models/Veiculo.dart';
import 'package:flutter/material.dart';

class VeiculoWidget extends StatelessWidget {
  final User user;
  final Function(Veiculo) onVeiculoAdicionado;

  const VeiculoWidget({
    super.key,
    required this.user,
    required this.onVeiculoAdicionado,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double widgetWidth = constraints.maxWidth;
        double widgetHeight = constraints.maxHeight;

        return Container(
          width: widgetWidth,
          height: widgetHeight,
          color: const Color.fromARGB(255, 53, 114, 175),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VeiculoPage(
                    user: user,
                    onVeiculoAdicionado: onVeiculoAdicionado,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_car,
                  size: widgetHeight * 0.5,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  "Veículo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widgetHeight * 0.15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
