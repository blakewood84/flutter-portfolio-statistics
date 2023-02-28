import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    this.initialValue = '',
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.hintText,
    this.onFieldSubmitted,
    Key? key,
  }) : super(key: key);

  final String initialValue;
  final Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final Function(String value)? onFieldSubmitted;
  final Widget? prefixIcon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.blueGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.blueAccent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
