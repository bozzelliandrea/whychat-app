import 'package:chat_app/message.dart';
import 'package:flutter/material.dart';
import 'package:whychat/src/room_client_socket.dart';

class Room extends StatefulWidget {
  const Room({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RoomState();
}

class RoomState extends State<Room> {
  final List<Message> messages = [
    Message("bob", "hey", MessageType.sender),
    Message("foo", "hello world !", MessageType.receiver),
    Message("foo", "how is it going", MessageType.receiver),
    Message("bob", "fine, bye bye", MessageType.sender),
  ];

  final TextEditingController _inputController = TextEditingController();
  final RoomClientSocket _connection;

  RoomState() : _connection = RoomClientSocket("pippo") {
    _eventListener();
  }

  void _eventListener() {
    _connection.socket.onMessage.listen((event) {
      setState(() {
        messages.add(Message("bob", event.data as String, MessageType.sender));
      });
    });
  }

  void _addMessage(String text) {
    _connection.socket.send(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Public Chat Room",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].type == MessageType.receiver
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].type == MessageType.receiver
                            ? Colors.grey.shade800
                            : Colors.purple.shade800),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment:
                              messages[index].type == MessageType.receiver
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                          children: [
                            Text(
                              messages[index].content,
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              messages[index].username.capitalize(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ])),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (_inputController.text.isNotEmpty) {
                        _addMessage(_inputController.text);
                      }
                    },
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.black,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
