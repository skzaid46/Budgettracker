import 'package:budgettracker/widgets/category_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  var type = "credit";
  var category = "Others";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var isLoader = false;
  TextEditingController _amount = TextEditingController();
  TextEditingController _title = TextEditingController();
  var uid = Uuid();

  void _submitform() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      final user = FirebaseAuth.instance.currentUser;
      int timestamp = DateTime.now().microsecondsSinceEpoch;
      var amount = int.parse(_amount.text);
      DateTime date = DateTime.now();

      var id = uid.v4();
      String monthyear = DateFormat('MMM y').format(date);

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      int remainingAmount = userDoc['remainingAmount'];
      int totalCredit = userDoc['totalCredit'];
      int totalDebit = userDoc['totalDebit'];

      if (type == 'credit') {
        remainingAmount += amount;
        totalCredit += amount;
      } else {
        remainingAmount -= amount;
        totalDebit += amount;
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        "remainingAmount": remainingAmount,
        "totalCredit": totalCredit,
        "totalDebit": totalDebit,
        "updatedAt": timestamp,
      });



var data = {
  "id": id,
  "title": _title.text,
  "amount": amount,
  "type": type,
  "timestamp": timestamp,
  "totalCredit": totalCredit,
  "totalDebit": totalDebit,
  "remainingAmount": remainingAmount,
  "monthyear": monthyear,
  "category": category,
};
await FirebaseFirestore.instance.collection('users').doc(user.uid).collection("transactions").doc(id).set(data);

Navigator.pop(context);

// await authService.login(data, context);

      setState(() {
        isLoader = false;
      });
      // Utils.flushBarErrorMessage("Submit successfully", context);
    }
  }

  String? isEmptyCheck(value) {
    if (value!.isEmpty) {
      return 'Please fill details';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _title,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: isEmptyCheck,
                decoration: InputDecoration(labelText: 'title'),
              ),
              TextFormField(
                controller: _amount,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: isEmptyCheck,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              CategoryDropdown(
                cattype: category,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      category = value;
                    });
                  }
                },
              ),
              DropdownButtonFormField(
                  value: 'credit',
                  items: [
                    DropdownMenuItem(
                      child: Text('Credit'),
                      value: 'credit',
                    ),
                    DropdownMenuItem(
                      child: Text('Debit'),
                      value: 'debit',
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        type = value;
                      });
                    }
                  }),
              SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    if (isLoader == false) {
                      _submitform();
                    }
                  },
                  child: isLoader
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text("Add Transaction"))
            ],
          )),
    );
  }
}
