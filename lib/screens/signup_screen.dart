import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final String response = await rootBundle.loadString('lib/data/datauser.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        users = data.map((json) => User.fromJson(json)).toList();
      });
    } catch (e) {
      print("Error loading users: $e");
    }
  }

  Future<void> _saveUserToJson(User newUser) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/datauser.json');

      List<Map<String, dynamic>> userList = users.map((user) => user.toJson()).toList();
      userList.add(newUser.toJson());

      await file.writeAsString(json.encode(userList));
      print("User data saved successfully.");
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  void _signUp(BuildContext context) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError(context, "Semua field harus diisi.");
      return;
    }

    if (password != confirmPassword) {
      _showError(context, "Password tidak cocok.");
      return;
    }

    if (users.any((user) => user.email == email)) {
      _showError(context, "Email sudah digunakan.");
      return;
    }

    User newUser = User(
      id: users.length + 1,
      name: name,
      email: email,
      profilePicture: 'lib/assets/Gambar WhatsApp 2024-05-23 pukul 20.38.48_23ebf208.jpg',
    );

    setState(() {
      users.add(newUser);
    });

    _saveUserToJson(newUser);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Registrasi berhasil!"),
    ));

    Navigator.pushNamed(context, '/home');
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Text(
                "Sign up",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Masukkan data Anda untuk mendaftar",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Konfirmasi Password",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _signUp(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Sign up", style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text.rich(
                  TextSpan(
                    text: "Sudah punya akun? ",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Masuk",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
