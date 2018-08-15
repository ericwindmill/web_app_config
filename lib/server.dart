import 'dart:async';
import 'dart:io';

import 'package:dart2_constant/convert.dart';
import 'package:yaml/yaml.dart';

/// Reads environment variables and writes a JSON configuration file to web/config.json
Future writeConfigFromEnvironment(List<String> supportedKeys) async {
  var yamlFile = new File('build/web/config.yaml');
  var yamlStr = yamlFile.readAsStringSync();
  var yamlJson = loadYaml(yamlStr);

  // apply any environment variables to the existing runtime config
  var environmentMap = <String, String>{};
  List<String> toRemove = [];
  for (var key in Platform.environment.keys) {
    if (supportedKeys.contains(key.toLowerCase())) {
      environmentMap[key.toLowerCase()] = Platform.environment[key];
    }
  }

  for (var key in toRemove) {
    environmentMap.remove(key);
  }

  var newConfig = new Map.from(yamlJson)..addAll(environmentMap);

  var jsonStr = json.encode(newConfig);
  var jsonFile = new File('build/web/config.json');
  await jsonFile.writeAsString(jsonStr);
}