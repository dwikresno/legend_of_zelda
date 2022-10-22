// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, curly_braces_in_flow_control_structures, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:legend_of_zelda/page/zelda.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double initPositionedY = -385;
  double initPositionedX = -1698;
  double sizeArrow = 40;
  double zeldaX = -0.45;
  double zeldaY = -0.60;
  Timer? timer;
  bool isChangeMap = false;
  bool isBegining = true;
  bool isZeldaWalk = false;
  String direction = "down";
  AudioPlayer audioMainPlayer = AudioPlayer();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isChangeMap = true;
        zeldaY = -0.77;
      });
    });

    super.initState();
  }

  Future<void> playIntro() async {
    var content = await rootBundle.load("assets/sound/Overworld-BGM.mp3");
    final directory = await getApplicationDocumentsDirectory();
    var file = File("${directory.path}/running_about.mp3");
    file.writeAsBytesSync(content.buffer.asUint8List());
    await audioMainPlayer.setFilePath(file.path);
    audioMainPlayer.setLoopMode(LoopMode.one);
    audioMainPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height / 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Listener(
                    onPointerDown: (details) {
                      actionMove("left");
                    },
                    onPointerUp: (details) {
                      setState(() {
                        timer!.cancel();
                      });
                    },
                    child: Container(
                      child: Icon(
                        Icons.arrow_left,
                        size: sizeArrow,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Listener(
                          onPointerDown: (details) {
                            actionMove("up");
                          },
                          onPointerUp: (details) {
                            setState(() {
                              timer!.cancel();
                            });
                          },
                          child: Container(
                            child: Icon(
                              Icons.arrow_drop_up,
                              size: sizeArrow,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sizeArrow,
                        ),
                        Listener(
                          onPointerDown: (details) {
                            actionMove("down");
                          },
                          onPointerUp: (details) {
                            setState(() {
                              timer!.cancel();
                            });
                          },
                          child: Container(
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: sizeArrow,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Listener(
                    onPointerDown: (details) {
                      actionMove("right");
                    },
                    onPointerUp: (details) {
                      setState(() {
                        timer!.cancel();
                      });
                    },
                    child: Container(
                      child: Icon(
                        Icons.arrow_right,
                        size: sizeArrow,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: MediaQuery.of(context).size.height + 150,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.linear,
                  bottom: initPositionedY,
                  right: initPositionedX,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 4.12,
                    height: MediaQuery.of(context).size.width * 4.12,
                    child: Image.asset(
                      "assets/map.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  onEnd: () {
                    setState(() {
                      isChangeMap = false;
                      isZeldaWalk = !isZeldaWalk;
                    });
                  },
                ),
                AnimatedContainer(
                  duration: Duration(
                      milliseconds: isBegining
                          ? 2000
                          : isChangeMap
                              ? 2000
                              : 200),
                  curve: Curves.linear,
                  alignment: Alignment(zeldaX, zeldaY),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: ZeldaWalk(
                      isZeldaWalk: isZeldaWalk,
                      direction: direction,
                    ),
                  ),
                  onEnd: () {
                    if (isBegining) {
                      playIntro();
                    }
                    setState(() {
                      isChangeMap = false;
                      isBegining = false;
                    });
                  },
                ),
                Positioned(
                  top: 70,
                  left: 140,
                  child: Visibility(
                    visible: isBegining,
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Color(
                        // 0xff000000,
                        0xfffcd8a8,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 40),
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            "B",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (audioMainPlayer.playing) {
                      setState(() {
                        audioMainPlayer.stop();
                      });
                    } else {
                      setState(() {
                        audioMainPlayer.play();
                      });
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Icon(
                      !audioMainPlayer.playing
                          ? Icons.volume_off
                          : Icons.volume_up_rounded,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/nes_logo.png",
                  width: 150,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  actionMove(action) {
    if (!isChangeMap) {
      print(action);
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        print(action + " " + timer.tick.toString());
        setState(() {
          direction = action;
        });
        switch (action) {
          case "up":
            if (zeldaY > -1) {
              setState(() {
                isZeldaWalk = !isZeldaWalk;
                zeldaY -= 0.1;
              });
            } else {
              setState(() {
                isChangeMap = true;
                initPositionedY -= 376;
                zeldaY = 1;
                timer.cancel();
              });
            }
            break;
          case "down":
            if (zeldaY < 1) {
              setState(() {
                isZeldaWalk = !isZeldaWalk;
                zeldaY += 0.1;
              });
            } else {
              setState(() {
                isChangeMap = true;
                initPositionedY += 376;
                zeldaY = -1;
                timer.cancel();
              });
            }
            break;
          case "left":
            if (zeldaX > -1) {
              setState(() {
                isZeldaWalk = !isZeldaWalk;
                zeldaX -= 0.1;
              });
            } else {
              setState(() {
                isChangeMap = true;
                initPositionedX -= 545;
                zeldaX = 1;
                timer.cancel();
              });
            }
            break;
          case "right":
            if (zeldaX < 1) {
              setState(() {
                isZeldaWalk = !isZeldaWalk;
                zeldaX += 0.1;
              });
            } else {
              setState(() {
                isChangeMap = true;
                initPositionedX += 545;
                zeldaX = -1;
                timer.cancel();
              });
            }
            break;
          default:
            print("other");
            break;
        }
      });
    } else {
      if (timer != null) {
        setState(() {
          timer!.cancel();
        });
      }
    }
  }
}
