import 'package:flutter/material.dart';
import 'package:homework_flutter_1/new_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: const NewPage(),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.deepOrangeAccent,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    newState.getResponse();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Push me',
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 15
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
