
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_project/models/review.dart';
import 'package:new_project/screens_drivers/notifications.dart';
import 'package:new_project/screens_drivers/review.dart';
import 'package:new_project/Rider/home.dart';
import './screens_drivers/map.dart' ;
void main() {
  HttpOverrides.global = MyHttpOverrides();
 runApp( MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Create a new `HttpClient` that accepts any SSL certificate
    final client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BottomNavbar Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        routes: {
          // This route needs to be registered, Because
          //  we are pushing this on the main Navigator Stack on line 754 (isRootNavigator:true)
          ProfileEdit.route: (context) => const ProfileEdit(),
        },
        home: const NavBarHandler());
  }
}

class MenuItem {
  const MenuItem(this.iconData, this.text);
  final IconData iconData;
  final String text;
}

Future<void> navigate(BuildContext context, String route,
    {bool isDialog = false,
      bool isRootNavigator = true,
      Map<String, dynamic>? arguments}) =>
    Navigator.of(context, rootNavigator: isRootNavigator)
        .pushNamed(route, arguments: arguments);

final homeKey = GlobalKey<NavigatorState>();
final productsKey = GlobalKey<NavigatorState>();
final profileKey = GlobalKey<NavigatorState>();
final NavbarNotifier _navbarNotifier = NavbarNotifier();
List<Color> colors = [mediumPurple, Colors.orange, Colors.teal];
const Color mediumPurple = Color.fromRGBO(79, 0, 241, 1.0);
const String placeHolderText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

