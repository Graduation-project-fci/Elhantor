import 'package:flutter/material.dart';

class DriverReviewPage extends StatefulWidget {
  const DriverReviewPage({Key? key}) : super(key: key);

  @override
  _DriverReviewPageState createState() => _DriverReviewPageState();
}

class _DriverReviewPageState extends State<DriverReviewPage> {
  double _rating = 0;
  String _description = '';
  bool _anonymous = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,


      home: Scaffold(

        appBar: AppBar(
          title: const Text('Review John'),
          backgroundColor: const Color.fromARGB(255, 0, 0, 128),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://thumbs.dreamstime.com/b/transportation-services-young-male-driver-blue-uniform-driving-van-smiling-camera-196500292.jpg',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: _rating >= 1 ? const Icon(Icons.star) : const Icon(Icons.star_border),
                      iconSize: 35,
                      color: Colors.amber,
                      onPressed: () => setState(() => _rating = 1),
                    ),
                    IconButton(
                      icon:_rating >= 2 ? const Icon(Icons.star) : const Icon(Icons.star_border),
                      iconSize: 35,
                      color: Colors.amber,
                      onPressed: () => setState(() => _rating = 2),
                    ),
                    IconButton(
                      icon: _rating >= 3 ? const Icon(Icons.star) : const Icon(Icons.star_border),
                      iconSize: 35,
                      color: Colors.amber,
                      onPressed: () => setState(() => _rating = 3),
                    ),
                    IconButton(
                      icon: _rating >= 4 ? const Icon(Icons.star) : const Icon(Icons.star_border),
                      iconSize: 35,
                      color: Colors.amber,
                      onPressed: () => setState(() => _rating = 4),
                    ),
                    IconButton(
                      icon: _rating >= 5 ? const Icon(Icons.star) : const Icon(Icons.star_border),
                      iconSize: 35,
                      color: Colors.amber,
                      onPressed: () => setState(() => _rating = 5),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Write your review...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _description = value),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text('Post anonymously'),
                  value: _anonymous,
                  onChanged: (value) => setState(() => _anonymous = value!),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 150,
                  height: 50,

                  child: ElevatedButton(

                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 128)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),

                        ),
                      )),



                    onPressed: () {  },
                    child: const Text('Submit Review'),
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
