import 'package:flutter/material.dart';
import 'package:new_project/screens_drivers/home.dart';
import 'package:new_project/screens_drivers/login.dart';
import 'package:new_project/screens_drivers/map.dart';
import 'package:new_project/screens_drivers/getstarted.dart';
import 'package:new_project/screens_drivers/loginscreen.dart';
import 'package:new_project/screens_drivers/signup.dart';
import 'dart:core';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _pages;
  int _selected_page=0;
  void selectPage(int index){
    setState(() {
      _selected_page=index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[_selected_page]['page'],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight* 0.98,
          decoration: BoxDecoration(color: Colors.white,
          border: Border(
            top:BorderSide(width: 0.5,color: Colors.grey)
          )
          ),
          child: BottomNavigationBar(
            onTap: selectPage,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.purple,
            currentIndex: _selected_page,
            items: [
              BottomNavigationBarItem(icon:Icon( Icons.home),label: 'Home',),
              BottomNavigationBarItem(icon:Icon( Icons.history),label: 'Trips',),
              BottomNavigationBarItem(icon:Icon( Icons.star),label: 'user',),
              BottomNavigationBarItem(icon:Icon( Icons.person),label: 'Login',),

            ],

          ),
        ),
      ),
    );
  }
}
