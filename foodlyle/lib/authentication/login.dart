import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodlyle/authentication/auth_screen.dart';
import 'package:foodlyle/global/global.dart';
import 'package:foodlyle/mainScreens/home_screen.dart';
import 'package:foodlyle/widgets/custom_text_field.dart';
import 'package:foodlyle/widgets/error_dialog.dart';
import 'package:foodlyle/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  formValidation() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login
      loginNow();
    }
    //show error dialog
    else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: 'Please write Email/Password',
            );
          });
    }
  }

  loginNow() async {
    showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialog(
          message: 'Checking credentials',
        );
      },
    );
    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
        .then((auth) => {
              currentUser = auth.user!,
            })
        .catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then(
          (snapshot) => {
            if (snapshot.exists)
              {
                if (snapshot.data()!["status"] == "approved")
                  {
                    sharedPreferences!.setString("uid", currentUser.uid),
                    sharedPreferences!
                        .setString("sellerEmail", emailController.text.trim()),
                    sharedPreferences!
                        .setString("name", snapshot.data()!["sellerName"]),
                    sharedPreferences!.setString(
                        "photoUrl", snapshot.data()!["sellerAvatarUrl"]),
                    sharedPreferences!
                        .setString("phone", snapshot.data()!["phone"]),
                    sharedPreferences!
                        .setString("address", snapshot.data()!["address"]),
                    sharedPreferences!
                        .setDouble("lat", snapshot.data()!["lat"]),
                    sharedPreferences!
                        .setDouble("long", snapshot.data()!["long"]),
                    Navigator.pop(context),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const HomeScreen(),
                      ),
                    ),
                  }
                else
                  {
                    firebaseAuth.signOut(),
                    Navigator.pop(context),
                    Fluttertoast.showToast(
                        msg: "account blocked, email to admin1@gmail.com"),
                  }
              }
            else
              {
                firebaseAuth.signOut(),
                Navigator.pop(context),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => const AuthScreen(),
                  ),
                ),
                showDialog(
                  context: context,
                  builder: (c) {
                    return const ErrorDialog(
                      message: 'No record found',
                    );
                  },
                ),
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 270,
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset("images/seller.png"),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObscure: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObscure: true,
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: const Text(
              'Login',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: () {
              formValidation();
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
