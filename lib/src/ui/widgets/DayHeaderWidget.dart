import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/WeatherViewModel.dart';

class DayHeaderWidget extends StatelessWidget {
  final WeatherViewModel weatherModel;
  DayHeaderWidget({this.weatherModel});
  final TextStyle headerTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 19,
  );

  @override
  Widget build(BuildContext context) {
    bool areaNameResolved =
        (weatherModel.areaName != null && weatherModel.areaName.length > 0);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '${weatherModel.temp}',
            style: headerTextStyle.copyWith(
              fontSize: 50,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            weatherModel.forecastDescription,
            style: headerTextStyle,
          ),
          Text(
            '${areaNameResolved ? weatherModel.areaName : 'Unknown area name'}',
            style: areaNameResolved
                ? headerTextStyle
                : headerTextStyle.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
          ),
        ],
      ),
    );
  }
}
