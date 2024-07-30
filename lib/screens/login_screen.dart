import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_news/utils/colors.dart';
import 'home_screen.dart';
import '../widgets/custom_textfields.dart';
import '../services/firebase_auth_services.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService auth = FirebaseAuthService();
  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            customTextfields('Email', emailLogin,TextInputType.emailAddress),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            customTextfields('Password', passwordLogin,TextInputType.visiblePassword),
            const Spacer(),
            Center(
              child: SizedBox(
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
                    'Login',
                    style: TextStyle(
                        color: white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'New here? ',
                  style: TextStyle(
                    fontFamily: 'assets/fonts/Poppins/Poppins-Bold.tt',
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: const Text(
                    'Signup',
                    style: TextStyle(
                      fontFamily: 'assets/fonts/Poppins/Poppins-Bold.tt',
                      color: blue,
                      fontSize: 16,
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
    String email = emailLogin.text;
    String password = passwordLogin.text;

    User? user = await auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print('Successfully SignedIn');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      print("Some Error Occured");
    }
  }
}
