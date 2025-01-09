class Message {
  final int id;
  final String sender;
  final String message;
  final String timestamp;
  final String imageUrl; // Tambahkan properti ini

  Message({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
    required this.imageUrl, // Tambahkan ke konstruktor
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: json['sender'],
      message: json['message'],
      timestamp: json['timestamp'],
      imageUrl: json['imageUrl'], // Parsing atribut baru dari JSON
    );
  }
}
