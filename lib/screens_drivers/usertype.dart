import 'package:HantoryGo/Rider/loginPage.dart';
import 'package:HantoryGo/screens_drivers/driver_register.dart';
import 'package:flutter/material.dart';


import 'login.dart';



class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: UserType(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}

class UserType extends StatefulWidget {
  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
backgroundColor: Color.fromARGB(255, 0, 0, 128),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight)*0.4,
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab( text: 'Sign in As a Rider'),
              Tab(text: 'Sign in As a Driver'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LoginPage(),
          SignInWithPhonePage(),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Sign in As a Rider'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Sign in As a Driver'),
    );
  }
}
