import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReadingUtility extends GetxController {
  // page Colors
  Color softOrange = const Color.fromARGB(255, 255, 246, 241);
  Color softViolet = const Color(0xFFFBF3FF);
  Color softgrey = const Color(0xFF595959);
  //page font size
  var fontSize = 14.0.obs;
  //page scrolling direction
  var storyText = ''.obs;
  void extractFromUrl(String url) async {
    await http
        .get(Uri.parse(url))
        .then((value) => storyText.value = utf8.decode(value.bodyBytes));
  }
}
