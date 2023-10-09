import 'package:flutter/material.dart';
import 'package:live_currency_rate/live_currency_rate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:steam_calculator/game.dart';

import 'package:steam_calculator/homepagebody.dart';
import 'package:steam_calculator/results.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Game littleGame = Game();

  final textStyle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    void showGameValue(Game game) {
      setState(() {
        littleGame = game;
      });
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 178, 189, 209),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Container(
                  height: 225.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/img.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 360,
                  top: 40,
                  child: IconButton(
                    onPressed: () async {
                      await Share.share(
                          '¿Querés saber cuál es el valor final de tu juego? Te recomiendo esta app para calcular el aproximado. Descargala en playstore: https://play.google.com/store/apps/details?id=com.luchofmartinez.steam_calculator');
                    },
                    icon: const Icon(Icons.share_outlined, color: Colors.white),
                  ),
                ),
                Positioned(
                  left: 360,
                  top: 80,
                  child: IconButton(
                    onPressed: () async { 
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          elevation: 2,
                          title: const Text('Calculadora IVA Steam'),
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Los precios calculados son aproximados. \r\nCualquier error puede ser enviado a luchofmartinez@gmail.com\r\n',
                                    style: textStyle,
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 185, 10, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 400,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.teal[100],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: HomePageBody(showGameData: showGameValue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            littleGame.taxes != null
                ? ResultsWidget(taxes: littleGame.taxes!)
                : Container(),
            if (littleGame.value != null)
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColorLight),
                child: Row(
                  children: [
                    Text(
                      'Total \$${littleGame.value!.toStringAsFixed(2)}',
                      style: textStyle,
                    ),
                  ],
                ),
              )
            else
              Container(),
          ],
        ),
      ),
    );
  }
}
