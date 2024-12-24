// ignore_for_file: must_be_immutable

import 'package:budgettracker/admin/admin_tab_bar_view.dart';
import 'package:budgettracker/widgets/category_list.dart';
import 'package:budgettracker/widgets/time_line_month.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminTransactionScreen extends StatefulWidget {
  String id;
   AdminTransactionScreen({
    required this.id,
    super.key,
  });

  @override
  State<AdminTransactionScreen> createState() => _AdminTransactionScreenState();
}

class _AdminTransactionScreenState extends State<AdminTransactionScreen> {
  var category = "All";
  var monthYear = "";

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
    return Scaffold(
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
          AdminTypeTabBar(category: category, monthYear: monthYear, id: widget.id,)
        ],
      ),
    );
  }
}
