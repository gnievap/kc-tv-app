
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kc_tv_app/widgets/suggestion_card.dart';

import '../model/item.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  List<Item> _itemsGames = [];
  List _itemsRoad = [];
  List _itemsFranchise = [];
  int _index = 0;

  // Fetch content from the json file
  Future<void> readGames() async {
     final String response = await rootBundle.loadString('assets/jsons/games.json');
     final data = await json.decode(response);
     //_itemsGames = new Item.fromJsonMap(data['games']);
     setState(() {
      // _itemsGames = data["games"];


       //print('Número de games in setState: ${_itemsGames.length}');
     });
   }

   Future<void> readRoad() async {
     final String response = await rootBundle.loadString('assets/jsons/road.json');
     final data = await json.decode(response);
     setState(() {
       _itemsRoad = data["items"];
     });
   }

   Future<void> readFranchise() async {
     final String response = await rootBundle.loadString('assets/jsons/fran.json');
     final data = await json.decode(response);
     setState(() {
       _itemsFranchise = data["episodes"];
     });
   }
  @override
  void initState() {
    super.initState();
    // Call the readJson method when the app starts
    readGames();
    // readRoad();
    // readFranchise();
    Random random = Random();
    _index = random.nextInt(2)+1;
    print('Index: $_index');
    //print('Número de games: ${_itemsGames.length}');
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
          children: <Widget>[
             Text(
              'Recomendado para ti',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20,),
            const SuggestionCard(),
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