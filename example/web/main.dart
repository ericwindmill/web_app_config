import 'dart:async';
import 'dart:html';
import 'package:http/browser_client.dart' as http;
import 'package:web_app_config/client.dart';

Future main() async {
  var httpClient = new http.BrowserClient();
  var client = new ConfigClient(httpClient);
  var config = await client.loadConfig();
  querySelector('#output').text = "name: ${config['app_name']}";
}
