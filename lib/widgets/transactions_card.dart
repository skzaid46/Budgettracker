// ignore_for_file: must_be_immutable

import 'package:budgettracker/utils/icon_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TransactionsCard extends StatelessWidget {
   TransactionsCard({
    super.key, required this.data,
  });
final dynamic data;

var appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(
                    data['timestamp']);
                String formatedDate = DateFormat('d MMM hh:mma').format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                color: Colors.grey.withOpacity(0.09),
                blurRadius: 10.0,
                spreadRadius: 4.0,
              )
            ]),
        child: ListTile(
          minVerticalPadding: 10,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          leading: Container(
            height: 100,
            width: 70,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: data['type'] == 'credit'
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
              ),
              child: Center(
                  child: FaIcon(appIcons.getExpenseCategoryIcons(
                      '${data['category']}'),color: data['type'] == 'credit'
                    ? Colors.green
                    : Colors.red),),
            ),
          ),
          title: Row(
            children: [
              Expanded(child: Text(data['title'])),
              Text(
                "${data['type'] == 'credit'? '+': '-'} ₹ ${data['amount']}",
                style: TextStyle(color: data['type'] == 'credit'
                    ? Colors.green
                    : Colors.red),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Balance",
                    style:
                        TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Spacer(),
                  Text(
                    "₹ ${data['remainingAmount']}",
                    style:
                        TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
              Text(
                formatedDate,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
