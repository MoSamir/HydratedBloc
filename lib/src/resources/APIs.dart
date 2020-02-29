import 'package:flutter_app/src/model/ErrorViewModel.dart';
import 'package:flutter_app/src/model/ResponseModel.dart';
import 'package:flutter_app/src/resources/Constants.dart';
import 'package:weather/weather.dart';

class APIs {
  static loadWeatherFromAPI() async {
    try {
      WeatherStation weatherStation =
          new WeatherStation(Constants.WEATHER_API_KEY);

      List<Weather> forecasts = await weatherStation.fiveDayForecast();
      if (forecasts == null) {
        forecasts = List<Weather>();
      }
      print(' forecast after comming $forecasts');
      return ResponseModel(
        errorViewModel: null,
        success: true,
        successData: forecasts,
      );
    } catch (ex) {
      print('Exception accured while loading data => $ex');
      return ResponseModel(
        errorViewModel: ErrorViewModel(errorCode: -1, errorMessage: ex),
        success: false,
        successData: null,
      );
    }
  }
}
