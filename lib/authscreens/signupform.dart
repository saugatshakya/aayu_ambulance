import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // final AuthService _auth = AuthService();
  static final _formkey = new GlobalKey<FormState>();
  String _email = "", _password = "", _password2 = "", error = "";
  //initially loading is false and all password is obscure
  bool loading = false, obscure1 = true, obscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            //email field
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                //check is email is enabled
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Provide an email';
                  } else
                    return null;
                },
                onChanged: (input) => _email = input,
                decoration: new InputDecoration(
                    hintText: "Enter Email",
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: new UnderlineInputBorder(),
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
                //check is the input length is atlest 6
                validator: (input) {
                  if (input!.length < 6) {
                    return 'Password needs to be Longer';
                  } else
                    return null;
                },
                onChanged: (input) => _password = input,
                obscureText: obscure1,
                decoration: new InputDecoration(
                    hintText: "Enter Password",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: new UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Colors.lightBlue),
                    suffixIcon: IconButton(
                        //shows icon acoording to state of obscure
                        icon: Icon(
                            obscure1 ? Icons.visibility : Icons.visibility_off),
                        color: obscure1 ? Colors.grey : Colors.lightBlue,
                        onPressed: () {
                          setState(() {
                            //changes the state of obscure
                            obscure1 ? obscure1 = false : obscure1 = true;
                          });
                        })),
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(fontSize: 20),
              ),
            ),
            //password confirm field
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                //checks whether password is long enough and wheter it matches with previous password
                validator: (input) {
                  if (input!.length < 6) {
                    return 'Password needs to be Longer';
                  } else if (input != _password) {
                    return 'password does not match';
                  } else
                    return null;
                },
                onChanged: (input) => _password2 = input,
                obscureText: obscure2,
                decoration: new InputDecoration(
                    border: new UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock, color: Colors.lightBlue),
                    suffixIcon: IconButton(
                        icon: Icon(
                          //shows icon according to state of obscure
                          obscure2 ? Icons.visibility : Icons.visibility_off,
                          color: obscure2 ? Colors.grey : Colors.lightBlue,
                        ),
                        onPressed: () {
                          setState(() {
                            //changes the state of obscure
                            obscure2 ? obscure2 = false : obscure2 = true;
                          });
                        })),
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(15)),
                // ignore: deprecated_member_use
                child: FlatButton(
                    //check the validator and run the create user function if validates also enable loading
                    onPressed: () async {},
                    //check loading and show progress indicator if true else show signup
                    child: loading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white))
                        : Text("SignUp",
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
