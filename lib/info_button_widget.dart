import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      top: 80,
      child: IconButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              elevation: 2,
              title: const Text('Calculadora IVA Steam'),
              children: const [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Los precios calculados son aproximados. \r\nCualquier error puede ser enviado a luchofmartinez@gmail.com\r\n',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        icon: const Icon(Icons.info_outline, color: Colors.white),
      ),
    );
  }
}
