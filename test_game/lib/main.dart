import 'package:flutter/material.dart';

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
  Offset _position = Offset(300, 500);
  bool _isDragging = false;
  
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
              ),
            ),
          ),

          Positioned( 
            left: _position.dx,
            top: _position.dy,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() => _isDragging = true);
              },
              onPanEnd: (_) {
                setState(() => _isDragging = false);
              },
              onPanUpdate: (details) {
                setState(() {
                  _position = Offset(
                    (_position.dx + details.delta.dx).clamp(0.0, MediaQuery.of(context).size.width - 100),
                    (_position.dy + details.delta.dy).clamp(0.0, MediaQuery.of(context).size.height - 100),
                  );
                });
              },
              child: AnimatedOpacity(
                opacity: _isDragging ? 0.7 : 1.0, 
                duration: const Duration(milliseconds: 0),
                child: Image.asset('assets/objects/sleep_neochi_woman.png'),
              ),
            )
          ),
        ], // Stack children
      ),
      
      



      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Fooled',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
