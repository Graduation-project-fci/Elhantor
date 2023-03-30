import 'package:flutter/material.dart';

class driver_register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
        backgroundColor: Color(0xFF000080),
      ),
      backgroundColor: Color(0xFFCBCBCB),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30,right: 10,left: 10),
            child: Column(
              children: [
                Container(
                  color: Colors.white70,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text('Basic info', style: TextStyle(color: Colors.black)),
                        trailing: Icon(Icons.arrow_forward, color: Colors.black),
                        onTap: () {},
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Driver license', style: TextStyle(color: Colors.black)),
                        trailing: Icon(Icons.arrow_forward, color: Colors.black),
                        onTap: () {},
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Criminal record', style: TextStyle(color: Colors.black)),
                        trailing: Icon(Icons.arrow_forward, color: Colors.black),
                        onTap: () {},
                      ),
                      Divider(),
                      ListTile(
                        title: Text('Certificate of vehicle registration', style: TextStyle(color: Colors.black)),
                        trailing: Icon(Icons.arrow_forward, color: Colors.black),
                        onTap: () {},
                      ),
                      Divider(),
                      ListTile(
                        title: Text('National ID', style: TextStyle(color: Colors.black)),
                        trailing: Icon(Icons.arrow_forward, color: Colors.black),
                        onTap: () {},
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Done', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    fixedSize: MaterialStateProperty.all(
                        Size(150, 40)), // set a fixed size for the button
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
* import 'package:flutter/material.dart';

class driver_register extends StatelessWidget {
  final List<String> buttonTitles = [    'Basic info',    'Driver license',    'Criminal record',    'Certificate of vehicle registration',    'National ID'  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Center(
        child: Container(
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: buttonTitles.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(buttonTitles[index], style: TextStyle(color: Colors.black)),
                          Icon(Icons.arrow_forward, color: Colors.black),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Done', style: TextStyle(color: Colors.black)),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  fixedSize: MaterialStateProperty.all(
                      Size(150, 40)), // set a fixed size for the button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

*
* */