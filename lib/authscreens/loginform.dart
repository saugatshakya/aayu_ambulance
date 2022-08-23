import 'package:aayu_mobile/home/homescreen.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //final AuthService _auth = AuthService();
  static final _formkey = GlobalKey<FormState>();
  String _email = "", _password = "";
  String error = "";
  //initially nothing is loading and password is obscure
  bool loading = false, obscure1 = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            //email  field
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.all(5),
              child: TextFormField(
                //checks if the field is empty or not
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Provide an email';
                  } else
                    return null;
                },
                onChanged: (input) => _email = input,
                decoration: new InputDecoration(
                    hintText: "Enter Email",
                    border: new UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(Icons.email, color: Colors.lightBlue)),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 20),
              ),
            ),
            //password field
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                //checks if the password field is less than 6 digits
                validator: (input) {
                  if (input!.length < 6) {
                    return 'Password must be 6 digits long';
                  } else
                    return null;
                },
                onChanged: (input) => _password = input,
                //hide the password
                obscureText: obscure1,
                decoration: new InputDecoration(
                    hintText: "Enter Password",
                    fillColor: Colors.grey[200],
                    border: new UnderlineInputBorder(),
                    filled: true,
                    prefixIcon: Icon(Icons.lock, color: Colors.lightBlue),
                    //to change the obscure property for user to view his password
                    suffixIcon: IconButton(
                        //show differnt icon after checking the obscure property
                        icon: Icon(
                            obscure1 ? Icons.visibility : Icons.visibility_off),
                        color: obscure1 ? Colors.grey : Colors.lightBlue,
                        onPressed: () {
                          setState(() {
                            //change the obscure property
                            obscure1 ? obscure1 = false : obscure1 = true;
                          });
                        })),
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(fontSize: 20),
              ),
            ),
            //login button
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(15)),
                // ignore: deprecated_member_use
                child: FlatButton(
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false);
                    },
                    //shows loading bar when login button is clicked
                    child: loading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text("Login",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ))))
          ],
        ),
      ),
    );
  }
}
