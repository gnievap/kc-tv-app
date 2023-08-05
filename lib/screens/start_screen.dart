import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KC Tv',
          style: Theme.of(context).textTheme.headlineLarge,
          ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
              'Carrusel de recomendaciones',
            ),
          ],
        ),
      ), 
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_football),
            label: 'Full Games',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_outlined),
            label: 'Analysys & Interviews',
            color: Colors.red,
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: 'The Franchise',
            backgroundColor: Colors.red,
          ),
        ],
        backgroundColor: Colors.amber,
        onTap: null,
      ),
    );
  }
}