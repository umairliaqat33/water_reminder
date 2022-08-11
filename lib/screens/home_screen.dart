import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  bool messageVisible = false;
  double sWidth=0;
  double sHeight=0;
  @override
  Widget build(BuildContext context) {
    sWidth=MediaQuery.of(context).size.width;
    sHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffC6DFE8),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("images/img_3.png"),
                Container(
                  width: sWidth*0.7,
                  height: 64,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xff4FA8C5),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: Text(
                      "Do not drink cold water immediately after hot drinks",
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 102,
              width: sWidth*0.9,
              decoration: BoxDecoration(
                color: Color(0xffF1F7F9),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 164,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.glassWater,
                          color: Color(0xff4FA8C5),
                          size: 30,
                        ),
                        Text(
                          "Ideal water intake",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "2810 ml",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 3,
                    child: Container(
                      color: Color(0xff4FA8C5),
                    ),
                  ),
                  Container(
                    width: 164,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.trophy,
                          color: Color(0xffFFCE31),
                        ),
                        Text(
                          "Ideal water intake",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "2810 ml",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 237,
              width: 328,
              decoration: BoxDecoration(
                color: Color(0xffF1F7F9),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 205,
                    width: 85,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xff245F81),
                                  Color(0xff4FA8C5),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 240,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "250 ml",
                          style: TextStyle(
                            color: Color(0xff393939),
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "800",
                              style: TextStyle(
                                color: Color(0xff4FA8C5),
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "/2600",
                              style: TextStyle(
                                color: Color(0xff393939),
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "ml",
                              style: TextStyle(
                                color: Color(0xff393939),
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "You have completed 30% of your Daily Target",
                          maxLines: 2,
                          style: TextStyle(
                            color: Color(0xff393939),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
