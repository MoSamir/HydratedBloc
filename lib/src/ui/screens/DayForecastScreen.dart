import 'package:flutter/material.dart';
import 'package:flutter_app/src/model/WeatherViewModel.dart';
import 'package:flutter_app/src/resources/Constants.dart';
import 'package:flutter_app/src/ui/list_cards/WeatherStatisticCard.dart';
import 'package:flutter_app/src/ui/widgets/DayHeaderWidget.dart';

class DayForecastScreen extends StatelessWidget {
  final WeatherViewModel weatherDay;
  DayForecastScreen({this.weatherDay});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String backgroundImage = DateTime.now().hour > 12
        ? Resources.NIGHT_BACKGROUND_IMAGE
        : Resources.MORNING_BACKGROUND_IMAGE;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(backgroundImage),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 150,
                child: DayHeaderWidget(
                  weatherModel: weatherDay,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                direction: Axis.horizontal,
                spacing: 5,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  WeatherStatisticCard(
                    cardColor: Color.fromARGB(100, 185, 58, 87),
                    iconPath: Resources.WIND_SPEED_ICON,
                    cardInfo: 'Wind',
                    statisticValue: '${weatherDay.windSpeed} km/h',
                  ),
                  WeatherStatisticCard(
                    cardColor: Color.fromARGB(100, 167, 75, 113),
                    iconPath: Resources.AIR_HUMIDITY_ICON,
                    cardInfo: 'Humidity',
                    statisticValue: '${weatherDay.airHumidity} %',
                  ),
                  WeatherStatisticCard(
                    cardColor: Color.fromARGB(100, 167, 75, 113),
                    iconPath: Resources.AIR_PRESSURE_ICON,
                    cardInfo: 'Air Pressure',
                    statisticValue: '${weatherDay.airPressure} hpa',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
