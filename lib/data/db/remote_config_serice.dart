import 'dart:convert'; 

import 'package:firebase_remote_config/firebase_remote_config.dart'; 

class RemoteConfigService {
  Future<int> checkForUpdates() async { 

    final remoteConfig = FirebaseRemoteConfig.instance; 

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    )); 

    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
    });
    String config = remoteConfig.getString('config'); 
    Map<String, dynamic> jsonConfig = json.decode(config);
    int versionBuild = int.parse(jsonConfig['buildNumber']); 

    return versionBuild;
  }

  
}
