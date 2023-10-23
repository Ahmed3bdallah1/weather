import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/constant.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: constants.primaryColor.withOpacity(.4),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text('Settings',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 45),
          child: Container(
            width: size.width * .95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: constants.linearGradientWhiteBlue,
                boxShadow: [
                  BoxShadow(
                      color: constants.primaryColor.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 8,
                      offset: const Offset(0, 5))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(child: Image.asset("assets/User.png", width: 100)),
                const SizedBox(height: 5),
                const Text(
                  "username",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Divider(
                    thickness: 1,
                    color: Colors.white,
                    indent: 10,
                    endIndent: 10),
                const SizedBox(height: 10),
                Container(
                  height: size.height * .08,
                  width: size.width * .75,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: constants.primaryColor.withOpacity(.5),
                            spreadRadius: 5,
                            blurRadius: 8,
                            offset: const Offset(0, 5))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("login", style: TextStyle(fontSize: 18)),
                      GestureDetector(
                          // onTap: () async{
                          //   await FirebaseAuth.instance.authStateChanges().isEmpty?
                          //   showDialog(
                          //       context: context,
                          //       builder: (_) {
                          //         return CupertinoAlertDialog(
                          //             title: const Text("already loged-in"),
                          //             actions: [
                          //               CupertinoDialogAction(
                          //                   child: const Text("ok"),
                          //                   onPressed: () {
                          //                     Navigator.pop(context);
                          //                   }),
                          //
                          //             ]);
                          //       })
                          //       :
                          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const HomeScreen()));
                          // },
                          child: const Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: size.height * .08,
                  width: size.width * .75,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: constants.primaryColor.withOpacity(.5),
                            spreadRadius: 5,
                            blurRadius: 8,
                            offset: const Offset(0, 5))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("language", style: TextStyle(fontSize: 18)),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return CupertinoAlertDialog(
                                    title: const Text(
                                        "select app language language"),
                                    actions: [
                                      CupertinoDialogAction(
                                          onPressed: () {

                                          },
                                          child: const Text("english")),
                                      CupertinoDialogAction(
                                          onPressed: () {

                                          },
                                          child: const Text("arabic")),
                                    ],
                                  );
                                });
                          },
                          child: const Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Container(
                //   height: size.height * .08,
                //   width: size.width * .75,
                //   padding: const EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //       color: Colors.white.withOpacity(.5),
                //       borderRadius: BorderRadius.circular(12),
                //       boxShadow: [
                //         BoxShadow(
                //             color: constants.primaryColor.withOpacity(.5),
                //             spreadRadius: 5,
                //             blurRadius: 8,
                //             offset: const Offset(0, 5))
                //       ]),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Text("set a default city",
                //           style: TextStyle(fontSize: 18)),
                //       GestureDetector(
                //           onTap: () {},
                //           child: const Icon(Icons.arrow_forward_ios))
                //     ],
                //   ),
                // ),
                TextButton(onPressed: (){}, child: const Text("Terms and policy"))
              ],
            ),
          ),
        ));
  }
}
