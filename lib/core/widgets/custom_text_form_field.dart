import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/services.dart';

import '../exports.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final int maxLines;
  final bool isPassword;
  final bool isPhone;
  final TextEditingController? controller;
  final bool? isBlackHint;
  final bool enabled;
  final bool showCursor;
  final bool isDropDown;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final bool? isMessage;
  final String? hintText;
  final bool isOption;
  final bool hideTitle;
  final bool isChoosen;
  final String countryCode; // Add country code parameter
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final void Function()? onTap;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextFormField({
    super.key,
    required this.title,
    this.borderColor,
    this.isPassword = false,
    this.showCursor = true,
    this.isPhone = false,
    this.isOption = false,
    this.hideTitle = false,
    this.backgroundColor,
    this.isDropDown = false,
    this.isBlackHint,
    this.controller,
    this.onTap,
    this.isChoosen = false,
    this.hintText,
    this.maxLines = 1,
    this.isMessage = false,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.inputFormatters,
    this.countryCode = '+966',
    this.initialValue, // Default to Saudi Arabia
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        if (!widget.hideTitle)
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: AppStrings.fontFamily,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackTextColor,
                  height: 1.71,
                ),
              ),
              // if (widget.isOption)
              Padding(
                padding: EdgeInsetsDirectional.only(start: 5.w),
                child: Text(
                  widget.isOption
                      ? '*'
                      : widget.isChoosen
                          ? 'optional'.tr()
                          : "",
                  style: TextStyle(
                    fontSize: widget.isOption ? 16.sp : 14.sp,
                    height: 1.71,
                    fontWeight:
                        widget.isOption ? FontWeight.bold : FontWeight.w400,
                    color: widget.isOption ? AppColors.red : AppColors.gray,
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: widget.onTap,
          child: TextFormField(
            onTap: widget.onTap,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            maxLines: widget.maxLines,
            inputFormatters: widget.inputFormatters ?? [],
            showCursor: widget.showCursor,
            controller: widget.controller,
            keyboardType: widget.keyboardType != null
                ? widget.keyboardType
                : widget.isPhone
                    ? TextInputType.phone
                    : TextInputType.text,
            obscuringCharacter: '*',
            obscureText: widget.isPassword && !_showPassword,
            onChanged: widget.onChanged,
            validator: widget.isPhone ? _validatePhoneNumber : widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: widget.isBlackHint == true
                    ? AppColors.black
                    : AppColors.gray,
              ),
              filled: true,
              enabled: widget.enabled,
              fillColor: widget.backgroundColor ?? AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.white,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 6.h,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.white,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.white,
                ),
              ),
              suffixIcon: widget.isPhone
                  ? Container(
                      padding: EdgeInsetsDirectional.only(
                          end: 8.w), // splashColor: AppColors.transparent,
                      // splashRadius: 1,
                      // disabledColor: AppColors.transparent,
                      // onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.countryCode,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.blackLite,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: widget.isDropDown
                                ? AppColors.blackLite
                                : AppColors.gray,
                          )
                        ],
                      ),
                    )
                  : _getSuffixIcon(),
            ),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: widget.isDropDown ? FontWeight.w500 : FontWeight.w400,
              height: 1.71,
              fontFamily: AppStrings.fontFamily,
              color: widget.isDropDown ? AppColors.black : AppColors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        onPressed: () => setState(() => _showPassword = !_showPassword),
        icon: Icon(
          _showPassword ? Icons.visibility_off : Icons.visibility,
          color: AppColors.gray,
        ),
      );
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'phone_number_validation'.tr();
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'phone_number_validation'.tr();
      // return 'invalid_phone_format'.tr();
    }
    if (value.length != 9) {
      return 'phone_number_validation'.tr();
      // return 'phone_length_validation'.tr();
    }
    if (!value.startsWith('5')) {
      return 'phone_number_validation'.tr();
      // return 'phone_start_with_validation'.tr();
    }
    return null;
  }
}
