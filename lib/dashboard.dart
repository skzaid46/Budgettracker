import 'package:budgettracker/home.dart';
import 'package:budgettracker/navbar.dart';
import 'package:budgettracker/transaction_screen.dart';
import 'package:flutter/material.dart';

class Dashboardpage extends StatefulWidget {
  const Dashboardpage({super.key});

  @override
  State<Dashboardpage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<Dashboardpage> {
  int currentIndex = 0;
  var pageViewList = [
    Homepage(),
    TransactionScreen(),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(selectedIndex: currentIndex, onDestinationSelected: (int value){
        setState(() {
          currentIndex = value;
        });
      }),
      body: pageViewList[currentIndex],
    );
  }
}