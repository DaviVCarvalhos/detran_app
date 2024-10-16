
import 'package:detranapp/Pages/Leil%C3%A3oPage.dart';
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
          color: const Color.fromARGB(255, 52, 58, 64),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LeilaoPage()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Icon(
                  Icons.gavel,
                  size: widgetHeight * 0.5, // Define o tamanho do ícone
                  color: Colors.white,
                ),
                SizedBox(height: 10), // Espaço entre o ícone e o texto
                Text(
                  "Leilão",
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
