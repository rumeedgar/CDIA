import 'package:cdia/pages/home.dart';
import 'package:cdia/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  "Login",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              //EmailAddress
              TextFormField(
                controller: emailController,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Please enter email";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Email"),
                style: const TextStyle(fontSize: 18),
              ),
              //Password
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  controller: passwordController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                  obscureText: true,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Password"),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: () async {
                      //Login Process
                      try {
                        //register process
                        setState(() {
                          loading = true;
                        });
                        var cred = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        var user = cred.user;
                        if (user != null) {
                          setState(() {
                            loading = false;
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
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
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : const Text("Login")),
              ),

              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SignUpPage();
                    }));
                  },
                  // ignore: prefer_const_constructors
                  child: Text(
                    "Don't have an account?",
                    style: const TextStyle(fontSize: 19),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
