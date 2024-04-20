import 'package:flutter/material.dart';

enum ChatBubbleDirection {
  sent,
  received,
}

class ChatBubble extends StatelessWidget {
  final String message;
  final ChatBubbleDirection direction;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: direction == ChatBubbleDirection.sent
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Container(
              decoration: BoxDecoration(
                color: direction == ChatBubbleDirection.sent
                    ? Colors.blue
                    : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0),
                  bottomLeft: direction == ChatBubbleDirection.sent
                      ? const Radius.circular(16.0)
                      : const Radius.circular(0.0),
                  bottomRight: direction == ChatBubbleDirection.sent
                      ? const Radius.circular(0.0)
                      : const Radius.circular(16.0),
                ),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Text(
                message,
                style: TextStyle(
                  color: direction == ChatBubbleDirection.sent
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
