import 'dart:convert';
import 'package:animal_app/Model/image_model.dart';

import '../../Model/global.dart';
import '../../Helper/animal_DB_helper.dart';
import '../../Helper/image_API_helper.dart';
import '../../Model/animal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu_rounded,
          color: Colors.black,
        ),
        title: Text(
          'Animal App',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, i) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () async {
                    global.inint = i;

                    global.Images = (await Image_api.image_api.feach_Data(
                            Animal_name: "${global.Animal_name[i]['name']}"))
                        ?.cast<Image_Modal>();
                    Navigator.of(context).pushNamed('detail_page',
                        arguments: global.Animal_name[i]);
                    String Jsondata = await rootBundle
                        .loadString("assets/json_data/my_json_data.json");
                    Map decodedData = jsonDecode(Jsondata);
                    List data = decodedData["${global.Animal_name[i]['name']}"];
                    print(data.length);
                    Animal_db.animal_db.deleteAllData();
                    data.forEach((e) async {
                      Animal_Modal a1 = Animal_Modal(
                          name: e['name'],
                          color: e['characteristics']['color'],
                          average_litter_size: e['characteristics']
                              ['average_litter_size'],
                          loction: e['locations'][0],
                          skin_type: e['characteristics']['skin_type'],
                          lifespan: e['characteristics']['lifespan'],
                          type: e['characteristics']['type'],
                          diet: e['characteristics']['diet']);

                      int? res =
                          await Animal_db.animal_db.inserRecode(data: a1);
                      print(res);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "${global.Animal_name[i]['image']}",
                            height: 250,
                            fit: BoxFit.fitHeight,
                          ),
                          Transform.translate(
                            offset: Offset(0, 100),
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(2, 3),
                                      blurRadius: 5,
                                    )
                                  ]),
                              child: Text(
                                "${global.Animal_name[i]['name']}"
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                  letterSpacing: 3,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: global.Animal_name.length),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
            ),
          )
        ],
      ),
    );
  }
}
