
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kc_tv_app/model/items.dart';
import 'package:kc_tv_app/widgets/suggestion_card.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  Items _itemsGames = Items();
  Items _itemsRoad = Items();
  Items _itemsFranchise = Items();
  int _index = 0;

  // Fetch content from the json file
  Future<void> readJson(String fileName, String key, Function callback) async {
  final String response = await rootBundle.loadString('assets/jsons/$fileName.json');
  final data = await json.decode(response);
  setState(() {
    callback(data[key]);
  });
}

  @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
  
    // Getting a random index of the items for the recommendations
    Random random = Random();
    _index = random.nextInt(2)+1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Image.asset(
            "assets/images/kc_white_on_red.png",
          ),
        ),
        title: Text(
          'KC Tv',
          style: Theme.of(context).textTheme.headlineLarge,
          ),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Recomendado para ti',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20,),
            FutureBuilder(
                  future: Future.wait([
                      readJson('games', 'games', (data) => _itemsGames = Items.fromJsonList(data)),
                      readJson('road', 'items', (data) => _itemsRoad = Items.fromJsonList(data)),
                      readJson('franchise', 'episodes', (data) => _itemsFranchise = Items.fromJsonList(data)),
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(_itemsGames.items[0].title);
                      return SuggestionCard(item: _itemsGames.items[0]);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
          ],
        ),
      ), 
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_football,
              color: Colors.red,),
            label: 'Juegos Completos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_road,
              color: Colors.red,
              ),
            label: 'Camino al Super Bowl',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_camera_back,
              color: Colors.red,
            ),
            label: 'The Franchise',
          ),
        ],
        backgroundColor: Colors.amber,
        unselectedItemColor: Colors.red,
        unselectedLabelStyle: const TextStyle(color: Colors.red, fontSize: 14),
        fixedColor: Colors.red,
        onTap: null,
      ),
    );
  }
}