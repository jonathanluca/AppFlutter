import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdicionarServicoPage extends StatefulWidget {
  const AdicionarServicoPage({super.key});

  @override
  _AdicionarServicoPageState createState() => _AdicionarServicoPageState();
}

class _AdicionarServicoPageState extends State<AdicionarServicoPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _adicionarServico() async {
    String nome = _nomeController.text;
    String descricao = _descricaoController.text;

    if (nome.isNotEmpty && descricao.isNotEmpty) {
      await _firestore.collection('servicos').add({
        'nome': nome,
        'descricao': descricao,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Serviço adicionado com sucesso!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Serviço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Serviço'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição do Serviço'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarServico,
              child: const Text('Adicionar Serviço'),
            ),
          ],
        ),
      ),
    );
  }
}
