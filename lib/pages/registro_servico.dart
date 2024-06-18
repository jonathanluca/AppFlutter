import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegistroServico extends StatefulWidget {
  @override
  _RegistroServicoState createState() => _RegistroServicoState();
}

class _RegistroServicoState extends State<RegistroServico> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Função assíncrona para obter pessoas do Firestore
  Future<List<Map<String, dynamic>>> getPeople() async {
    List<Map<String, dynamic>> people = [];

    // Referência para a coleção 'people'
    CollectionReference collectionReferencePeople = db.collection('people');

    // Obter todos os documentos da coleção
    QuerySnapshot queryPeople = await collectionReferencePeople.get();

    // Iterar sobre os documentos e adicionar os dados à lista 'people'
    queryPeople.docs.forEach((documento) {
      people.add(documento.data() as Map<String, dynamic>);
    });

    return people;
  }

  // Função assíncrona para obter serviços do Firestore
  Future<List<Map<String, dynamic>>> getServicos() async {
    List<Map<String, dynamic>> servicos = [];

    // Referência para a coleção 'servicos'
    CollectionReference collectionReferenceServicos = db.collection('servicos');

    // Obter todos os documentos da coleção
    QuerySnapshot queryServicos = await collectionReferenceServicos.get();

    // Iterar sobre os documentos e adicionar os dados à lista 'servicos'
    queryServicos.docs.forEach((documento) {
      servicos.add(documento.data() as Map<String, dynamic>);
    });

    return servicos;
  }

  // Função assíncrona para obter dados de teste do Firestore
  Future<List<Map<String, dynamic>>> getTeste() async {
    List<Map<String, dynamic>> teste = [];

    // Referência para a coleção 'teste'
    CollectionReference collectionReferenceTeste = db.collection('teste');

    // Obter todos os documentos da coleção
    QuerySnapshot queryTeste = await collectionReferenceTeste.get();

    // Iterar sobre os documentos e adicionar os dados à lista 'teste'
    queryTeste.docs.forEach((documento) {
      teste.add(documento.data() as Map<String, dynamic>);
    });

    return teste;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Aqui você pode construir a interface que utilizará os dados obtidos
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: getPeople(), // Exemplo de uso para obter pessoas
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum dado encontrado.'));
          } else {
            List<Map<String, dynamic>> data = snapshot.data!;
            // Aqui você pode usar os dados retornados para construir a interface
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['nome'] ?? 'Nome não disponível'),
                  subtitle: Text(data[index]['email'] ?? 'Email não disponível'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
