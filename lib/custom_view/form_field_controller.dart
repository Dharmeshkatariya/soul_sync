import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FormFieldController {
  String? id;
  var textEditingController = TextEditingController();
  dynamic selectedValue;
  var errorMessage = ''.obs;
  var isMandatory = false.obs;
  var obscureText = true.obs;

  FormFieldController({this.id, this.selectedValue});
}
