import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:pedomanku/page/ayatkursi_page.dart';
import 'package:pedomanku/page/main_page.dart';
import 'package:pedomanku/theme.dart';
import 'package:ionicons/ionicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  bool _isHiddenPassword = true;
  bool _isLoading = false;

  showHide() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  static var client = http.Client();
  static final getStorage = GetStorage();

  Future<String> login(String username, String password) async {
    var data = {"username": username, "password": password};
    var response = await client.post(
      Uri.parse('http://103.150.191.149:444/login_clients'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    try {
      print(username);
      print(password);
      print(response.statusCode);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.isNotEmpty) {
          var data = jsonResponse[0];

          if (data["STATUS"] == "BERHASIL") {
            var listSessionUser = {
              "NO_REGISTRASI": data["NO_REGISTRASI"],
              "USERNAME": data["USERNAME"],
              "NAMA": data["NAMA"],
            };

            getStorage.write('user', listSessionUser);
            print("Login Berhasil");
            return "BERHASIL";
          } else {
            print("Login Gagal");
            return "GAGAL";
          }
        } else {
          print("Respon JSON kosong");
          return "GAGAL";
        }
      } else {
        print(
            "Respon tidak berhasil dengan status code: ${response.statusCode}");
        return "GAGAL";
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
      return "GAGAL";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: username,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: semiBoldText17.copyWith(color: redColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2, color: redColor),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username Tidak Boleh Kosong';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: password,
                    obscureText: _isHiddenPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: semiBoldText17.copyWith(color: redColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2, color: redColor),
                      ),
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: Icon(
                          _isHiddenPassword
                              ? Ionicons.eye_off_outline
                              : Ionicons.eye_outline,
                          color: blackColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password Tidak Boleh Kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: Text(
                        "Lupa password? Hubungi kami di sini",
                        style: semiBoldText11.copyWith(color: blackColor),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Stack(
                  children: [
                    MaterialButton(
                        padding: const EdgeInsets.all(14),
                        minWidth: 306,
                        color: redColor,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String dataResponse =
                                await login(username.text, password.text);
                            if (dataResponse == "BERHASIL") {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BerandaPage()),
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Login Gagal'),
                                    content: const Text(
                                        'Username atau password salah.'),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },

                        // _isLoading ? null : _handleLogin,
                        child: Text(
                          "Login",
                          style: semiBoldText20.copyWith(color: Colors.white),
                        )),
                    // if (_isLoading)
                    //   Positioned.fill(
                    //     child: Container(
                    //       color: Colors.black.withOpacity(0.5),
                    //       child: const Center(
                    //         child: CircularProgressIndicator(
                    //           valueColor:
                    //               AlwaysStoppedAnimation<Color>(Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton(
                  child: Text(
                    "Belum punya akun? Daftarkan dirimu sekarang juga.",
                    style: semiBoldText13.copyWith(color: blackColor),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BerandaPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void _handleLogin() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     String dataResponse = await login(username.text, password.text);
  //     int networkDelay =
  //         Random().nextInt(3) + 2; // Random delay between 2 to 4 seconds
  //     await Future.delayed(Duration(seconds: networkDelay));
  //     if (dataResponse == "BERHASIL") {
  //       // ignore: use_build_context_synchronously
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const BerandaPage()),
  //       );
  //     } else {
  //       // ignore: use_build_context_synchronously
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: const Text('Login Gagal'),
  //             content: const Text('Username atau password salah.'),
  //             actions: [
  //               TextButton(
  //                 child: const Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
}
