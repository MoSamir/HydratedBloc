import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherStatisticCard extends StatelessWidget {
  final String cardInfo, statisticValue, iconPath;
  final Color cardColor;
  final TextStyle headerTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  WeatherStatisticCard(
      {this.cardColor, this.cardInfo, this.iconPath, this.statisticValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 105,
      child: Card(
        color: cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    iconPath,
                    width: 50,
                    height: 50,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    statisticValue,
                    style: headerTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              foregroundDecoration: BoxDecoration(
                backgroundBlendMode: BlendMode.darken,
                color: Colors.black26,
              ),
              child: Center(
                child: Text(
                  cardInfo,
                  style: headerTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
