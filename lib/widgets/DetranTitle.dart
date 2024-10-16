import 'package:flutter/material.dart';

class DetranTitle extends StatelessWidget {
  const DetranTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'images/detranlogo.jpg',
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              
              
              Transform.translate(
                offset: Offset(2, 2), 
                child: Text(
                  "DETRAN/RN",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5), 
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ),
              
              Text(
                "DETRAN/RN",
                style: TextStyle(
                  color: Colors.white, // Cor do texto
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}