import 'package:flutter/material.dart';
import 'package:steam_calculator/data/db/remote_config_serice.dart';
import 'package:steam_calculator/game.dart';

import 'package:steam_calculator/homepagebody.dart';
import 'package:steam_calculator/image_background.dart';
import 'package:steam_calculator/info_button_widget.dart';
import 'package:steam_calculator/results.dart';
import 'package:steam_calculator/share_button_widget.dart';

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
  void initState() {
    checkUpdates();
    // TODO: implement initState
    super.initState();
  }

  void checkUpdates() async {
    await RemoteConfigService().checkForUpdates(context);
  }

  @override
  Widget build(BuildContext context) {
    void showGameValue(Game game) {
      setState(() {
        littleGame = game;
      });
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 178, 189, 209),
      bottomSheet: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Theme.of(context).primaryColorLight),
        child: Row(
          children: [
            littleGame.value != null && littleGame.value! > 0
                ? Text(
                    'Total \$${littleGame.value!.toStringAsFixed(2)}',
                    style: textStyle,
                  )
                : Text(
                    'Total \$0.00',
                    style: textStyle,
                  )
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  const ImageBackGround(),
                  const ShareButton(),
                  const InfoButton(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 185, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
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
              // if (littleGame.value != null)
              //   Positioned(
              //     bottom: 0,
              //     child: Container(
              //       alignment: Alignment.centerLeft,
              //       width: double.infinity,
              //       height: 50,
              //       padding: const EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //           color: Theme.of(context).primaryColorLight),
              //       child: Row(
              //         children: [
              //           Text(
              //             'Total \$${littleGame.value!.toStringAsFixed(2)}',
              //             style: textStyle,
              //           ),
              //         ],
              //       ),
              //     ),
              //   )
              // else
              //   Container(),
            ],
          ),
        ),
      ),
    );
  }
}
