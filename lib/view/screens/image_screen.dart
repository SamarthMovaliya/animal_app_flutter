import 'dart:io';
import 'dart:typed_data';
import '../../Model/global.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class image_detail_page extends StatefulWidget {
  const image_detail_page({Key? key}) : super(key: key);

  @override
  State<image_detail_page> createState() => _image_detail_pageState();
}

int i = 0;
ScreenshotController screenshotController = ScreenshotController();

class _image_detail_pageState extends State<image_detail_page> {
  @override
  Widget build(BuildContext context) {
    double _heght = MediaQuery.of(context).size.height;
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Screenshot(
            controller: screenshotController,
            child: Container(
              color: Colors.blueAccent,
              height: _heght,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    "${global.Images![global.imageCount + i].Image}",
                    height: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.8),
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                            "Name : ${global.Animal_Detail![global.imageCount].name}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic)),
                        Text(
                            "Loction : ${global.Animal_Detail![global.imageCount].loction}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic)),
                        Text(
                            "Color : ${global.Animal_Detail![global.imageCount].color}",
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic)),
                        Text(
                            "Skin Type : ${global.Animal_Detail![global.imageCount].skin_type}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic)),
                        Text(
                            "Lifespan : ${global.Animal_Detail![global.imageCount].lifespan}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic)),
                        Text(
                            "Average Litter Size : ${global.Animal_Detail![global.imageCount].average_litter_size}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic)),
                        Text(
                            "Diet : ${global.Animal_Detail![global.imageCount].diet}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic)),
                        Text(
                            "Type : ${global.Animal_Detail![global.imageCount].type}",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic)),
                        SizedBox(height: 5),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        i++;
                      });
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.save,
                      color: Colors.white,
                    )),
                InkWell(
                    onTap: () async {
                      final image = await screenshotController.capture();
                      if (image == null) return;

                      await saveImage(image);
                      saveAndShare(image);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                InkWell(
                    onTap: () async {
                      final image = await screenshotController.capture();
                      if (image == null) return;

                      await saveImage(image);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Image Is Save In Album"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                      ));
                    },
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    )),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.satellite_outlined,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget isRow({required String image}) {
    return Image.asset("$image", width: 40);
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = "screenshot_$time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }
}
