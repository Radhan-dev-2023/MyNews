import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_news/screens/home_screen.dart';
import 'package:my_news/screens/news_provider.dart';
import 'package:my_news/screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAtAXDNtF57BcMfx10nB6ppEdmiQDLm-0s",
      appId: "1:295885833691:android:c8d45d27d026c0284053fe",
      messagingSenderId: "295885833691",
      projectId: "news-bbd70",
      storageBucket: "news-bbd70.appspot.com",
    ),
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NewsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseauth = FirebaseAuth.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:HomeScreen()
      home: firebaseauth.currentUser == null
          ? SignUpScreen()
          : const HomeScreen(),
    );
  }
}
