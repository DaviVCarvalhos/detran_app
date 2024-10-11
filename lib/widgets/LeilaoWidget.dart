
import 'package:detranapp/Buttons/Leil%C3%A3oButton.dart';
import 'package:flutter/material.dart';

class LeilaoWidget extends StatelessWidget {
  const LeilaoWidget({
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
          color: const Color.fromARGB(255, 252, 0, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Column(
              children: [
                LeilaoButton(width: widgetWidth, height: widgetHeight * 0.5),
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Text(
                    "Leilão",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widgetHeight *0.15,
                       
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