import 'dart:io';
import 'dart:async' show Future, runZoned;
import 'package:path/path.dart' show join, dirname;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';
import 'package:web_app_config/server.dart' as wconfig;

const List<String> supportedKeys = const <String>[
  'app_name',
  'app_description',
  'app_version',
];

Future main() async {
  await wconfig.writeConfigFromEnvironment(supportedKeys);
  // Assumes the server lives in bin/ and that `pub build` ran
  var pathToBuild =
      join(dirname(Platform.script.toFilePath()), '..', 'build/web');

  var staticHandler = createStaticHandler(pathToBuild,
      defaultDocument: 'index.html', serveFilesOutsidePath: true);

  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 9999 : int.parse(portEnv);

  runZoned(() => runServer(staticHandler, pathToBuild, port),
      onError: (e, stackTrace) => print('Server error: $e $stackTrace'));
}

Future<Null> runServer(
    shelf.Handler staticHandler, String pathToBuild, int port) async {
  await shelf_io.serve(staticHandler, '0.0.0.0', port);
  print("Serving $pathToBuild on port $port");
}
