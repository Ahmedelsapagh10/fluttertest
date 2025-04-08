import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/core/exports.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/get_size.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.title,
  });
  final void Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getWidthSize(context) / 12,
          vertical: getWidthSize(context) / 32),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(getWidthSize(context) / 12),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(getWidthSize(context) / 32),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(getWidthSize(context) / 12),
          ),
          child: AutoSizeText(
            title,
            maxLines: 1,
            style: TextStyle(
              color: AppColors.white,
              fontFamily: AppStrings.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
