import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pedomanku/models/ayatkursimodel.dart';

class AyatKursi extends StatefulWidget {
  const AyatKursi({Key? key}) : super(key: key);

  @override
  _AyatKursiState createState() => _AyatKursiState();
}

class _AyatKursiState extends State<AyatKursi> {
  Future<AyatKursiModel> fetchSurah() async {
    final response = await http.get(
      Uri.parse("https://islamic-api-zhirrr.vercel.app/api/ayatkursi"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)['data'];
      AyatKursiModel ayat = AyatKursiModel.fromJson(data);
      return ayat;
    } else {
      throw "Gagal Memuat ....";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff44aca0),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      "Ayat Kursi",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Bacaan Ayat Kursi dengan tafsirnya",
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
              child: FutureBuilder<AyatKursiModel>(
                future: AyatKursidata.getAyatKursi(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    AyatKursiModel ayat = snapshot.data!;
                    return ListView(
                      children: [
                        const Center(
                          child: Text(
                            "بِسْمِ اللَّـهِ الرَّحْمَـٰنِ الرَّحِيمِ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Dengan menyebut nama Allah Yang Maha Pemurah lagi Maha Penyayang",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SelectableText(
                          ayat.arabic,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: SelectableText(
                            ayat.latin,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: SelectableText(
                            ayat.translation,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: SelectableText(
                            ayat.tafsir,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
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
          )
        ]));
  }
}