class NavBarHandler extends StatefulWidget {
  const NavBarHandler({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<NavBarHandler> createState() => _NavBarHandlerState();
}

class _NavBarHandlerState extends State<NavBarHandler>
    with SingleTickerProviderStateMixin {
  final _buildBody = const <Widget>[HomeMenu(), ProductsMenu(), ProfileMenu()];

  late List<BottomNavigationBarItem> _bottomList = <BottomNavigationBarItem>[];

  final menuItemlist = const <MenuItem>[
    MenuItem(Icons.home, 'Home'),
    MenuItem(Icons.history, 'History'),
    MenuItem(Icons.star, 'Rating'),

    MenuItem(Icons.notifications, 'Notifications'),
    MenuItem(Icons.person, 'Me'),
  ];

  late Animation<double> fadeAnimation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    fadeAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );

    _bottomList = List.generate(
        _buildBody.length,
            (index) => BottomNavigationBarItem(
          icon: Icon(menuItemlist[index].iconData),
          label: menuItemlist[index].text,
        )).toList();
    _controller.forward();
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 600),
        margin: EdgeInsets.only(
            bottom: kBottomNavigationBarHeight, right: 2, left: 2),
        content: Text('Tap back button again to exit'),
      ),
    );
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool isExitingApp = await _navbarNotifier.onBackButtonPressed();
        if (isExitingApp) {
          newTime = DateTime.now();
          int difference = newTime.difference(oldTime).inMilliseconds;
          oldTime = newTime;
          if (difference < 1000) {
            hideSnackBar();
            return isExitingApp;
          } else {
            showSnackBar();
            return false;
          }
        } else {
          return isExitingApp;
        }
      },
      child: Material(
        child: AnimatedBuilder(
            animation: _navbarNotifier,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  IndexedStack(
                    index: _navbarNotifier.index,
                    children: [
                      for (int i = 0; i < _buildBody.length; i++)
                        FadeTransition(
                            opacity: fadeAnimation, child: _buildBody[i])
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedNavBar(
                        model: _navbarNotifier,
                        onItemTapped: (x) {
                          // User pressed  on the same tab twice
                          if (_navbarNotifier.index == x) {
                            _navbarNotifier.popAllRoutes(x);
                          } else {
                            _navbarNotifier.index = x;
                            _controller.reset();
                            _controller.forward();
                          }
                        },
                        menuItems: menuItemlist),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class NavbarNotifier extends ChangeNotifier {
  int _index = 0;
  int get index => _index;
  bool _hideBottomNavBar = false;

  set index(int x) {
    _index = x;
    notifyListeners();
  }

  bool get hideBottomNavBar => _hideBottomNavBar;
  set hideBottomNavBar(bool x) {
    _hideBottomNavBar = x;
    notifyListeners();
  }

  // pop routes from the nested navigator stack and not the main stack
  // this is done based on the currentIndex of the bottom navbar
  // if the backButton is pressed on the initial route the app will be terminated
  FutureOr<bool> onBackButtonPressed() async {
    bool exitingApp = true;
    switch (_navbarNotifier.index) {
      case 0:
        if (homeKey.currentState != null && homeKey.currentState!.canPop()) {
          homeKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 1:
        if (productsKey.currentState != null &&
            productsKey.currentState!.canPop()) {
          productsKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 2:
        if (profileKey.currentState != null &&
            profileKey.currentState!.canPop()) {
          profileKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      default:
        return false;
    }
    if (exitingApp) {
      return true;
    } else {
      return false;
    }
  }

  // pops all routes except first, if there are more than 1 route in each navigator stack
  void popAllRoutes(int index) {
    switch (index) {
      case 0:
        if (homeKey.currentState!.canPop()) {
          homeKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 1:
        if (productsKey.currentState!.canPop()) {
          productsKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 2:
        if (profileKey.currentState!.canPop()) {
          profileKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      default:
        break;
    }
  }
}

class AnimatedNavBar extends StatefulWidget {
  const AnimatedNavBar(
      {Key? key,
        required this.model,
        required this.menuItems,
        required this.onItemTapped})
      : super(key: key);
  final List<MenuItem> menuItems;
  final NavbarNotifier model;
  final Function(int) onItemTapped;

  @override
  _AnimatedNavBarState createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar>
    with SingleTickerProviderStateMixin {
  @override
  void didUpdateWidget(covariant AnimatedNavBar oldWidget) {
    if (widget.model.hideBottomNavBar != isHidden) {
      if (!isHidden) {
        _showBottomNavBar();
      } else {
        _hideBottomNavBar();
      }
      isHidden = !isHidden;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _hideBottomNavBar() {
    _controller.reverse();
    return;
  }

  void _showBottomNavBar() {
    _controller.forward();
    return;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 100.0).animate(_controller);
  }

  late AnimationController _controller;
  late Animation<double> animation;
  bool isHidden = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: Offset(0, animation.value),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(2, -2),
                ),
              ]),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                currentIndex: widget.model.index,
                onTap: (x) {
                  widget.onItemTapped(x);
                },
                elevation: 16.0,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.white54,
                selectedItemColor: Colors.white,
                items: widget.menuItems
                    .map((MenuItem menuItem) => BottomNavigationBarItem(
                  backgroundColor: Colors.deepPurple,
                  icon: Icon(menuItem.iconData),
                  label: menuItem.text,
                ))
                    .toList(),
              ),
            ),
          );
        });
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: colors[0])),
      child: Navigator(
          key: homeKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) =>  NotificationPage();
                break;
              case FeedDetail.route:
                builder = (BuildContext _) {
                  final id = (settings.arguments as Map)['id'];
                  return FeedDetail(
                    feedId: id,
                  );
                };
                break;
              default:
                builder = (BuildContext _) => const MapPage();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),

    );
  }
}

class ProductsMenu extends StatelessWidget {
  const ProductsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: colors[1])),
      child: Navigator(
          key: productsKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const ProductList();
                break;
              case ProductDetail.route:
                final id = (settings.arguments as Map)['id'];
                builder = (BuildContext _) {
                  return ProductDetail(
                    id: id,
                  );
                };
                break;
              case ProductComments.route:
                final id = (settings.arguments as Map)['id'];
                builder = (BuildContext _) {
                  return ProductComments(
                    id: id,
                  );
                };
                break;
              default:
                builder = (BuildContext _) => const ProductList();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(primary: colors[2])),
      child: Navigator(
          key: profileKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const UserProfile();
                break;
              case ProfileEdit.route:
                builder = (BuildContext _) => const ProfileEdit();
                break;
              default:
                builder = (BuildContext _) => const UserProfile();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}

class HomeFeeds extends StatefulWidget {
  const HomeFeeds({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<HomeFeeds> createState() => _HomeFeedsState();
}

class _HomeFeedsState extends State<HomeFeeds> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = false;
        }
      } else {
        if (!_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 30,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                _navbarNotifier.hideBottomNavBar = false;
                navigate(context, FeedDetail.route,
                    isRootNavigator: false,
                    arguments: {'id': index.toString()});
              },
              child: FeedTile(index: index));
        },
      ),
    );
  }
}

