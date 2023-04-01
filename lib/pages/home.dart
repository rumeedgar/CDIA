import 'package:cdia/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  'edgar studios',
                  style: TextStyle(color: Color(0x7D9E9E), fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  'cocoa disease Detector',
                  style: TextStyle(
                      color: Color(0x7D9E9E),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                SizedBox(height: 50),
                Center(child: _loading)
              ],
            ))
        // body: SafeArea(
        //   child: Center(
        //       child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text("Homepage"),
        //       ElevatedButton(
        //           onPressed: () {
        //             FirebaseAuth.instance.signOut().then((value) {
        //               Navigator.pushReplacement(context,
        //                   MaterialPageRoute(builder: (context) {
        //                 return LoginPage();
        //               }));
        //             });
        //           },
        //           child: Text("LogOut"))
        //     ],
        //   )),
        // ),
        );
  }
}
