import 'package:detranapp/Pages/Publi/PubliPage.dart';
import 'package:flutter/material.dart';

class Publiwidget extends StatelessWidget {
  const Publiwidget({
    super.key,
  });

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double widgetWidth = constraints.maxWidth;
        double widgetHeight = constraints.maxHeight;

        return Container(
          width: widgetWidth,
          height: widgetHeight,
          color: Color(0xFF6D7C8C),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Publipage()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.feed_outlined,
                  size: widgetHeight * 0.5,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  "Publicações",
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
