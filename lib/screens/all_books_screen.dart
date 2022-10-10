import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../k_constants.dart';
import '../main.dart';
import '../utility/firestore_utility.dart';
import '../utility/reading_utility.dart';
import 'opened_book_screen.dart';

class AllBookScreen extends StatelessWidget {
  AllBookScreen({super.key});
  final readingUtility = Get.put(ReadingUtility());

  final controller = Get.put(FireStoreUtility());

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () => Get.offAll(() => MainScreen())),
        centerTitle: true,
        title:

            ///Title
            Text(
          'جميع القصص',
          style: TextStyle(
              fontFamily: kElMessiri, fontSize: 31, color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          controller.fetchStories(snapshot);
          if (controller.storiesList.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                    childAspectRatio: 0.55),
                itemCount: controller.storiesList.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    ///Image
                    ///
                    GestureDetector(
                      onTapUp: (_) => Get.to(() => OpenBookScreen(
                            bookTitle: controller.storiesList[index]
                                ['storyTitle'],
                          )),
                      onTap: () => readingUtility.extractFromUrl(
                          controller.storiesList[index]['storyContent']),
                      child: Container(
                        width: 250,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  controller.storiesList[index]['storyCover'],
                                ),
                                fit: BoxFit.cover),
                            border: Border.all(width: 1.5),
                            borderRadius: BorderRadius.circular(32),
                            color: const Color.fromARGB(255, 145, 145, 145)),
                      ),
                    ),

                    ///Title
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          '"${controller.storiesList[index]['storyTitle']}"',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontFamily: kElMessiri, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ));
}
