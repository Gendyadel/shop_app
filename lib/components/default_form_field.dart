import 'package:flutter/material.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType inputType,
  Function onFieldSubmitted,
  Function onChanged,
  Function onTap,
  Function suffixPressed,
  bool isPassword = false,
  @required Function validator,
  @required String labelText,
  @required IconData prefix,
  IconData suffixIcon,
  isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefix),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixPressed,
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );
