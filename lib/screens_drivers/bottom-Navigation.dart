import 'package:flutter/material.dart';
import './home.dart';
import './chat.dart';
import './getstarted.dart';
import 'chat.dart';
class MenuItem{
  const MenuItem(this.iconData,this.text);
  final IconData iconData;
  final String text;
}
const menuItemlist=<MenuItem>[
  MenuItem(Icons.home, 'Home'),
  MenuItem(Icons.shopping_basket, 'Products'),
  MenuItem(Icons.person, 'Me'),


];
class Naviation extends StatefulWidget {
  const Naviation({Key? key}) : super(key: key);

  @override
  State<Naviation> createState() => _NaviationState();
}

class _NaviationState extends State<Naviation> {
  int index=0;
  final List <Widget>_buildBody=<Widget>[Home(),getstarted(),ChatView(roomId: 'xx',)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(type:
        BottomNavigationBarType.shifting,
        currentIndex: index,
        onTap: (x){
        setState(() {
          index=x;
        });
        },
        elevation: 16.0,
        showSelectedLabels: true,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,


        items: menuItemlist.map((MenuItem item)=>BottomNavigationBarItem(backgroundColor: Colors.lightBlue,
            icon:Icon(item.iconData),label: item.text),).toList(),


        ),
      body: IndexedStack(index:index,children: _buildBody,),
    );
  }
}





class AnimatedNavBar extends StatefulWidget {
  final NavbarNotifier model;

  final List<MenuItem> menueItems;

  final Function(int) onItemTapped;

  const AnimatedNavBar({Key? key,required this.model,required this.menueItems,required this.onItemTapped}) : super(key: key);

  @override
  State<AnimatedNavBar> createState() => _AnimatedNavBarState();
}

class NavbarNotifier {
}

class _AnimatedNavBarState extends State<AnimatedNavBar> with SingleTickerProviderStateMixin{
  @override
  void didUpdateWidget(covariant AnimatedNavBar oldWidget) {
    if(widget.model.hideBottomNavBar!=isHidden)
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
