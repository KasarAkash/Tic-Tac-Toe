import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onTurn = true;
  var displayExOh = ["", "", "", "", "", "", "", "", ""];
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 15,
      letterSpacing: 3,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    SizedBox(height: 14),
                    Text(
                      "Scoreboard",
                      style: gameFont.copyWith(fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Player O",
                                style: gameFont,
                              ),
                              SizedBox(height: 14),
                              Text(
                                ohScore.toString(),
                                style: gameFont.copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Player X",
                                style: gameFont,
                              ),
                              SizedBox(height: 14),
                              Text(
                                exScore.toString(),
                                style: gameFont.copyWith(fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: displayExOh[index] == ""
                          ? () {
                              _tapped(index);
                            }
                          : () {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[500],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            // index.toString(),
                            displayExOh[index],
                            style: gameFont.copyWith(fontSize: 26),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "TIC TAC TOE",
                      style: gameFont,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "@CREATEDBYAKASH",
                      style: gameFont,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int i) {
    setState(() {
      if (onTurn) {
        displayExOh[i] = "O";
        filledBoxes += 1;
      } else {
        displayExOh[i] = "X";
        filledBoxes += 1;
      }

      onTurn = !onTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //Checks Row
    //1 case
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != "") {
      _showWinDialog(displayExOh[0]);
    }
    //2 case
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != "") {
      _showWinDialog(displayExOh[3]);
    }
    //3 case
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != "") {
      _showWinDialog(displayExOh[6]);
    }

    //checks Column
    //1 case
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != "") {
      _showWinDialog(displayExOh[0]);
    }
    //2 case
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != "") {
      _showWinDialog(displayExOh[1]);
    }
    //3 case
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != "") {
      _showWinDialog(displayExOh[2]);
    }

    //checks Crosses
    //2 case
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != "") {
      _showWinDialog(displayExOh[0]);
    }
    //3 case
    if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != "") {
      _showWinDialog(displayExOh[2]);
    }

    if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "DRAW",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                _clearBoard();
                Navigator.pop(context);
              },
              child: Text(
                "PLAY AGAIN",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "WINNER IS: '$winner'",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                _clearBoard();
                Navigator.pop(context);
              },
              child: Text(
                "PLAY AGAIN",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          ],
        );
      },
    );
    if (winner == "O") {
      ohScore += 1;
    }
    if (winner == "X") {
      exScore += 1;
    }
  }

  void _clearBoard() {
    for (var i = 0; i < 9; i++) {
      displayExOh[i] = "";
    }
    filledBoxes = 0;
    setState(() {});
  }
}
