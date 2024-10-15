
import 'package:detranapp/Buttons/ConsultarVeiculoButton.dart';
import 'package:flutter/material.dart';

class VeiculoWidget extends StatelessWidget {
  const VeiculoWidget({
    super.key,
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
          color: const Color.fromARGB(255, 10, 8, 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Column(
              children: [
                ConsultarVeiculoButton(width: widgetWidth, height: widgetHeight * 0.5),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "Veículo",
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: widgetWidth * 0.15 ,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}