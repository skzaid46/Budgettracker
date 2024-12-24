import 'package:budgettracker/widgets/transactions_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminTransactionList extends StatelessWidget {
   AdminTransactionList({super.key, required this.category, required this.monthYear, required this.type, required this.id});

final userId = FirebaseAuth.instance.currentUser!.uid;

final String category;
final String id;
final String monthYear;
final String type;

  // final AppIcons appIcons;

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .collection("transactions")
            .orderBy('timestamp', descending: true)
            .where('monthyear', isEqualTo: monthYear)
            .where('type', isEqualTo: type);

            if(category != 'All'){
              query = query.where('category', isEqualTo: category);
            }
    return FutureBuilder<QuerySnapshot>(
      future: query.limit(999).get(),
        
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Somthing went wrong");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No transactions found."),
            );
          }
          var data = snapshot.data!.docs;

          return ListView.builder(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var cardData = data[index];
                return TransactionsCard(data: cardData,);
              });
        });
  }
}