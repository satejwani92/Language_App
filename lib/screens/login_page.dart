import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:final_lang/ResourcePage/Resource.dart';
import 'package:final_lang/ResourcePage/resourcedownloading.dart';
import 'package:final_lang/admin/inshome.dart';
import 'package:final_lang/screens/profile_page.dart';
import 'package:final_lang/screens/register_page.dart';
import 'package:final_lang/utils/fire_auth.dart';
import 'package:final_lang/utils/validator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  late ColorScheme dync;

  LoginPage({required this.dync});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<void> displayMessage(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResourceDownloading(
            user: user,
            dync: widget.dync,
          ),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: widget.dync.onPrimaryContainer,
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      tophead(context, widget.dync.primary),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 18,
                      ),
                      formfield(context),
                    ],
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Form formfield(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.dync.inversePrimary,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: TextFormField(
              controller: _emailTextController,
              focusNode: _focusEmail,
              validator: (value) => Validator.validateEmail(email: value),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                hintText: tr("Enter your email id"),
                hintStyle: TextStyle(fontSize: 16, color: widget.dync.primary),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.dync.inversePrimary,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: TextFormField(
              controller: _passwordTextController,
              focusNode: _focusPassword,
              obscureText: true,
              validator: (value) => Validator.validatePassword(password: value),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                hintStyle: TextStyle(fontSize: 16, color: widget.dync.primary),
                hintText: tr("Your Password"),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 24.0),
          _isProcessing
              ? const CircularProgressIndicator()
              : Row(
                  children: [
                    Expanded(child: signinbutton(context)),
                  ],
                ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tr("Don’t have an account ? ")),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(
                        dync: widget.dync,
                      ),
                    ),
                  );
                },
                child: Text(
                  tr("Register"),
                  style: const TextStyle(
                    color: Color.fromARGB(200, 139, 61, 241),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tr("Instructor Login? ")),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => InsHome(
                        dync: widget.dync,
                      ),
                    ),
                  );
                },
                child: Text(
                  tr("Click Here"),
                  style: const TextStyle(
                    color: Color.fromARGB(200, 139, 61, 241),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          GestureDetector(
            onTap: () async {
              signInWithGoogle().then((value) async {
                if (value.user != null) {
                  ResourceBrain resourceBrain = ResourceBrain();

                  resourceBrain.initaldownloadlang();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ResourceDownloading(
                        user: value.user!,
                        dync: widget.dync,
                      ),
                    ),
                  );
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: widget.dync.inversePrimary,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              height: MediaQuery.of(context).size.height / 13,
              child: Image.network(
                  'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png'),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector signinbutton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _focusEmail.unfocus();
        _focusPassword.unfocus();

        if (_formKey.currentState!.validate()) {
          setState(() {
            _isProcessing = true;
          });

          User? user = await FireAuth.signInUsingEmailPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text,
          );

          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text,
            );
          } on FirebaseAuthException catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.code)));
          }

          setState(() {
            _isProcessing = false;
          });

          if (user != null) {
            ResourceBrain resourceBrain = ResourceBrain();

            await resourceBrain.initaldownloadlang();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ResourceDownloading(
                  user: user,
                  dync: widget.dync,
                ),
              ),
            );
          }
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 17,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.dync.primary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        width: 100,
        child: Center(
          child: Text(
            tr('Log In'),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

Container tophead(BuildContext context, col) {
  return Container(
    padding: const EdgeInsets.only(left: 20),
    height: MediaQuery.of(context).size.height / 3.4,
    width: double.infinity,
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: col,
      // image: DecorationImage(
      //   image: AssetImage("assets/Studentbackpack.png"),
      //   scale: 1.4,
      //   alignment: Alignment.bottomRight,
      // ),
    ),
    child: Text(
      tr("Hi user\nWelcome\nback"),
      style: const TextStyle(fontSize: 36, color: Colors.white),
    ),
  );
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<void> _showToast(BuildContext context) async {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Added to favorite'),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ),
  );
}
