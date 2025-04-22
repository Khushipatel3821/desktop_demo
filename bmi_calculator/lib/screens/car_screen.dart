import 'package:flutter/material.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              buildTopRow(),
              buildMiddleSection(),
              buildBottomRow(),
              buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopRow() {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CarPart(
              imagePath: 'assets/images/rim_no_damage_one.png',
              onTap: () {
                print("top left rim clicked");
              },
            ),
          ),
          Expanded(
            child: CarPart(
              imagePath: 'assets/images/bumper_frnt_no_damage_one.png',
              onTap: () {
                print("bumper front clicked");
              },
            ),
          ),
          Expanded(
            child: CarPart(
              imagePath: 'assets/images/rim_no_damage_one.png',
              onTap: () {
                print("top right rim clicked");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMiddleSection() {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CarPart(
                          imagePath: 'assets/images/tyre_no_damage_one.png',
                          onTap: () {
                            print("top left tyre clicked");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CarPart(
                          imagePath:
                          'assets/images/fender_left_no_damage_one.png',
                          onTap: () {
                            print("left fender clicked");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CarPart(
                    imagePath: 'assets/images/a_pillar_left_no_damage_one.png',
                    onTap: () {
                      print("piller left clicked");
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CarPart(
                          imagePath:
                          'assets/images/head_light_left_no_damage_one.png',
                          onTap: () {
                            print("left headlight clicked");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CarPart(
                          imagePath: 'assets/images/grille_no_damage_one.png',
                          onTap: () {
                            print("grill clicked");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CarPart(
                          imagePath:
                          'assets/images/head_light_right_no_damage_one.png',
                          onTap: () {
                            print("right headlight clicked");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CarPart(
                    imagePath: 'assets/images/bonnet_no_damage_one.png',
                    onTap: () {
                      print("bonnet clicked");
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CarPart(
                          imagePath:
                          'assets/images/fender_right_no_damage_one.png',
                          onTap: () {
                            print("fender right clicked");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CarPart(
                          imagePath: 'assets/images/tyre_no_damage_one.png',
                          onTap: () {
                            print("top right tyre clicked");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CarPart(
                    imagePath: 'assets/images/a_pillar_right_no_damage_one.png',
                    onTap: () {
                      print("right pillar clicked");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomRow() {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CarPart(
              imagePath: 'assets/images/running_board_left_no_damage_one.png',
              onTap: () {
                print("running board left clicked");
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: CarPart(
                    imagePath:
                    'assets/images/door_front_left_no_damage_one.png',
                    onTap: () {
                      print("door front left clicked");
                    },
                  ),
                ),
                Expanded(
                  child: CarPart(
                    imagePath: 'assets/images/door_rear_left_no_damage_one.png',
                    onTap: () {
                      print("door rear left clicked");
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: CarPart(
                    imagePath:
                    'assets/images/windshield_front_no_damage_one.png',
                    onTap: () {
                      print("windshield front clicked");
                    },
                  ),
                ),
                Expanded(
                  child: CarPart(
                    imagePath: 'assets/images/roof_no_damage_one.png',
                    onTap: () {
                      print("roof clicked");
                    },
                  ),
                ),
                Expanded(
                  child: CarPart(
                    imagePath:
                    'assets/images/windshield_rear_no_damage_one.png',
                    onTap: () {
                      print("windshield rear clicked");
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: CarPart(
                    imagePath:
                    'assets/images/door_front_right_no_damage_one.png',
                    onTap: () {
                      print("door front right clicked");
                    },
                  ),
                ),
                Expanded(
                  child: CarPart(
                    imagePath:
                    'assets/images/door_rear_right_no_damage_one.png',
                    onTap: () {
                      print("door rear right clicked");
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: CarPart(
              imagePath: 'assets/images/running_board_right_no_damage_one.png',
              onTap: () {
                print("running board right clicked");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        child: CarPart(
                          imagePath: 'assets/images/tyre_no_damage_one.png',
                          onTap: () {
                            print("rear left tyre clicked");
                          },
                        ),
                      ),
                      Expanded(
                        child: CarPart(
                          imagePath: 'assets/images/rim_no_damage_one.png',
                          onTap: () {
                            print("rear left rim clicked");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CarPart(
                    imagePath:
                    'assets/images/quarter_panel_left_no_damage_one.png',
                    onTap: () {
                      print("quarter panel left clicked");
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CarPart(
                          imagePath: 'assets/images/dicky_no_damage_one.png',
                          onTap: () {
                            print("dicky clicked");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: CarPart(
                                imagePath:
                                'assets/images/tail_light_left_no_damage_one.png',
                                onTap: () {
                                  print("tail light left clicked");
                                },
                              ),
                            ),
                            Expanded(
                              child: CarPart(
                                imagePath:
                                'assets/images/tail_light_right_no_damage_one.png',
                                onTap: () {
                                  print("tail light right clicked");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CarPart(
                          imagePath:
                          'assets/images/bumper_rear_no_damage_one.png',
                          onTap: () {
                            print("bumper rear clicked");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CarPart(
                    imagePath:
                    'assets/images/quarter_panel_right_no_damage_one.png',
                    onTap: () {
                      print("quarter panel right clicked");
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CarPart(
                          imagePath: 'assets/images/tyre_no_damage_one.png',
                          onTap: () {
                            print("rear right tyre clicked");
                          },
                        ),
                      ),
                      Expanded(
                        child: CarPart(
                          imagePath: 'assets/images/rim_no_damage_one.png',
                          onTap: () {
                            print("rear right rim clicked");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  print("proceed btn clicked");
                },
                child: Text(
                  'Proceed',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarPart extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const CarPart({
    Key? key,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(imagePath),
    );
  }
}
