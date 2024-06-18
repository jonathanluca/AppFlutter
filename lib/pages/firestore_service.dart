import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:appdois/services/firestore_service.dart';

import 'historico_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Data'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: firestoreService.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum dado encontrado'));
          } else {
            List<Map<String, dynamic>> allData = snapshot.data!;
            return ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(allData[index]['nome'] ?? 'Nome não disponível'),
                  subtitle: Text(allData[index]['email'] ?? 'Email não disponível'),
                  // Adicione outros campos conforme necessário
                );
              },
            );
          }
        },
      ),
    );
  }
}
