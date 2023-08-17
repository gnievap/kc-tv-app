
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kc_tv_app/model/items.dart';
import 'package:kc_tv_app/screens/list_screen.dart';
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
  int _randomIndex = 0;
  int _selectedIndex = 0;

  // Fetch content from the json file
  Future<void> readJson(String fileName, String key, Function callback) async {
    try {
      //print('Reading $fileName.json');
      final String response = await rootBundle.loadString('assets/jsons/$fileName.json');
      final data = await json.decode(response);
      //print('Data from $fileName.json: $data');
      //print('Data from $fileName.json has ${data[key].length} items');
      callback(data[key]);
      // setState(() {
      //   callback(data[key]);
      // });
      //print('Finished reading $fileName.json');
      if (data[key].isEmpty) {
            print('$key list is empty');
      } else if (!data[key][0].containsKey('title')) {
            print('First element in $key list does not have a title property');
      } else {
            // Access the title property here
            print(data[key][0]['title']);
      }
     } catch (e) {
    print('Error while reading $fileName.json: $e');
  }
}

  @override
  void initState() {
    super.initState();
  
    // Getting a random index of the items for the recommendations
    Random random = Random();
    _randomIndex = random.nextInt(2)+1;
  }

  @override
  Widget build(BuildContext context) {
  Items itemsSelected = Items();
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
                  ]).catchError((error) {
                      // Maneja el error aquí
                      //print(error);
                      return [];
                  }),
                  builder: (context, snapshot) {
                    
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        // Muestra un mensaje de error
                        return const Text('Ocurrió un error al cargar los datos'); 
                      } else {
                          //print(_itemsGames.items[1].title);
                          return SuggestionCard(item: _itemsGames.items[_randomIndex]);
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
          ],
        ),
      ), 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items:  const <BottomNavigationBarItem>[
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
        onTap: (index) {
          //print('index: $index');
          
          if (index == 0) {
            itemsSelected = _itemsGames;
          } else if (index == 1) {
            itemsSelected = _itemsRoad;
          } else if (index == 2) {
            itemsSelected = _itemsFranchise;
          }
          setState(() {
            _selectedIndex = index;
            itemsSelected = itemsSelected;
        });
        //print('SelectedIndex: $_selectedIndex');
        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListScreen(listItems: itemsSelected)));
          //Navigator.of(context).pushNamed('ListScreen', arguments: itemsSelected);
        },
      ),
    );
  }
}