import 'package:flutter_app/src/model/ErrorViewModel.dart';
import 'package:flutter_app/src/model/ResponseModel.dart';
import 'package:flutter_app/src/model/WeatherViewModel.dart';
import 'package:flutter_app/src/resources/Constants.dart';
import 'package:flutter_app/src/resources/NetworkHelper.dart';
import 'package:flutter_app/src/resources/Repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weather/weather.dart';

abstract class WeatherEvents {}

class LoadWeather extends WeatherEvents {
  final int loadPeriod;
  LoadWeather({this.loadPeriod = 5});
}

abstract class WeatherStates {}

class WeatherFirstLoad extends WeatherStates {}

class WeatherLoaded extends WeatherStates {
  final List<WeatherViewModel> weatherResponse;

  List<WeatherViewModel> getWeatherDistinct() {
    print(weatherResponse[0].areaName);
    return weatherResponse.toSet().toList();
  }

  WeatherLoaded({this.weatherResponse});
}

class WeatherLoading extends WeatherStates {}

class WeatherLoadingFailed extends WeatherStates {
  final ErrorViewModel failureReason;
  WeatherLoadingFailed({this.failureReason});
}

class WeatherBloc extends HydratedBloc<WeatherEvents, WeatherStates> {
  @override
  // TODO: implement initialState
  WeatherStates get initialState => super.initialState ?? WeatherFirstLoad();

  @override
  WeatherStates fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return null;
  }

  @override
  Stream<WeatherStates> mapEventToState(WeatherEvents event) async* {
    yield this.state;
    bool isNetworkAvailable = await NetworkHelper.isNetworkAvailable();
    if (isNetworkAvailable == false) {
      yield WeatherLoadingFailed(
        failureReason: ErrorViewModel(
          errorMessage: 'NetworkFailure',
          errorCode: CustomErrorCodes.NO_NETWORK_ERROR_CODE,
        ),
      );
      return;
    }
    if (event is LoadWeather) {
      ResponseModel weatherInfo = await Repository.loadWeatherInfo();
      print("Response returned");
      if (weatherInfo.success) {
        List<WeatherViewModel> weatherData = List();
        (weatherInfo.successData as List<Weather>)
            .forEach((Weather weatherForecast) {
          weatherData.add(WeatherViewModel.fromApiResponse(weatherForecast));
        });
        yield WeatherLoaded(weatherResponse: weatherData);
      } else {
        yield WeatherLoadingFailed(failureReason: weatherInfo.errorViewModel);
      }
      return;
    }
  }

  @override
  Map<String, dynamic> toJson(WeatherStates state) {
    // TODO: implement toJson
    return null;
  }
}
