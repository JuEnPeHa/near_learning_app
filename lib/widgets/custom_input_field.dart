import 'package:flutter/material.dart';
import 'package:near_learning_app/theme/app_theme.dart';

class CustomInputField extends StatelessWidget {
  final String hintText, labelText, helperText, formProperty;
  final double fontSize;
  final FocusNode? focusNode, nextFocusNode;

  final IconData? icon, prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool borderEnabled;
  bool obscureText;
  final bool isPassword;

  final Map<String, String> formValues;
  //final void Function(String text)? onChanged;

  final String? Function(String? text)? validator;

  CustomInputField(
      {Key? key,
      this.hintText = "",
      this.labelText = "",
      this.helperText = "",
      this.icon,
      required this.isPassword,
      this.suffixIcon,
      this.prefixIcon,
      //this.onChanged,
      this.fontSize = 15,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      required this.formProperty,
      required this.formValues,
      this.borderEnabled = true,
      this.validator,
      this.focusNode,
      this.nextFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: focusNode ?? null,
        autofocus: false,
        textCapitalization: TextCapitalization.words,
        onFieldSubmitted: nextFocusNode != null
            ? (value) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              }
            : null,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: (value) {
          if (isPassword) {
            formValues[formProperty] = value.trim();
          } else {
            formValues[formProperty] = value;
          }
        },
        validator: validator,
        style: TextStyle(fontSize: fontSize),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          filled: AppTheme.lightTheme.inputDecorationTheme.filled,
          fillColor: AppTheme.lightTheme.inputDecorationTheme.fillColor,
          hintText: hintText,
          labelText: labelText,
          floatingLabelStyle:
              AppTheme.lightTheme.inputDecorationTheme.floatingLabelStyle,
          contentPadding: prefixIcon == null
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              : const EdgeInsets.symmetric(vertical: 10),
          enabledBorder: AppTheme.lightTheme.inputDecorationTheme.enabledBorder,
          // borderEnabled
          //     ? OutlineInputBorder(
          //         borderSide: const BorderSide(color: AppTheme.primary),
          //         borderRadius: BorderRadius.circular(15),
          //       )
          //     : InputBorder.none,
          labelStyle: TextStyle(
              fontSize: fontSize,
              color: Colors.black45,
              fontWeight: FontWeight.w500),
          helperText: helperText,
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
          suffixIcon: suffixIcon == null ? null : suffixIcon,
          icon: icon == null ? null : Icon(icon),
        ));
  }
}
