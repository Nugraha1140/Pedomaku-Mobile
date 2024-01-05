import 'package:flutter/material.dart';
import 'package:pedomanku/models/doamodel.dart';

class BacaanDoa extends StatefulWidget {
  const BacaanDoa({Key? key}) : super(key: key);

  @override
  _BacaanDoaState createState() => _BacaanDoaState();
}

class _BacaanDoaState extends State<BacaanDoa> {
  // Future<List<ModelDoa>?> fetchDoa() async {
  //   final response = await http.get(
  //     Uri.parse("https://islamic-api-zhirrr.vercel.app/api/doaharian"),
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = jsonDecode(response.body);
  //     final List<dynamic> doaData = data['data'];
  //     List<ModelDoa> doa =
  //         doaData.map((dynamic item) => ModelDoa.fromJson(item)).toList();
  //     return doa;
  //   } else {
  //     throw "Gagal Memuat ....";
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
                      "Bacaan Doa",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Bacaan Doa Sehari-hari",
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
              child: FutureBuilder<List<ModelDoa>?>(
                future: DoaList.getDoa(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    List<ModelDoa>? doaList = snapshot.data;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: doaList!.length,
                      itemBuilder: (context, index) {
                        ModelDoa doa = doaList[index];
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
                                doa.title,
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
                                            doa.arabic,
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
                                            left: 8, right: 8),
                                        child: Text(
                                          doa.latin,
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
                                          doa.translation,
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
