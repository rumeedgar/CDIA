import 'package:cdia/pages/home.dart';
import 'package:cdia/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "cDia",
                style: TextStyle(fontSize: 30),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              //Name
              TextFormField(
                controller: nameController,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Please enter a name";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Full Name",
                    hintText: "Full Name"),
                style: const TextStyle(fontSize: 18),
              ),
              //EmailAddress
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      hintText: "Email"),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              //Password
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Password"),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50)),
                    onPressed: () async {
                      try {
                        //register process
                        setState(() {
                          loading = true;
                        });
                        var cred = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        var user = cred.user;
                        if (user != null) {
                          user.updateDisplayName(nameController.text).then((_) {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));
                          });
                        }
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          loading = false;
                        });
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content:
                                    Text(e.message ?? "Something went wrong"),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Okay"))
                                ],
                              );
                            });
                      }
                    },
                    child: loading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : const Text("Signup")),
              ),

              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                  child: Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 19),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
