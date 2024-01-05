import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedomanku/models/sholatmodel.dart';

class BacaanSholat extends StatefulWidget {
  const BacaanSholat({Key? key}) : super(key: key);

  @override
  _BacaanSholatState createState() => _BacaanSholatState();
}

class _BacaanSholatState extends State<BacaanSholat> {
  // Future<List<ModelSholat>> fetchBacaan() async {
  //   final response = await http.get(
  //     Uri.parse("https://islamic-api-zhirrr.vercel.app/api/bacaanshalat"),
  //   );

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     List<ModelSholat> bacaan =
  //         data.map((item) => ModelSholat.fromJson(item)).toList();
  //     return bacaan;
  //   } else {
  //     throw Exception('Gagal Memuat ....');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff44aca0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chevron_left_rounded,
                      size: 30,
                      color: Colors.white,
                    )),
                const Column(
                  children: [
                    Text(
                      "Bacaan Sholat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Bacaan sholat dari doa Iftitah sampai Salam",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder<List<ModelSholat>>(
                future: BacaSholatData.getBacaanSholat(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    List<ModelSholat> bacaanList = snapshot.data!;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: bacaanList.length,
                      itemBuilder: (context, index) {
                        ModelSholat bacaan = bacaanList[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              title: Text(
                                bacaan.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            bacaan.arabic,
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                        ),
                                        child: Text(
                                          bacaan.latin,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 5,
                                        ),
                                        child: Text(
                                          bacaan.terjemahan,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
