import 'package:fluttertest/core/exports.dart';
import 'package:fluttertest/core/widgets/custom_button.dart';

import 'package:fluttertest/features/login/cubit/cubit.dart';
import 'package:fluttertest/features/login/cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          var cubit = context.read<LoginCubit>();
          return Scaffold(
              backgroundColor: AppColors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImageAssets.appIcon,
                        width: getWidthSize(context) / 5,
                      ),
                      Text(
                        'login'.tr(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'welcome'.tr(),
                            style: TextStyle(
                              color: AppColors.greyTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              'app_name'.tr(),
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            ' . ',
                            style: TextStyle(
                              color: AppColors.greyTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      22.h.verticalSpace,
                      CustomTextFormField(
                        title: 'email'.tr(),
                        isBlackHint: false,
                        isDropDown: true,
                        controller: cubit.emailController,
                        hintText: 'enter_email'.tr(),
                      ),
                      12.h.verticalSpace,
                      CustomTextFormField(
                        title: 'password'.tr(),
                        isDropDown: true,
                        isBlackHint: false,
                        isPassword: true,
                        controller: cubit.passwordController,
                        hintText: 'enter_password'.tr(),
                      ),

                      32.h.verticalSpace,

                      CustomButton(
                        title: 'login'.tr(),
                        onTap: () {
                          cubit.login(context);
                        },
                      ),
                      // Center(child: ShowLoadingIndicator()),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
