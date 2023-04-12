import 'package:animal_app/Model/animal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Model/global.dart';
import '../../../Helper/animal_DB_helper.dart';

class detail_page extends StatefulWidget {
  const detail_page({Key? key}) : super(key: key);

  @override
  State<detail_page> createState() => _detail_pageState();
}

int val = 0;

class _detail_pageState extends State<detail_page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    val = 0;
  }

  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    animal() {}
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text(
            "${res['name']}".toUpperCase(),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true),
      body: FutureBuilder(
        future: Animal_db.animal_db.fetchAllRecode(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("error is =${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            global.Animal_Detail = snapshot.data?.cast<Animal_Modal>();
            print(global.Animal_Detail);
            return ListView.builder(
              itemCount: global.Animal_Detail!.length,
              itemBuilder: (context, i) {
                return Card(
                    elevation: 10,
                    margin: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            global.imageCount = i + val;
                            Navigator.of(context).pushNamed('image_detail_page',
                                arguments: global.Animal_Detail![i]);
                          },
                          child: Container(
                              height: 500,
                              width: double.maxFinite,
                              decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    child: Image.network(
                                      "${global.Images![i + val].Image}",
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, 110),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 281,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                        Colors.transparent.withOpacity(0.5),
                                        Colors.black.withOpacity(0.5),
                                      ])),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name : ${global.Animal_Detail![i].name}",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                              "Loction : ${global.Animal_Detail![i].loction}",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                          Text(
                                            "Color : ${global.Animal_Detail![i].color}",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          Text(
                                              "Skin Type : ${global.Animal_Detail![i].skin_type}",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                          Text(
                                              "Lifespan : ${global.Animal_Detail![i].lifespan}",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                          Text(
                                              "Average Litter Size : ${global.Animal_Detail![i].average_litter_size}",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                          Text(
                                              "Diet : ${global.Animal_Detail![i].diet}",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                          Text(
                                              "Type : ${global.Animal_Detail![i].type}",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                          ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              child: Container(
                                                height: 40,
                                                width: 390,
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            val++;
                                                          });
                                                        },
                                                        child: Icon(Icons.add)),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Clipboard.setData(
                                                          ClipboardData(
                                                              text:
                                                                  "Name : ${global.Animal_Detail![i].name}"),
                                                        );
                                                      },
                                                      child: Icon(Icons.copy),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {},
                                                      child: Icon(Icons.share),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () async {
                                                          //
                                                        },
                                                        child: Icon(
                                                            Icons.download)),
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Icon(Icons.star),
                                                    )
                                                  ],
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        )
                      ],
                    ));
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
