import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final String response = await rootBundle.loadString('lib/data/datauser.json');
      final data = json.decode(response);
      setState(() {
        user = User.fromJson(data);
      });
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Log Out"),
          content: Text("Log Out from Learnout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/welcome'); // Navigate to WelcomeScreen
              },
              child: Text("Log Out"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home'); // Navigasi ke HomeScreen
          },
        ),
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(user!.profilePicture),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  user!.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  user!.email,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 30),
                _buildSectionHeader("Preferensi Video"),
                _buildListTile("Opsi Unduhan", Icons.download, () {}),
                _buildListTile("Opsi Pemutaran Video", Icons.video_settings, () {}),
                _buildSectionHeader("Pengaturan Akun"),
                _buildListTile("Keamanan Akun", Icons.security, () {}),
                _buildListTile("Preferensi Notifikasi Email", Icons.email, () {}),
                _buildListTile("Pengingat Pembelajaran", Icons.notifications, () {}),
                _buildSectionHeader("Tentang Learnout"),
                _buildListTile("Pertanyaan yang Sering Diajukan", Icons.question_answer, () {}),
                _buildListTile("Bagikan Aplikasi Learnout", Icons.share, () {}),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _showLogoutDialog,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text("Log Out", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.white, // Set background color to white
  type: BottomNavigationBarType.fixed, // Ensure all items are shown
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: "Notification",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: "Message",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ],
  currentIndex: 3, // Set to Profile tab
  onTap: (index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/notifications');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/messages');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  },
),
    );
  }
}
