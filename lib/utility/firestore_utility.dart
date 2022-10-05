import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FireStoreUtility extends GetxController {
  var storiesList = [].obs;
  fetchStories(AsyncSnapshot snapshot)   {

    if (!snapshot.hasData) {
      return const SizedBox();
    }
 
      List storiesSnapShots = snapshot.data!.docs;
    for (var story in storiesSnapShots) {
      storiesList.add(story);
    }
    
  }
}
