import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/model/WeatherViewModel.dart';
import 'package:flutter_app/src/resources/Constants.dart';
import 'package:flutter_app/src/ui/list_cards/DayForecastWidget.dart';
import 'package:flutter_app/src/ui/screens/DayForecastScreen.dart';
import 'package:flutter_app/src/ui/widgets/DayHeaderWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/WeatherBloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  WeatherBloc _weatherBloc = WeatherBloc();
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_weatherBloc.initialState is WeatherFirstLoad) {
      _weatherBloc.add(LoadWeather());
    }

    _assetsAudioPlayer.open(Resources.BACKGROUND_SOUND);
    _assetsAudioPlayer.play();

    _assetsAudioPlayer.finished.listen((streamFinished) {
      if (streamFinished) _assetsAudioPlayer.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String backgroundImage = DateTime.now().hour > 12
        ? Resources.NIGHT_BACKGROUND_IMAGE
        : Resources.MORNING_BACKGROUND_IMAGE;
    return Scaffold(
//        appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(backgroundImage),
          ),
        ),
        height: screenHeight,
        width: screenWidth,
        child: BlocBuilder(
            bloc: _weatherBloc,
            builder: (context, weatherState) {
              if (weatherState is WeatherLoaded) {
                List<WeatherViewModel> weatherData =
                    weatherState.getWeatherDistinct();

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Container(
                    height: screenHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Container(
                              height: 150,
                              child: getTodayHeader(weatherData),
                            ),
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: weatherData.length,
                          itemBuilder: (context, index) {
                            return DayForecastWidget(
                              onCardPress: () async {
                                await SystemSound.play(SystemSoundType.click);

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DayForecastScreen(
                                        weatherDay: weatherData[index],
                                      );
                                    },
                                  ),
                                );
                              },
                              weatherModel: weatherData[index],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else if (weatherState is WeatherLoadingFailed) {
                return Container(
                  child: Center(
                    child: Text(weatherState.failureReason.errorMessage),
                  ),
                );
              } else
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
            }),
      ),
    );
  }

  getTodayHeader(List<WeatherViewModel> weatherResponse) {
    for (int i = 0; i < weatherResponse.length; i++) {
      if (DateFormat.E().format(weatherResponse[i].forecastDate) ==
          DateFormat.E().format(DateTime.now())) {
        return DayHeaderWidget(
          weatherModel: weatherResponse[i],
        );
      }
    }
    return Container();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
