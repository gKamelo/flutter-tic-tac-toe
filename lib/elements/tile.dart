import 'package:flutter/material.dart';

import './circle.dart';
import './cross.dart';

enum TileType { EMPTY, CIRCLE, CROSS }

class Tile extends StatelessWidget {
  final TileType type;
  final Function onPress;

  Tile({@required this.type, @required this.onPress});

  Widget _content() {
    switch (type) {
      case TileType.CIRCLE:
        return CustomPaint(painter: Circle());
      case TileType.CROSS:
        return CustomPaint(painter: Cross());
      case TileType.EMPTY:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
            padding: EdgeInsets.all(5),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.brown)),
            child: _content()));
  }
}
