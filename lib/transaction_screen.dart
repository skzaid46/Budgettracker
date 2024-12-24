import 'package:budgettracker/admin/all_user.dart';
import 'package:budgettracker/widgets/category_list.dart';
import 'package:budgettracker/widgets/tab_bar_view.dart';
import 'package:budgettracker/widgets/time_line_month.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    super.key,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  var category = "All";
  var monthYear = "";
  final String allowedUserId = "BebOFZFoEvSoJMnVCtIT9ntontT2"; // Your target user ID

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    setState(() {
      monthYear = DateFormat('MMM y').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      floatingActionButton: currentUserId == allowedUserId
          ? FloatingActionButton(
            backgroundColor: Colors.blue.shade900,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Alluserspage()),
                );
              },
              child: Icon(Icons.add,color: Colors.white,),
            )
          : Container(), // Show empty container if ID doesn't match
      appBar: AppBar(
        title: Text("Expansive"),
      ),
      body: Column(
        children: [
          TimeLineMonth(
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  monthYear = value;
                });
              }
            },
          ),
          CategoryList(
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  category = value;
                });
              }
            },
          ),
          TypeTabBar(category: category, monthYear: monthYear),
        ],
      ),
    );
  }
}
