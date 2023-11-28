import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/constant.dart';
import 'package:weather_app/ui/sittings_screen.dart';
import 'package:weather_app/widgets/weatherIcon.dart';

class ForecastScreen extends StatefulWidget {
  final List dailyForcastWeather;

  const ForecastScreen({super.key, required this.dailyForcastWeather});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  Map getForcastDetails(int i) {
    var forecast = widget.dailyForcastWeather;
    int maxWindSpeed = forecast[i]["day"]["maxwind_kph"].toInt();
    int avgTempC = forecast[i]["day"]["avgtemp_c"].toInt();
    int maxTempC = forecast[i]["day"]["maxtemp_c"].toInt();
    int minTempC = forecast[i]["day"]["mintemp_c"].toInt();
    int avgHumidity = forecast[i]["day"]["avghumidity"].toInt();
    int dailyChanceOfRain =
    forecast[i]["day"]["daily_chance_of_rain"].toInt();
    int dailyChanceOfSnow =
    forecast[i]["day"]["daily_chance_of_snow"].toInt();
    DateTime parsedData = DateTime.parse(forecast[i]["date"]);
    String time = DateFormat("EEE d MMMM").format(parsedData);

    String weatherName = forecast[i]["day"]["condition"]["text"];
    String weatherIco =
        "${weatherName.replaceAll(' ', '').toLowerCase()}.png";

    Map<String, dynamic> forcasting = {
      "minTempC": minTempC,
      "maxTempC": maxTempC,
      "avgTempC": avgTempC,
      "maxWindSpeed": maxWindSpeed,
      "avgHumidity": avgHumidity,
      "dailyChanceOfRain": dailyChanceOfRain,
      "dailyChanceOfSnow": dailyChanceOfSnow,
      "time": time,
      "weatherName": weatherName,
      "weatherIco": weatherIco
    };
    return forcasting;
  }

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: constants.primaryColor,
      appBar: AppBar(
        title: const Text('Forecasting'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const SettingsScreen()));
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            child: Text(
            getForcastDetails(0)["time"].toString().substring(4,10),
            style: TextStyle(
                color: Colors.white
                    .withOpacity(.9),
                fontSize: 25,
                fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
          ),),
          Positioned(
              bottom: 0,
              child: Container(
                height: size.height * .8,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150),
                      topRight: Radius.circular(150)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        right: 20,
                        left: 20,
                        child: Container(
                          height: size.height * .22,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: constants.linearGradientWhiteBlue,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        constants.primaryColor.withOpacity(.3),
                                    spreadRadius: 5,
                                    blurRadius: 8,
                                    offset: const Offset(0, 5))
                              ]),
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 20,
                                  left: 20,
                                  child: Image.asset(
                                    "assets/${getForcastDetails(0)["weatherIco"]}",
                                    width: 100,
                                  )),
                              Positioned(
                                  top: 120,
                                  left: 25,
                                  child: Text(
                                    getForcastDetails(0)["weatherName"],
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        )),

                    //Positioned for max wind, average humidity and average temp
                    Positioned(
                      top: size.height * .26,
                      left: 20,
                      right: 20,
                      height: size.height * .15,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: constants.linearGradientWhiteBlue,
                            boxShadow: [
                              BoxShadow(
                                  color: constants.primaryColor.withOpacity(.3),
                                  spreadRadius: 5,
                                  blurRadius: 8,
                                  offset: const Offset(0, 5))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WeatherIcon(
                                value: getForcastDetails(0)["maxWindSpeed"],
                                unit: 'km/h',
                                imageUrl: 'assets/wind.png',
                                text: "max wind speed"),
                            WeatherIcon(
                                value: getForcastDetails(0)["avgHumidity"],
                                unit: '%',
                                imageUrl: 'assets/humidity.png',
                                text: "average humidity"),
                            WeatherIcon(
                                value: getForcastDetails(0)["avgTempC"],
                                unit: 'c',
                                imageUrl: 'assets/tempreture.png',
                                text: "average temp"),
                          ],
                        ),
                      ),
                    ),

                    //the big temp degree
                    Positioned(
                        top: 20,
                        right: 50,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getForcastDetails(0)["maxTempC"].toString(),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                  fontSize: 100,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(.9)),
                            ),
                            Text(
                              'o',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(.9)),
                            ),
                          ],
                        )),
                    
                    //min and max degree
                    Positioned(
                        height: size.height * .1,
                        left: 20,
                        right: 20,
                        top: size.height * .45,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              // gradient: constants.linearGradientWhiteBlue,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        constants.primaryColor.withOpacity(.4),
                                    spreadRadius: 5,
                                    blurRadius: 8,
                                    offset: const Offset(0, 5))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Text(
                                    getForcastDetails(0)["time"].toString().substring(0,3),
                                    style: TextStyle(
                                        color: constants.primaryColor
                                            .withOpacity(.6),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const VerticalDivider(thickness: .5,color: Colors.grey,indent: 10,endIndent: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "min temp",
                                        style: TextStyle(
                                            color: constants.primaryColor
                                                .withOpacity(.6),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        getForcastDetails(0)["minTempC"]
                                            .toString(),
                                        style: TextStyle(
                                            color: constants.primaryColor
                                                .withOpacity(.6),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const VerticalDivider(
                                      thickness: .5,
                                      color: Colors.grey,
                                      indent: 10,
                                      endIndent: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "max temp  ",
                                        style: TextStyle(
                                            color: constants.primaryColor
                                                .withOpacity(.6),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            getForcastDetails(0)["maxTempC"]
                                                .toString(),
                                            style: TextStyle(
                                                color: constants.primaryColor
                                                    .withOpacity(.6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 10)
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    
                    // position of chances
                    Positioned(
                        left: 20,
                        right: 20,
                        top: size.height * .58,
                        height: size.height * .15,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: constants.linearGradientWhiteBlue,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        constants.primaryColor.withOpacity(.3),
                                    spreadRadius: 5,
                                    blurRadius: 8,
                                    offset: const Offset(0, 5))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              WeatherIcon(
                                  value:
                                      getForcastDetails(0)["dailyChanceOfRain"],
                                  unit: '%',
                                  imageUrl: 'assets/rainy.png',
                                  text: "chance of rain"),
                              WeatherIcon(
                                  value:
                                      getForcastDetails(0)["dailyChanceOfSnow"],
                                  unit: '%',
                                  imageUrl: 'assets/snow.png',
                                  text: "chance of snow"),
                            ],
                          ),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
