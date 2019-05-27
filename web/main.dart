import 'package:flutter_web_ui/ui.dart' as ui;
import 'package:pr_assigner/main.dart' as app;

main() async {
  await ui.webOnlyInitializePlatform();
  app.main();
}
