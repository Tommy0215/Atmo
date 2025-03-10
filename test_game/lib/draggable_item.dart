import 'package:flutter/material.dart';
import 'movable_object.dart';

class DraggableItem extends StatefulWidget {
  final MovableObject object;
  final ValueChanged<Offset> onUpdate;

  const DraggableItem({required this.object, required this.onUpdate, super.key});

  @override
  State<StatefulWidget> createState() => _DraggableItemState();
}

class _DraggableItemState extends State<DraggableItem>{
  double opacity = 1.0; 

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 10),
      left: widget.object.position.dx,
      top: widget.object.position.dy,
      child: GestureDetector(
        onPanStart: (_){ //a callback function, initiated by dragging
          setState(() {
            opacity = 0.5;
          });
        },
        onPanUpdate: (details) {
          final screenSize = MediaQuery.of(context).size;
          final newPosition = widget.object.position + details.delta;

          // Clamp the position to stay within screen bounds
          widget.onUpdate(Offset(
            newPosition.dx.clamp(0.0, screenSize.width - 100), // 100 is the object's width
            newPosition.dy.clamp(0.0, screenSize.height - 100), // 100 is the object's height
          ));
        },

        onPanEnd: (_) { //initiated by releasing
          setState(() {
            opacity = 1.0;
          });
        },

        child: Opacity(
          opacity: opacity,
          child: Image.asset(
            widget.object.imagePath,
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}