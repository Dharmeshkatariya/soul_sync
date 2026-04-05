import 'package:flutter/services.dart';

class CustomInputFormatters {
  static final TextInputFormatter stringOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));
  static final TextInputFormatter numbersOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
}
