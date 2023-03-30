import 'package:flutter/material.dart';


class getstarted extends StatefulWidget {
  const getstarted({super.key});

  @override
  State<getstarted> createState() => _getstartedState();
}

class _getstartedState extends State<getstarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 145, 145),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 150, left: 20, right: 20),
                      child: const Text(
                        "Welcome to birth place (Luxor)",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 10, 67, 71)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 80),
                      child: Image.asset(
                        'assets/4.jpg',
                        width: 500,
                      ),
                    ),
                    const Text(
                      "HantourGo",
                      style: TextStyle(
                        color: Color.fromARGB(255, 10, 67, 71),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.only(top: 70, left: 20, right: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 114, 90, 90),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            onPressed: () {
                              Navigator.of(context).pushNamed("login");
                            },
                            child: const Text("Get Started"))),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 114, 90, 90),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            onPressed: () {
                              Navigator.of(context).pushNamed("newintro");
                            },
                            child: const Text("Get Started 2")))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
