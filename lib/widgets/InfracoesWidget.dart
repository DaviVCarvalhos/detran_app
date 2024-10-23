import 'package:detranapp/Buttons/InfracoesButton.dart';
import 'package:flutter/material.dart';

class InfracoesWidget extends StatelessWidget {
  const InfracoesWidget({
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
          color: Color(0xFFdc3545),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Column(
              children: [
                InfracoesButton(width: widgetWidth, height: widgetHeight * 0.5),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "Infrações",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widgetWidth * 0.15,
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