class FeedTile extends StatelessWidget {
  final int index;
  const FeedTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      color: Colors.grey.withOpacity(0.4),
      child: Stack(
        children: [
          Positioned(
            top: 4,
            right: 4,
            left: 4,
            child: Container(
              color: Colors.grey,
              height: 180,
            ),
          ),
          Positioned(
              bottom: 12,
              right: 12,
              left: 12,
              child: Text(placeHolderText.substring(0, 200)))
        ],
      ),
    );
  }
}

class FeedDetail extends StatelessWidget {
  final String feedId;
  const FeedDetail({Key? key, this.feedId = '1'}) : super(key: key);
  static const String route = '/feeds/detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed $feedId'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Placeholder(
                fallbackHeight: 200,
                fallbackWidth: 300,
              ),
              Text(placeHolderText),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = false;
        }
      } else {
        if (!_navbarNotifier.hideBottomNavBar) {
          _navbarNotifier.hideBottomNavBar = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    _navbarNotifier.hideBottomNavBar = false;
                    navigate(context, ProductDetail.route,
                        isRootNavigator: false,
                        arguments: {'id': index.toString()});
                  },
                  child: ProductTile(index: index)),
            );
          }),
    );
  }
}

class ProductTile extends StatelessWidget {
  final int index;
  const ProductTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey.withOpacity(0.5),
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              height: 75,
              width: 75,
              color: Colors.grey,
            ),
            Text('Product $index'),
          ],
        ));
  }
}

class ProductDetail extends StatelessWidget {
  final String id;
  const ProductDetail({Key? key, this.id = '1'}) : super(key: key);
  static const String route = '/products/detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product $id'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('My AWESOME Product $id'),
          const Center(
            child: Placeholder(
              fallbackHeight: 200,
              fallbackWidth: 300,
            ),
          ),
          TextButton(
              onPressed: () {
                _navbarNotifier.hideBottomNavBar = false;
                navigate(context, ProductComments.route,
                    isRootNavigator: false, arguments: {'id': id.toString()});
              },
              child: const Text('show comments'))
        ],
      ),
    );
  }
}

class ProductComments extends StatelessWidget {
  final String id;
  const ProductComments({Key? key, this.id = '1'}) : super(key: key);
  static const String route = '/products/detail/comments';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments on Product $id'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            child: ListTile(
              tileColor: Colors.grey.withOpacity(0.5),
              title: Text('Comment $index'),
            ),
          ),
        );
      }),
    );
  }
}

class UserProfile extends StatelessWidget {
  static const String route = '/';

  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                navigate(context, ProfileEdit.route);
              },
            )
          ],
          title: const Text('Hi User')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Hi My Name is'),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileEdit extends StatelessWidget {
  static const String route = '/profile/edit';

  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Edit')),
      body: const Center(
        child: Text('Notice this page does not have bottom navigation bar'),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:new_project/models/review.dart';
import 'package:new_project/screens_drivers/map.dart';
import './screens_drivers/notifications.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.


  print("Handling a background message: ${message.messageId}");
}


void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  String token="";

 //await
 print(token);
 await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hantory Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/history': (BuildContext context) => HistoryPage(),
        '/rating': (BuildContext context) => NotificationPage(),
        '/notifications': (BuildContext context) => NotificationsPage(),
        '/person': (BuildContext context) => PersonPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String token="";

  static List<Widget> _widgetOptions = <Widget>[    MapPage(),    HistoryPage(),    NotificationPage(),    NotificationPage(),    PersonPage(),  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
    FirebaseMessaging.instance.getToken().then((value) => token=value!);
    print(token);
  }
  String _token='dzfQGA2kS7ynyUuqxmKL2y:APA91bHzl8ARGQaPaxcusV7wrWl-gg9z_XrPOFJPPZ-n7R24oIguZ1m8_dSyPYIZZNQoSaKd_fpzPuhiOspXg9ZljOE75QaelE5gdKpYEWTQQ9VrueM3P3Tr_WxSFtwzc_k5G77_vZPq';

  Future<void> _retrieveFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');

    if (token != null) {
      setState(() {
        _token = token;
      });

      try {
        await FirebaseMessaging.instance.sendMessage(

            data: {

            },

            to: 'dzfQGA2kS7ynyUuqxmKL2y:APA91bHzl8ARGQaPaxcusV7wrWl-gg9z_XrPOFJPPZ-n7R24oIguZ1m8_dSyPYIZZNQoSaKd_fpzPuhiOspXg9ZljOE75QaelE5gdKpYEWTQQ9VrueM3P3Tr_WxSFtwzc_k5G77_vZPq',
          );

        print('Message sent successfully');
      } catch (e) {
        print('Error sending message: $e');
      }
    } else {
      print('FCM token is null');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _widgetOptions.elementAt(_selectedIndex),

      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rating',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          ),
        ],

        selectedItemColor: Color.fromARGB(255, 0, 0, 128),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Page'),
      ),
      body: Center(
        child: Text('History Page'),
      ),
    );
  }
}




