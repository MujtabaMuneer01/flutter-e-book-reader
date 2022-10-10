import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zaynabiyat/k_constants.dart';
import '../main.dart';
import '../utility/reading_utility.dart';

// ignore: must_be_immutable
class OpenBookScreen extends StatelessWidget {
  String bookTitle;

  OpenBookScreen({super.key, required this.bookTitle});

  ReadingUtility readingUtility = Get.put(ReadingUtility());

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Color(0XFFA49A9A),
              ),
              onTap: () => Navigator.pop(context)),
          elevation: 0,
          shadowColor: null,
          backgroundColor: Colors.white,
          centerTitle: true,
          title:

              ///Story Title
              Text(
            bookTitle,
            style: TextStyle(
                fontFamily: kElMessiri,
                fontSize: 20,
                color: const Color(0XFFA49A9A)),
          ),
        ),
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(left: 40, right: 40, top: 32),
          child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Obx(() => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 38, vertical: 32),
                      child: Text(
                        readingUtility.storyText.value,
                        style: TextStyle(fontFamily: kElMessiri, fontSize: 15),
                        textAlign: TextAlign.right,
                      ),
                    ))
              ]),
        )),
      );
}
