import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Notification {
  final String title;
  final String content;
  final String timestamp;

  Notification({required this.title, required this.content, required this.timestamp});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json['title'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Notification> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      final String response = await rootBundle.loadString('lib/data/datanotification.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        notifications = data.map((json) => Notification.fromJson(json)).toList();
      });
    } catch (e) {
      print("Error loading notifications: $e");
    }
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home'); // Navigasi ke HomeScreen
          },
          
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/notifications'); // Navigasi ke layar Notifications
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  title: Text(notification.title),
                  subtitle: Text(notification.content),
                  trailing: Text(notification.timestamp),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
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
        currentIndex: 1,
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
