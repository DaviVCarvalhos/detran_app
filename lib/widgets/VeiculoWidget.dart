import 'package:detranapp/Pages/Veiculo/VeiculoPage.dart';
import 'package:detranapp/models/User.dart';
import 'package:detranapp/models/Veiculo.dart';
import 'package:flutter/material.dart';

class VeiculoWidget extends StatelessWidget {
  final User user;

  const VeiculoWidget({
    super.key,
    required this.user,
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
          color: const Color(0xFF2196F3),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VeiculoPage(
                    user: null,
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
