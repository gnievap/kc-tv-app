import 'package:flutter/material.dart';
import 'package:kc_tv_app/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KC Tv',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0x00000000),
          primaryColor: Colors.redAccent,
          appBarTheme: const AppBarTheme(
            color:  Color.fromARGB(255, 210, 21, 48),
          ),
          textTheme:
            const TextTheme(   //0x89baf3
              headlineLarge: TextStyle(color: Colors.white, fontSize:32, fontWeight: FontWeight.bold, fontFamily: 'Tahoma'),
              headlineMedium: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),   
              bodyMedium: TextStyle(color: Colors.white, fontSize:14,  fontWeight: FontWeight.bold),
              bodySmall: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
            backgroundColor:  Colors.red, // background (button) color
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          useMaterial3: true),
      home:  const StartScreen(),
    );
    
    
  }
}
