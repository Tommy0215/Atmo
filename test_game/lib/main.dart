import 'package:flutter/material.dart';
import 'package:test_game/movable_object.dart';
import 'draggable_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false, // Disable the debug banner
      home: const MyHomePage(title: 'Atmo'),
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

  List<MovableObject> objects = [
    MovableObject(position: Offset(100, 200), imagePath: 'assets/objects/sleep_neochi_man.png'),
    MovableObject(position: Offset(200, 400), imagePath: 'assets/objects/sleep_neochi_woman.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgrounds/forest.jpeg'), // Path to your image
                fit: BoxFit.cover, // Adjust how the image fits the container
              )
            )
          ),

          for (int i = 0; i < objects.length; i++)
            DraggableItem(
              object: objects[i],
              onUpdate: (newPosition) {
                setState(() {
                  objects[i].position = newPosition;
                });
              },
            ),
        ], // Stack children
      ),
    );
  }
}
