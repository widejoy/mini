import 'package:flutter/material.dart';
import 'package:mini/widgets/chatbubble.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _channel =
      WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));
  final Map<String, List<Map<String, dynamic>>> _sessionMessages = {
    'Session 1': [],
    'Session 2': [],
  };
  final _messageControllers = {
    'Session 1': TextEditingController(),
    'Session 2': TextEditingController(),
  };
  String _currentSession = 'Session 1';

  @override
  void dispose() {
    _channel.sink.close();
    for (final controller in _messageControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _sendMessage(String message) {
    _channel.sink.add(message);
    _sessionMessages[_currentSession]!.add({
      'message': message,
      'direction': ChatBubbleDirection.sent,
    });
    _messageControllers[_currentSession]!.clear();
    setState(() {});
  }

  void _listenForMessages() {
    _channel.stream.listen((message) {
      setState(() {
        _sessionMessages[_currentSession]!.add({
          'message': message,
          'direction': ChatBubbleDirection.received,
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _listenForMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 24, 30),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSessionButton('Session 1'),
            _buildSessionButton('Session 2'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _sessionMessages[_currentSession]!.length,
              itemBuilder: (context, index) {
                final message = _sessionMessages[_currentSession]![index];
                return ChatBubble(
                  message: message['message'],
                  direction: message['direction'],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageControllers[_currentSession],
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () =>
                      _sendMessage(_messageControllers[_currentSession]!.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionButton(String sessionName) {
    return TextButton(
      onPressed: () {
        setState(() {
          _currentSession = sessionName;
        });
      },
      child: Text(
        sessionName,
        style: TextStyle(
          color: _currentSession == sessionName ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
