import 'dart:async';

import 'package:budgettracker/widgets/auth_gate.dart';
import 'package:flutter/material.dart';

class splashScreenPage extends StatefulWidget {
  const splashScreenPage({super.key});

  @override
  State<splashScreenPage> createState() => _splashScreenPageState();
}

class _splashScreenPageState extends State<splashScreenPage> {
 
  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

 

  checkAuthStatus() async {
    Timer(
      Duration(seconds: 3),
      () {

        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthGate(),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(
            child: Container(
              height: 250,
              width: 250,
              child: Image.asset("images/wallet.png"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Budget Tracker",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Text(
            "All rights reserved ©Cubosquare",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