class Comment {
  final String author;
  final String text;
  final int rating;

  Comment({
    required this.author,
    required this.text,
    required this.rating,
  });
}

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                comment.author,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < comment.rating; i++)
                    const Icon(Icons.star, color: Colors.yellow),
                  for (int i = comment.rating; i < 5; i++)
                    const Icon(Icons.star_border, color: Colors.yellow),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment.text),
        ],
      ),
    );
  }
}

// class CommentsPage extends StatefulWidget {
//   @override
//   _CommentsPageState createState() => _CommentsPageState();
// }
//
// class _CommentsPageState extends State<CommentsPage> {
//   late CollectionReference _commentsRef;
//   List<Comment> _comments = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Get a reference to the 'comments' node in the database
//     _commentsRef = FirebaseFirestore.instance.collection('Reviews');
//     // Add a listener to update the comments list whenever the data changes
//     // _commentsRef..listen((event) {
//     //   if (event.snapshot.value != null) {
//     //     final List<Comment> comments = [];
//     //     final Map<dynamic, dynamic> data =
//     //     Map<dynamic, dynamic>.from(event.snapshot.value as Map<dynamic,dynamic>);
//     //     data.forEach((key, value) {
//     //       comments.add(
//     //         Comment(
//     //           author: value['author'],
//     //           text: value['text'],
//     //           rating: value['rating'],
//     //         ),
//     //       );
//     //     });
//         setState(() {
//           _comments = comments;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Driver Comments'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16),
//         child: ListView.builder(
//           itemCount: _comments.length,
//           itemBuilder: (BuildContext context, int index) {
//             return CommentItem(comment: _comments[index]);
//           },
//         ),
//       ),
//     );
//   }
// }



class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Page'),
      ),
      body: Center(
        child: Text('Notifications Page'),
      ),
    );
  }
}

class PersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Page'),
      ),
      body: Center(
        child: Text('Person Page'),
      ),
    );
  }
}

import 'dart:async';

import 'package:HantoryGo/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SplashScreen());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FCM Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _token = '';
  Future<void> sendNotification(String token, String title, String body) async {
    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAGx_dmbw:APA91bGUVawdCUxK4PTR_Q2uiPkd4DBd7W3_UgVPPdCG1GseD3_taSDP0XT_AvFS_uqtDZ_ziAZ026CcR-tg8z6flGssRvkCZYx_NtSDtR5YPe7I2EhgZfga4N5uu2jBiXPsA86Buz_I',
    };
    final bodyJson = {
      'to': token,
      'notification': {
        'title': title,
        'body': body,
        'sound':'default'
      },
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(bodyJson),
    );
    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Error sending notification: ${response.body}');
    }
  }


  @override
  void initState() {
    super.initState();
    _setupFCM();
    sendNotification('dzfQGA2kS7ynyUuqxmKL2y:APA91bHzl8ARGQaPaxcusV7wrWl-gg9z_XrPOFJPPZ-n7R24oIguZ1m8_dSyPYIZZNQoSaKd_fpzPuhiOspXg9ZljOE75QaelE5gdKpYEWTQQ9VrueM3P3Tr_WxSFtwzc_k5G77_vZPq','title','body');
  }

  Future<void> _setupFCM() async {
    // Request permission for receiving notifications (iOS only)
    await FirebaseMessaging.instance.requestPermission();

    // Get the device's FCM token
    String? token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');

    if (token != null) {
      setState(() {
        _token = token;
      });
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification!.title}');
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter FCM Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('FCM Token: $_token'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: null,
              child: Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
