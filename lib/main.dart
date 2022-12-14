// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zaynabiyat/k_constants.dart';
import 'package:zaynabiyat/screens/all_books_screen.dart';
import 'package:zaynabiyat/screens/opened_book_screen.dart';
import 'package:zaynabiyat/utility/firestore_utility.dart';
import 'package:zaynabiyat/utility/reading_utility.dart';
import 'package:zaynabiyat/widgets/cartoon_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(home: MainScreen()),
  );
}

class MainScreen extends StatelessWidget {
  final controller = Get.put(FireStoreUtility());
  MainScreen({super.key});
  CarouselController carouselController = CarouselController();
  final readingUtility = Get.put(ReadingUtility());
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('stories').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            controller.fetchStories(snapshot);
            if (controller.storiesList.isNotEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ///Title
                      Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: Text(
                          'قصص قصيرة',
                          style:
                              TextStyle(fontFamily: kElMessiri, fontSize: 31),
                        ),
                      ),

                      ///carousel
                      CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: controller.storiesList.length,
                        options: CarouselOptions(
                            height: 420.0,
                            enlargeCenterPage: true,
                            viewportFraction: 0.55),
                        itemBuilder: (context, index, realIndex) => Column(
                          children: [
                            ///Image+
                            ///
                            GestureDetector(
                              onTapUp: (_) => Get.to(() => OpenBookScreen(
                                    bookTitle: controller.storiesList[index]
                                        ['storyTitle'],
                                  )),
                              onTap: () => readingUtility.extractFromUrl(
                                  controller.storiesList[index]
                                      ['storyContent']),
                              child: Container(
                                width: 250,
                                height: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          controller.storiesList[index]
                                              ['storyCover'],
                                        ),
                                        fit: BoxFit.cover),
                                    border: Border.all(width: 1.5),
                                    borderRadius: BorderRadius.circular(32),
                                    color: const Color.fromARGB(
                                        255, 145, 145, 145)),
                              ),
                            ),

                            ///Title
                            Flexible(
                              child: Container(
                                margin: const EdgeInsets.only(top: 32),
                                child: Text(
                                  '"${controller.storiesList[index]['storyTitle']}"',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: kElMessiri, fontSize: 31),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///Button
                  CartoonButton(function: (_) => Get.to(() => AllBookScreen()))
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )),
      );
}
