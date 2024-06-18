import 'package:appdois/firebase_options.dart';
import 'package:appdois/pages/checar_page.dart';
import 'package:appdois/pages/home_page.dart';
import 'package:appdois/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:appdois/firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

  // Adicionar dados ao Firestore após a inicialização do Firebase
  FirebaseFirestore.instance.collection('teste').add({'teste': 'teste'});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Relatorios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChecarPage(),
    );
  }
}

