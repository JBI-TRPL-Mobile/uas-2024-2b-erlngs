import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/message_model.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final String response = await rootBundle.loadString('lib/data/datamessage.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        messages = data.map((json) => Message.fromJson(json)).toList();
      });
    } catch (e) {
      print("Error loading messages: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages")),
      body: messages.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(message.sender),
                  subtitle: Text(message.message),
                  trailing: Text(message.timestamp),
                );
              },
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
  currentIndex: 2, // Set to Profile tab
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
