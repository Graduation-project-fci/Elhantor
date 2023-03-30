import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../services/Storage/storage.dart'as Storage;
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> _notifications = [];
  late CollectionReference<Map<String, dynamic>> _notificationsRef;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((value) {
      _notificationsRef = FirebaseFirestore.instance.collection('notifications');
      _notificationsRef.snapshots().listen(_onNotificationsChanged);
    });

  }

  void _onNotificationsChanged(QuerySnapshot<Map<String, dynamic>> snapshot) {
    snapshot.docChanges.forEach((change) {
      if (change.type == DocumentChangeType.added) {
        _onNotificationAdded(change.doc);
      } else if (change.type == DocumentChangeType.modified) {
        _onNotificationChanged(change.doc);
      }
    });
  }

  void _onNotificationAdded(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    setState(() {
      _notifications.add(Map<String, dynamic>.from(snapshot.data()!));
    });
  }

  void _onNotificationChanged(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    setState(() {
      int index = _notifications.indexWhere((notification) => notification['id'] == snapshot.id);
      _notifications[index] = Map<String, dynamic>.from(snapshot.data()!);

    });
  }
  String imageUrl="";




  // Future<void> sendPushNotification(String title, String body, dynamic fcmToken, {required to, required Map<String, String> data}) async {
  //   try {
  //     // Create the notification message
  //
  //
  //     // Send the notification message to the device with the given FCM token
  //     await FirebaseMessaging.instance.sendMessage(message.data,messageType: RemoteMessage());
  //   } catch (e) {
  //     print('Error sending notification: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 0, 0, 128),
      //   title: Text('Notifications'),
      // ),
      body:_notifications.length==0?CircularProgressIndicator(): Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (BuildContext context, int index) {
                    String image=Storage.ImageStorage().getdownloadurl(_notifications[index]['from']).toString();
                return ListTile(

                  selectedTileColor: Colors.blue,
                  leading:  CircleAvatar(
                    backgroundImage:imageUrl==""? const NetworkImage(
                     // _notifications[index]['from']
                      'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1600',
                    ):NetworkImage(Storage.ImageStorage().getdownloadurl('${_notifications[index]['from']}').toString()),
                  
                  ),
                  title: Text(_notifications[index]['title']! as String),
                  subtitle: Text(_notifications[index]['body']! as String),
                  onTap: () {
                    // TODO: Handle notification tap
                  },
                  tileColor: _notifications[index]['read']! as bool ? null : Colors.lightBlue[100],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
