// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// class ChatRoomScreen extends StatefulWidget {
//   final String roomId;
//
//   ChatRoomScreen({required this.roomId});
//
//   @override
//   _ChatRoomScreenState createState() => _ChatRoomScreenState();
// }
//
// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   final TextEditingController _messageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//
//       appBar: AppBar(
//         backgroundColor: Colors.blue[800],
//         foregroundColor: Colors.lightBlue,
//         title: Text('Chat Room',style: TextStyle(color:Colors.white),),
//       ),
//       body: Expanded(
//         child: Column(
//
//           children: [
//             StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chat_rooms')
//                   .doc(widget.roomId)
//                   .collection('messages')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 List<Text>messages=[];
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: Colors.blue,
//                     ),
//
//                   );
//                 }
//
//                 List<DocumentSnapshot> docs = snapshot.data!.docs!;
//                 return ListView.builder(
//                   padding:
//                   EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//                   reverse: true,
//                   itemCount: docs.length,
//                   itemBuilder: (context, index) {
//                     final data = docs[index];
//
//                     return Message(text: data['text'], sender: data['sender']);
//
//                   },
//                 );
//               },
//             ),
//             TextField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your message',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     _sendMessage();
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _sendMessage() {
//     String text = _messageController.text.trim();
//     if (text.isNotEmpty) {
//       FirebaseFirestore.instance
//           .collection('chat_rooms')
//           .doc(widget.roomId)
//           .collection('messages')
//           .add({
//         'sender': 'User 2',
//         'text': text,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//       _messageController.clear();
//     }
//   }
// }
// /*
// Scaffold(
//
//
//             appBar: AppBar(
//               backgroundColor: Colors.blue[800],
//               foregroundColor: Colors.lightBlue,
//               title: Text('Chat Room',style: TextStyle(color:Colors.white),),
//             ),
//             body: Expanded(
//               child: Column(
//
//                 children: [
//                   StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('chat_rooms')
//                         .doc(widget.roomId)
//                         .collection('messages')
//                         .orderBy('timestamp', descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       List<Text>messages=[];
//                       if (!snapshot.hasData) {
//                         return Center(
//                           child: CircularProgressIndicator(
//                             backgroundColor: Colors.blue,
//                           ),
//
//                         );
//                       }
//
//                       List<DocumentSnapshot> docs = snapshot.data!.docs!;
//                       return ListView.builder(
//                         padding:
//                         EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//                         reverse: true,
//                         itemCount: docs.length,
//                         itemBuilder: (context, index) {
//                           final data = docs[index];
//
//                           return Message(text: data['text'], sender: data['sender']);
//
//                         },
//                       );
//                     },
//                   ),
//                   TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter your message',
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.send),
//                         onPressed: () {
//                           _sendMessage();
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//  */
//
// class Message extends StatelessWidget {
//
//
//   const Message({Key? key,  required this.text,  required
//   this.sender}): super(key: key);
// final String text;
// final String sender;
//   @override
//
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: sender == 'User 1'
//             ? CrossAxisAlignment.end
//             : CrossAxisAlignment.start,
//         children: [
//           Text(
//             sender,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.yellow[900],
//             ),
//             textAlign: sender == 'User 1' ? TextAlign.right : TextAlign.left,
//           ),
//           Flexible(
//             flex: 1,
//             child: Material(
//               color: sender == 'User 1' ? Colors.blue[800] : Colors.white,
//               borderRadius: sender == 'User 1'
//                   ? BorderRadius.only(
//                 topLeft: Radius.circular(30),
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               )
//                   : BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//               elevation: 5,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 10.0,
//                   horizontal: screenWidth * 0.05, // set width based on screen size
//                 ),
//                 child: Text(
//                   text,
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: sender == 'User 1' ? Colors.white : Colors.black45,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
//

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatefulWidget {
  final String roomId;

  const ChatView({required this.roomId});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(widget.roomId)
          .collection('messages')
          .add({
        'text': _messageController.text.trim(),
        'sender': 'User 1',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.lightBlue,
        title: Text(
          'Chat Room',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chat_rooms')
                  .doc(widget.roomId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  );
                }

                List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index];

                    return ChatBubble(
                      text: data['text'],
                      sender: data['sender'],
                      isMe: data['sender'] == 'User 1',
                    );
                  },
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue[800],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, -1.0),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;

  const ChatBubble({
    required this.text,
    required this.sender,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
              crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: TextStyle(fontSize: 12, color: Colors.yellow[900]),
                  textAlign: isMe ? TextAlign.right : TextAlign.left,
                ),
                Material(
                    color: sender == 'User 1' ? Colors.blue[800] : Colors.white,
                    borderRadius: sender == 'User 1'
                        ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                        : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ), elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.05, // set width based on screen size
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      color: sender == 'User 1' ? Colors.white : Colors.black45,
                    ),
                  ),
                ),
              ),
              ])),
   ] );
  }

}
