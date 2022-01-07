class Message {
  String username;
  String content;
  MessageType type;

  Message(this.username, this.content, this.type);
}

enum MessageType { sender, receiver }

extension UsernameExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}