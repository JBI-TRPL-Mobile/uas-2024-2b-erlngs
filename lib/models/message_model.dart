class Message {
  final int id;
  final String sender;
  final String message;
  final String timestamp;

  Message({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: json['sender'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}
