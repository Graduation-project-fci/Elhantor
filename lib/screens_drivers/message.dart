import 'package:flutter/material.dart';
class Message extends StatefulWidget {
  final String  text;

  const Message({Key? key,required this.text
  }) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return  Text(widget.text) ;
  }
}

