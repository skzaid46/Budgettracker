import 'package:budgettracker/admin/admin_transaction_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Alluserspage extends StatefulWidget {
  const Alluserspage({super.key});

  @override
  State<Alluserspage> createState() => _AlluserspageState();
}

class _AlluserspageState extends State<Alluserspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All users"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users') // Fetch all documents in 'users'
            .limit(999) // Optional limit
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No users found."),
            );
          }

          var data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var cardData = data[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminTransactionScreen(id: cardData.id,)));
                },
                child: Card(
                  child: ListTile(
                    title: Text(cardData['username'] ?? "No username"), // Safely access 'username'
                    subtitle: Text(cardData['email'] ?? "No email"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
