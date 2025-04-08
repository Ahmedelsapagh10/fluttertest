import 'dart:async';
import 'package:fluttertest/core/exports.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../core/preferences/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() {
    _checkLoginStatus();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(seconds: 3, milliseconds: 500),
      () {
        _goNext();
      },
    );
  }

  /// Check if the user is logged in and navigate accordingly
  Future<void> _checkLoginStatus() async {
    String? token = HiveManager.getUserToken();

    if (token != null) {
      // Navigate to the home screen if the token exists
      Navigator.pushReplacementNamed(context, Routes.mainRoute);
    } else {
      // Navigate to the login screen if the token does not exist
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }

  @override
  void initState() {
    super.initState();

    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: SizedBox(
                child: Image.asset(
                  ImageAssets.logoImage,
                  height: getWidthSize(context) / 2.5,
                  width: getWidthSize(context) / 2.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //   },
    // );
  }
}
