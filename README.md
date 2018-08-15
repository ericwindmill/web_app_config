# web_app_config

Tools to configure Dart web apps using environment variables.

## Example

The example/ directory contains an example project.

When the server runs, it writes a config.json file based on
the desired environment variables:

```dart
const List<String> supportedKeys = const <String>[
  'app_name',
  'app_description',
  'app_version',
];

Future main() async {
  await wconfig.writeConfigFromEnvironment(supportedKeys);
  // ...
```

Then, when the client runs, that configuration can be loaded
and parsed into a map:

```
const List<String> supportedKeys = const <String>[
  'app_name',
  'app_description',
  'app_version',
];

Future main() async {
  await wconfig.writeConfigFromEnvironment(supportedKeys);
```

When app is run in development mode, (`pub serve` or `webdev serve`) the
configuration is loaded from `web/config.yaml`

```bash
pub build # Dart 2: webdev build

dart bin/server.dart

# observe the app says "name: my awesome app", configured in config.yaml

# stop server

export APP_NAME="i am configured using an env var"

dart bin/server.dart

# observe the app now says "name: i am configured using an env var" 

# stop server

unset APP_NAME

dart bin/server.dart

# observe the app says "name: my awesome app" again

```

