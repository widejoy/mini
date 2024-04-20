import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _channel =
      WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));
  final _messages = <String>[];
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listenForMessages();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void _sendMessage(String message) {
    _channel.sink.add(message);
    _messageController.clear();
  }

  void _listenForMessages() {
    _channel.stream.listen((message) {
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Text(_messages[index]);
              },
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
