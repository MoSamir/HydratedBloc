import 'APIs.dart';

class Repository {
  static loadWeatherInfo() async => APIs.loadWeatherFromAPI();
}
