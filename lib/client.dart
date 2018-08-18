/// Support for doing something awesome.
///
/// More dartdocs go here.
library web_app_config;

import 'dart:async';
import "package:http/http.dart";
import "package:yaml/yaml.dart";
import "package:dart2_constant/convert.dart";

class ConfigClient {
  final Client _client;
  ConfigClient(this._client);
  Future<Map<String, dynamic>> loadConfig() async {
    // Try to fetch the generated config.json file, otherwise, fetch the
    // config.yaml file
    try {
      return await _loadJson();
    } catch (e) {}
    try {
      return await _loadYaml();
    } catch (e) {
      print(e);
    }
    throw("No config.json or config.yaml found in root directory."
        "Please add a config.json or config.yaml file to the web/ "
        "directory of your app.");
  }

  Future<dynamic> _loadJson() async {
    var response = await _client.get('./config.json');
    var body = response.body;
    return json.decode(body);
  }

  Future<dynamic> _loadYaml() async {
    var response = await _client.get('./config.yaml');
    var body = response.body;
    return new Map<String, dynamic>.from(loadYaml(body));
  }
}