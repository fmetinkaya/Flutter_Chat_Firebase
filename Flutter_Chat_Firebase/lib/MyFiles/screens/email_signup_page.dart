import 'package:flutter/material.dart';
import 'package:flutterdenemechat/MyFiles/core/locator.dart';
import 'package:flutterdenemechat/MyFiles/viewmodels/sign_in_model.dart';
import 'package:provider/provider.dart';


class EmailSignUpPage extends StatefulWidget {
  @override
  _EmailSignUpPageState createState() => _EmailSignUpPageState();
}

class _EmailSignUpPageState extends State<EmailSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (BuildContext context) => getIt<SignInModel>(),
        child: Consumer<SignInModel>(
            builder: (BuildContext context, SignInModel model, Widget child) =>
                Scaffold(
                    appBar: AppBar(title: Text("Sign Up")),
                    body: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Enter User Name",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter User Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Enter Email",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter an Email Address';
                                } else if (!value.contains('@')) {
                                  return 'Please enter a valid email address';
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
                                    onPressed: () async{
                                      if (_formKey.currentState.validate()) {
                                        print("denek");
                                        await model.signInAndRegisterDatabase(emailController.text, passwordController.text, nameController.text);
                                      }
                                    },
                                    child: Text('Submit'),
                                  ),
                          )
                        ]))))));
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
