import 'package:budgettracker/admin/admin_transaction_list.dart';
import 'package:flutter/material.dart';

class AdminTypeTabBar extends StatelessWidget {
  const AdminTypeTabBar({super.key, required this.category, required this.monthYear, required this.id});
  final String category;
  final String monthYear;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: "Credit"),
                Tab(text: "Debit"),
              ],
            ),
            Expanded(
                child: TabBarView(children: [
              AdminTransactionList(category: category, monthYear: monthYear, type: 'credit', id: id,),
              AdminTransactionList(category: category, monthYear: monthYear, type: 'debit', id: id,),
            ]))
          ],
        ),
      ),
    );
  }
}
