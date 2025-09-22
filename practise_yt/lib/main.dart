import 'package:flutter/material.dart';

void main() {
  runApp(Hello());
}

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 3.0, bottom: 3.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      color: const Color.fromARGB(255, 255, 111, 59),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0, bottom: 3.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      color: const Color.fromARGB(255, 46, 255, 109),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      color: const Color.fromARGB(255, 59, 111, 255),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0, top: 3.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      color: const Color.fromARGB(255, 219, 255, 59),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
