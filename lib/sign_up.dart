
import 'package:budgettracker/services/auth_service.dart';
import 'package:budgettracker/signin.dart';
import 'package:flutter/material.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _password = TextEditingController();

  var authService = AuthService();
  var isLoader = false;

  void _submitform() async{
    if (_formkey.currentState!.validate()) {

      setState(() {
        isLoader = true;
      });
      var data = {
        "username": _userName.text.toString(),
        "email": _email.text.toString(),
        "password": _password.text.toString(),
        "phone": _phoneNumber.text.toString(),
        'remainingAmount': 0,
        'totalCredit':0,
        'totalDebit':0
      };

      await authService.createUser(data, context);
      setState(() {
        isLoader = false;
      });
      // Utils.flushBarErrorMessage("Submit successfully", context);
    }
  }

  String? _validateEmail(value) {
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enater a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Please enter a 10-digit phone number';
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (value!.isEmpty) {
      return 'Please enter username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252634),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 250,
                    child: Text("Create new Account",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),))),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Username",
                  style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _userName,
                  style: TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Username', Icons.person),
                  validator: _validateUsername,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Email",
                  style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Email', Icons.email),
                  validator: _validateEmail,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Phone Number",
                  style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _phoneNumber,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: _buildInputDecoration('Phone Number', Icons.call),
                    validator: _validatePhoneNumber),
                    SizedBox(
                  height: 10,
                ),
                Text(
                  "Password",
                  style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _password,
                  style: TextStyle(color: Colors.white),
                  decoration: _buildInputDecoration('Password', Icons.lock),
                  validator: _validatePassword,
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF35900),
                      ),
                      onPressed:
                        _submitform,
                      
                      child: isLoader?Center(child: CircularProgressIndicator(),): Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signinpage()));
                  }, child: Text("Login",style: TextStyle(color:Color(0xFFF35900),fontSize: 20 ),)))
              ],
            ),
          ),
        ),
      ),
    );
  }


  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0x35949494))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    fillColor: Color(0xAA494A59),
                    filled: true,
                    labelStyle: TextStyle(color:  Color(0xff949494)),
                    suffixIcon: Icon(suffixIcon,color: Color(0xff949494),),
                    hintText: label,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  );
  }
}
