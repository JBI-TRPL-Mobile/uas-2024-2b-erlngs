import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    // Simulating a static JSON notification data
    final String response = await rootBundle.loadString('lib/data/datamessage.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      notifications = data.map((e) => e['message'].toString()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: notifications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.notifications, color: Colors.blue),
                  title: Text(notifications[index]),
                  subtitle: Text("Timestamp: Placeholder"), // Update with actual timestamps if needed
                );
              },
            ),
    );
  }
}
