import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'evenement.dart';
import 'package:path_provider/path_provider.dart';

Future<String> _localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}


void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pageTitle = "Connexion";
    return MaterialApp(
      title: pageTitle,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(pageTitle),
        ),
        body: Center(
          child: AuthPage(
            isLogin: true,
            pageTitle: pageTitle,
          ),
        ),
      ),
    );
  }
}


Future<Database> _getDatabase() async {
  final String path = await _localPath();
  return openDatabase(
    '$path/user_data.db',
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_data(id INTEGER PRIMARY KEY, name TEXT, gender TEXT, email TEXT, studentId TEXT, level TEXT, password TEXT, imagePath TEXT)',
      );
    },
    version: 1,
  );
}


class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pageTitle = "Formulaire d'inscription";
    return MaterialApp(
      title: pageTitle,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(pageTitle),
        ),
        body: Center(
          child: AuthPage(
            isLogin: false,
            pageTitle: pageTitle,
          ),
        ),
      ),
    );
  }
}

class AuthPage extends StatefulWidget {
  final bool isLogin;
  final String pageTitle;

  const AuthPage({
    Key? key,
    required this.isLogin,
    required this.pageTitle,
  }) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _submitForm() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final Database db = await _getDatabase();

    final List<Map<String, dynamic>> users = await db.query(
      'user_data',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (users.isNotEmpty) {
      // Navigate to home page if user exists
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error alert if user doesn't exist
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid email or password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text(widget.isLogin ? 'Login' : 'Register'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            if (widget.isLogin) {
              // Navigate to registration page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            } else {
              // Navigate to login page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
          },
          child: Text(
            widget.isLogin ? "Don't have an account? Register" : "Already have an account? Login",
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
