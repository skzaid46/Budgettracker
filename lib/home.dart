import 'package:budgettracker/signin.dart';
import 'package:budgettracker/widgets/add_transaction_form.dart';
import 'package:budgettracker/widgets/hero_card.dart';
import 'package:budgettracker/widgets/info.dart';
import 'package:budgettracker/widgets/transaction_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var isLoader = false;
  logOut() async {
    setState(() {
      isLoader = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Signinpage()));
    setState(() {
      isLoader = false;
    });
  }

 

  final userId = FirebaseAuth.instance.currentUser!.uid;
  _dialoBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AddTransactionForm(),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          _dialoBuilder(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "Hello",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          isLoader
              ? CircularProgressIndicator()
              : IconButton(
                  onPressed: () {
                    logOut();
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  )),
          isLoader
              ? CircularProgressIndicator()
              : IconButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Infopage();
                      },
                    );
                  },
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
        ],
        iconTheme: IconThemeData(
          color: Colors.white, // Set back arrow color to white
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroCard(
              userId: userId,
            ),
            TransactionCard(),
          ],
        ),
      ),
    );
  }

  
}
