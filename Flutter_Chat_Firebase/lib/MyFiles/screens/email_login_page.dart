import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/log_in_model.dart';
import 'package:provider/provider.dart';


class EmailLogInPage extends StatefulWidget {
  @override
  _EmailLogInPageState createState() => _EmailLogInPageState();
}

class _EmailLogInPageState extends State<EmailLogInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => getIt<LogInModel>(),
        child: Consumer<LogInModel>(
            builder: (BuildContext context, LogInModel model, Widget child) =>
                Scaffold(
                    appBar: AppBar(title: Text("Login")),
                    body: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Enter Email Address",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Email Address';
                                } else if (!value.contains('@')) {
                                  return 'Please enter a valid email address!';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: "Enter Password",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Password';
                                } else if (value.length < 6) {
                                  return 'Password must be atleast 6 characters!';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: model.busy
                                ? CircularProgressIndicator()
                                : RaisedButton(
                                    color: Colors.lightBlue,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        model.logIn(emailController.text,
                                            passwordController.text);
                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                          )
                        ]))))));
  }
}
