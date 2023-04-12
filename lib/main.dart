import 'dart:math';
import 'package:animal_app/Model/image_model.dart';
import 'package:animal_app/view/screens/detail_page.dart';
import 'package:animal_app/view/screens/home_page.dart';
import 'package:animal_app/view/screens/image_screen.dart';

import 'Model/global.dart';
import 'package:animal_app/Helper/image_API_helper.dart';
import 'package:flutter/material.dart';

Random random = Random();

void main() async {
  int i = random.nextInt(7);
  global.Images = (await Image_api.image_api
          .feach_Data(Animal_name: "${global.Animal_name[i]['name']}"))
      ?.cast<Image_Modal>();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => home(),
        'detail_page': (context) => detail_page(),
        'image_detail_page': (context) => image_detail_page(),
      },
    ),
  );
}
