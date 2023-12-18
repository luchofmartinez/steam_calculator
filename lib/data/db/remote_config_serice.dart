import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoteConfigService {
  Future<void> checkForUpdates(BuildContext context) async {
    PackageInfo info = await PackageInfo.fromPlatform();

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    // remoteConfig.setDefaults({});
    // remoteConfig.fetch();
    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
    });
    var algo = remoteConfig.getString('config');
    Map<String, dynamic> jsonMap = json.decode(algo);

    if (int.parse(jsonMap['buildNumber']) > int.parse(info.buildNumber)) {
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Nueva version pa'),
            content: const Text(
                'Existe una nueva version en el play store.\r\nOK para actualizar'),
            actions: [
              TextButton(
                onPressed: () async {
                  openPlayStore();
                },
                child: const Text('Ok'),
              )
            ],
          );
        },
      );
    }
  }

  void openPlayStore() async {
    const String packageName = 'com.luchofmartinez.steam_calculator'; // Paquete de Play Store
    const String url = 'http://play.google.com/store/apps/details?id=$packageName';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('No se pudo abrir Play Store');
    }
  }
}
