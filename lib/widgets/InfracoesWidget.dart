import 'package:detranapp/Pages/InfracoesPage.dart';
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
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfracoesPage()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Icon(
                  Icons.local_police,
                  size: widgetHeight * 0.5, 
                  color: Colors.white,
                ),
                SizedBox(height: 10), 
                Text(
                  "Infrações",
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