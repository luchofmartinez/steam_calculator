import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      top: 40,
      child: IconButton(
        onPressed: () async {
          await Share.share(
              '¿Querés saber cuál es el valor final de tu juego? Te recomiendo esta app para calcular el aproximado. Descargala en playstore: https://play.google.com/store/apps/details?id=com.luchofmartinez.steam_calculator');
        },
        icon: const Icon(Icons.share_outlined, color: Colors.white),
      ),
    );
  }
}
