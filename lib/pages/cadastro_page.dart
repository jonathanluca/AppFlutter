import 'package:appdois/pages/checar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadstro Page'),
        ),
        body: ListView(
          padding: EdgeInsets.all(15),
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(label: Text('Nome completo')),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(label: Text('E-mail')),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(label: Text('Password')),
            ),
            ElevatedButton(onPressed: () {
              cadastrar();
            }, child: Text('Cadastrar'))
          ],
        ));
  }

  cadastrar() async {
    try{
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if (userCredential != null){
        userCredential.user!.updateDisplayName(_nomeController.text);
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => ChecarPage()
        ),
                (route) => false);
      }
    }on FirebaseAuthException catch (e) {
      if(e.code == 'week-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Crie uma senha mais forte'),
            backgroundColor: Colors.redAccent,
          ),
        );

      }else if (e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Esse e-mail ja foi cadastrado'),
            backgroundColor: Colors.redAccent,
          ),
        );

      }
    }
  }
}
