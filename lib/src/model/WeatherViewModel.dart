import 'package:weather/weather.dart';

class WeatherViewModel {
  DateTime forecastDate;
  String maxTemp, minTemp, temp, windSpeed, airPressure, airHumidity;
  String tempIcon, areaName, forecastDescription;

  WeatherViewModel({
    this.forecastDate,
    this.forecastDescription,
    this.maxTemp,
    this.minTemp,
    this.temp,
    this.tempIcon,
    this.airPressure,
    this.areaName,
    this.windSpeed,
    this.airHumidity,
  });

  @override
  // TODO: implement hashCode
  int get hashCode => forecastDate.day.hashCode;

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return forecastDate.day == other.forecastDate.day &&
        forecastDate.month == other.forecastDate.month &&
        areaName == other.areaName;
  }

  static fromJson(Map<String, dynamic> json) => WeatherViewModel(
        forecastDate: json[WeatherViewModelJsonKeys.DAY_KEY],
        maxTemp: json[WeatherViewModelJsonKeys.MAX_TEMP_KEY],
        minTemp: json[WeatherViewModelJsonKeys.MIN_TEMP_KEY],
        temp: json[WeatherViewModelJsonKeys.TEMP_KEY],
        tempIcon: json[WeatherViewModelJsonKeys.ICON_KEY],
        airHumidity: json[WeatherViewModelJsonKeys.AIR_HUMIDITY_KEY],
        airPressure: json[WeatherViewModelJsonKeys.AIR_PRESSURE_KEY],
        areaName: json[WeatherViewModelJsonKeys.AREA_NAME_KEY],
        windSpeed: json[WeatherViewModelJsonKeys.WIND_SPEED_KEY],
        forecastDescription:
            json[WeatherViewModelJsonKeys.WEATHER_DESCRIPTION_KEY],
      );

  toJson() => {
        WeatherViewModelJsonKeys.DAY_KEY: this.forecastDate,
        WeatherViewModelJsonKeys.MAX_TEMP_KEY: this.maxTemp,
        WeatherViewModelJsonKeys.MIN_TEMP_KEY: this.minTemp,
        WeatherViewModelJsonKeys.TEMP_KEY: this.temp,
        WeatherViewModelJsonKeys.ICON_KEY: this.tempIcon,
        WeatherViewModelJsonKeys.AIR_HUMIDITY_KEY: this.airHumidity,
        WeatherViewModelJsonKeys.AIR_PRESSURE_KEY: this.airPressure,
        WeatherViewModelJsonKeys.AREA_NAME_KEY: this.areaName,
        WeatherViewModelJsonKeys.WIND_SPEED_KEY: this.windSpeed,
        WeatherViewModelJsonKeys.WEATHER_DESCRIPTION_KEY:
            this.forecastDescription,
      };

  static fromApiResponse(Weather weather) => WeatherViewModel(
        temp: weather.temperature.celsius.toStringAsFixed(0),
        forecastDescription: weather.weatherDescription,
        minTemp: weather.tempMin.celsius.toStringAsFixed(0),
        maxTemp: weather.tempMax.celsius.toStringAsFixed(0),
        forecastDate: weather.date,
        windSpeed: weather.windSpeed.toStringAsFixed(1),
        areaName: weather.areaName,
        airPressure: weather.pressure.toStringAsFixed(1),
        airHumidity: weather.humidity.toStringAsFixed(1),
        tempIcon: 'http://openweathermap.org/img/w/${weather.weatherIcon}.png',
      );
}

class WeatherViewModelJsonKeys {
  static const String MAX_TEMP_KEY = "max_temp";
  static const String MIN_TEMP_KEY = "min_temp";
  static const String TEMP_KEY = "temp";
  static const String DAY_KEY = "day";
  static const String ICON_KEY = "icon";
  static const String AREA_NAME_KEY = "area_name";
  static const String AIR_PRESSURE_KEY = "air_pressure";
  static const String AIR_HUMIDITY_KEY = "humidity";
  static const String WIND_SPEED_KEY = "wind_speed";
  static const String WEATHER_DESCRIPTION_KEY = "weather_description";
}
