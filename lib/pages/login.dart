import 'package:appdois/pages/cadastro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

// Define a página de login como um StatefulWidget, permitindo a atualização do estado.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Define o estado da página de login.
class _LoginPageState extends State<LoginPage> {
  // Controladores para capturar as entradas de email e senha.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // Instância do FirebaseAuth para realizar a autenticação.
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'), // Título da página de login.
      ),
      body: ListView(
        padding: EdgeInsets.all(12), // Padding para espaçamento.
        children: [
          // Campo de texto para entrada do email.
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                label: Text('E-mail') // Rótulo do campo de email.
            ),
          ),
          // Campo de texto para entrada da senha.
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                label: Text('Senha') // Rótulo do campo de senha.
            ),
          ),
          // Botão de login que chama a função login() ao ser pressionado.
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: Text('Entrar'),
          ),
          // Botão para navegar para a página de cadastro.
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroPage(),
                ),
              );
            },
            child: Text('Criar conta'),
          ),
        ],
      ),
    );
  }

  // Função de login que tenta autenticar o usuário com o Firebase.
  login() async {
    try {
      // Tenta fazer o login com email e senha.
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
      // Se o login for bem-sucedido, navega para a HomePage.
      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Trata erros específicos de autenticação.
      if (e.code == 'user-not-found') {
        // Exibe um SnackBar se o usuário não for encontrado.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'wrong-password') {
        // Exibe um SnackBar se a senha estiver errada.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sua senha está errada'),
          ),
        );
      }
    }
  }
}
