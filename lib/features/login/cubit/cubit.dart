import 'package:easy_localization/easy_localization.dart';

import 'package:fluttertest/core/utils/appwidget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../../core/preferences/user_model.dart';

import '../data/login_repo.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api) : super(LoginStateInitial());
  LoginRepo api;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //! Login Method
  Future<void> login(BuildContext context) async {
    AppWidget.createProgressDialog(context);

    emit(LoadingLoginState());
    final res = await api.login(emailController.text, passwordController.text);

    res.fold((l) {
      errorGetBar('error_login'.tr());
      Navigator.pop(context);
      emit(ErrorLoginState());

      //!
    }, (r) async {
      emit(LoadedLoginState());
      if (r.token != null) {
        final userBox = Hive.box('userModelBox');
        userBox.put('user', UserModel(token: r.token));
        // await Preferences.instance.setUser(r);
        successGetBar('success_login'.tr());
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.mainRoute, (route) => false);
      } else {
        errorGetBar('error_login'.tr());
        emit(ErrorLoginState());
      }
    });
  }


}
