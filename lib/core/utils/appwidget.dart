import 'package:fluttertest/core/exports.dart';

import '../widgets/show_loading_indicator.dart';

class AppWidget {
  static createProgressDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const CustomLoadingIndicator();
        });
  }
}
