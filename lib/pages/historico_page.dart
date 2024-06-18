import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para obter dados da coleção 'people'
  Future<List<Map<String, dynamic>>> getPeople() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('people').get();
      List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      return data;
    } catch (e) {
      print('Erro ao obter pessoas: $e');
      return [];
    }
  }

  // Método para obter dados da coleção 'servicos'
  Future<List<Map<String, dynamic>>> getServicos() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('servicos').get();
      List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      return data;
    } catch (e) {
      print('Erro ao obter serviços: $e');
      return [];
    }
  }

  // Método para obter dados da coleção 'teste'
  Future<List<Map<String, dynamic>>> getTeste() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('teste').get();
      List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      return data;
    } catch (e) {
      print('Erro ao obter dados de teste: $e');
      return [];
    }
  }

  // Método para obter todos os dados de todas as coleções
  Future<List<Map<String, dynamic>>> getAllData() async {
    try {
      List<Map<String, dynamic>> allData = [];

      // Obter pessoas da coleção 'people'
      List<Map<String, dynamic>> peopleData = await getPeople();
      allData.addAll(peopleData);

      // Obter serviços da coleção 'servicos'
      List<Map<String, dynamic>> servicosData = await getServicos();
      allData.addAll(servicosData);

      // Obter dados da coleção 'teste'
      List<Map<String, dynamic>> testData = await getTeste();
      allData.addAll(testData);

      return allData;
    } catch (e) {
      print('Erro ao obter todos os dados: $e');
      return [];
    }
  }
}
