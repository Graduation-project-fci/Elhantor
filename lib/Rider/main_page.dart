import 'package:flutter/material.dart';
class MainPage extends StatefulWidget {
  final String id;

  const MainPage({Key? key,required String this.id}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('Main Page'),);
  }
}
