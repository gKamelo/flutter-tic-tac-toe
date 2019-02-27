import 'package:flutter/material.dart';

import './elements/tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tic tac toe Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BoardPage());
  }
}

class BoardPage extends StatefulWidget {
  BoardPage({Key key}) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  List<TileType> _tiles = List.filled(9, TileType.EMPTY);
  TileType _currentTile = TileType.CROSS;

  TileType _checkWinner() {
    List<List<int>> indexes = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    if (indexes.indexWhere(
            (index) => index.every((i) => _tiles[i] == TileType.CIRCLE)) >
        -1) {
      return TileType.CIRCLE;
    } else if (indexes.indexWhere(
            (index) => index.every((i) => _tiles[i] == TileType.CROSS)) >
        -1) {
      return TileType.CROSS;
    }

    return null;
  }

  void _reset() {
    setState(() {
      _currentTile = TileType.CROSS;
      _tiles = List.filled(9, TileType.EMPTY);
    });
  }

  void _update({BuildContext context, int index}) {
    if (_tiles[index] != TileType.EMPTY) return;

    _tiles[index] = _currentTile;

    final winner = _checkWinner();

    setState(() {
      _currentTile =
          _currentTile == TileType.CROSS ? TileType.CIRCLE : TileType.CROSS;
    });

    final isWinner = winner != null;
    final isTie = _tiles.every((tile) => tile != TileType.EMPTY);

    if (isWinner) {
      showDialog(
          context: context,
          builder: (context) =>
              _buildWinnerDialog(context: context, winner: winner),
          barrierDismissible: false);
    } else if (isTie) {
      showDialog(
          context: context,
          builder: _buildTieDialog,
          barrierDismissible: false);
    }
  }

  Widget _buildWinnerDialog({BuildContext context, TileType winner}) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        'End of game',
        textAlign: TextAlign.center,
      ),
      content: Text(
        '${winner == TileType.CIRCLE ? 'Circle' : 'Cross'} did win',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Reset'),
          onPressed: () {
            _reset();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget _buildTieDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        'End of game',
        textAlign: TextAlign.center,
      ),
      content: Text(
        'No one win',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Reset'),
          onPressed: () {
            _reset();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 200,
                width: 200,
                color: Colors.brown,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  padding: EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    return Tile(
                        type: _tiles[index],
                        onPress: () {
                          _update(context: context, index: index);
                        });
                  },
                )),
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                    '${_currentTile == TileType.CIRCLE ? 'Circle' : 'Cross'} should make the move')),
            FlatButton(child: Text('Reset'), onPressed: _reset)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
