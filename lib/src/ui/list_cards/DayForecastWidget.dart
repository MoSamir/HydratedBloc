import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/WeatherViewModel.dart';
import 'package:intl/intl.dart';

class DayForecastWidget extends StatelessWidget {
  final WeatherViewModel weatherModel;
  final Function onCardPress;
  DayForecastWidget({this.weatherModel, this.onCardPress});

  final TextStyle headerTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    fontSize: 14,
  );

  getDayName() {
    return DateFormat.E().format(weatherModel.forecastDate) ==
            DateFormat.E().format(DateTime.now())
        ? 'Today'
        : DateFormat.E().format(weatherModel.forecastDate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onCardPress,
        child: Container(
//          decoration: BoxDecoration(boxShadow: [
//            BoxShadow(
//              color: Colors.black.withOpacity(0.02),
//              blurRadius: .5,
//              spreadRadius: 10,
//            ),
//          ]
//          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  getDayName(),
                  style: headerTextStyle,
                ),
              ),
              Image.network(
                weatherModel.tempIcon,
                width: 35,
                height: 35,
                fit: BoxFit.contain,
              ),
              Text(
                '${weatherModel.minTemp} - ${weatherModel.maxTemp}',
                style: headerTextStyle,
              ),
            ],
          ),
        ));
  }
}
