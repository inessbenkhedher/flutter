import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'contact.dart'; // Import LoginPage from login.dart

import 'package:path_provider/path_provider.dart';



class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = "Formulaire d'inscription";
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true, // Center the title
          title: const Text(appTitle),
        ),
        body: Center(
          child: MyCustomForm(isLogin: false), // Pass isLogin as false for registration
        ),
      ),
    );
  }
}


Future<String> get _localPath async {
  // Get the directory for the app's documents directory
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<Database> _getDatabase() async {
  final String path = await _localPath;
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



class MyCustomForm extends StatefulWidget {
  final bool isLogin; // Add this line

  const MyCustomForm({Key? key, required this.isLogin}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _name = TextEditingController();

  void _submitForm() async {
    final String name = _name.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Check if any field is empty
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      // Show error message if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final Database db = await _getDatabase();

    // Insert user data into the database
    try {
      await db.insert(
        'user_data',
        {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      // Navigate to login page after successful registration
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error inserting user data: $e');
      // Show error message if insertion fails
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to register user.'),
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
            controller: _name,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',

            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ),

        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Submit'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(150, 50),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            // Navigate to login page if isLogin is true
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: Text(
            "Already have an account? Login",
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
