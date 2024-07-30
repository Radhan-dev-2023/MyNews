import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_news/widgets/custom_textfields.dart';
import 'package:my_news/services/firebase_auth_services.dart';
import 'package:my_news/utils/colors.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthService auth = FirebaseAuthService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(245, 245, 250, 0.97),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'MyNews',
                style: TextStyle(
                  fontFamily: 'assets/fonts/Poppins/Poppins-Bold.ttf',
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: blue,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            customTextfields('Name', usernameController,TextInputType.name),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            customTextfields('Email', emailController,TextInputType.emailAddress),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            customTextfields('Password', passwordController,TextInputType.emailAddress),
            const Spacer(),
            Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          signup();
                        },
                        child: const Text(
                          'Signup',
                          style: TextStyle(
                              color: white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? ', style: TextStyle(
              fontFamily: 'assets/fonts/Poppins/Poppins-Bold.ttf',
              color: black,
              fontWeight: FontWeight.bold,
            ),),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: blue,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }

  void signup() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    setState(() {
      _isLoading = true;
    });

    try {
      User? user = await auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        await firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
        });
        print('User data stored successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        print("Failed to create user");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
