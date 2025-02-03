import 'package:flutter/material.dart';
import 'movable_object.dart';

class DraggableItem extends StatelessWidget {
  final MovableObject object;
  final ValueChanged<Offset> onUpdate;

  const DraggableItem({required this.object, required this.onUpdate, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: object.position.dx,
      top: object.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          final screenSize = MediaQuery.of(context).size;
          final newPosition = object.position + details.delta;

          // Clamp the position to stay within screen bounds
          onUpdate(Offset(
            newPosition.dx.clamp(0.0, screenSize.width - 100), // 100 is the object's width
            newPosition.dy.clamp(0.0, screenSize.height - 100), // 100 is the object's height
          ));
        },
        child: Image.asset(
          object.imagePath,
          width: 100, // Adjust size
          height: 100,
        ),
      ),
    );
  }
}