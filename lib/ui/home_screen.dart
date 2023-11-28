import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:weather_app/models/api_model.dart';
import 'package:weather_app/models/intial.dart';
import 'package:weather_app/ui/forecast_screen.dart';
import 'package:weather_app/widgets/weatherIcon.dart';
import '../models/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Constants constants = Constants();
  Initial initial = Initial();

  void fetchSearchData(String searchData) async {
    try {
      var search =
          await http.get(Uri.parse(WeatherApi.searchWeatherAPI + searchData));

      final weatherData = Map<String, dynamic>.from(
          json.decode(search.body) ?? 'there is no data here');

      var locationData = weatherData['location'];

      var currentData = weatherData['current'];

      setState(() {
        initial.location = getShortLocationName(locationData['name']);

        var dataTime = DateTime.parse(
            locationData["localtime"].toString().substring(0, 10));

        var newData = DateFormat("MMMMEEEEd").format(dataTime);

        initial.currentDate = newData;

        initial.currentWeatherStatus = currentData["condition"]["text"];
        initial.weatherIcon =
            '${initial.currentWeatherStatus.replaceAll(' ', '').toLowerCase()}.png';
        initial.temperature = currentData["temp_c"].toInt();
        initial.cloud = currentData["cloud"].toInt();
        initial.windSpeed = currentData["wind_kph"].toInt();
        initial.humidity = currentData["humidity"].toInt();
        initial.dailyWeatherForecast = weatherData["forecast"]["forecastday"];
        initial.hourlyWeatherForecast = initial.dailyWeatherForecast[0]["hour"];
      });
    } catch (e) {
      AlertDialog(
        title: Text('please check your connection $e'),
        actions: [
          FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ok'))
        ],
      );
    }
  }

  String getShortLocationName(String string) {
    List<String> stringList = string.split(' ');
    if (stringList.isNotEmpty) {
      if (stringList.length > 1) {
        return '${stringList[0]} ${stringList[1]}';
      } else {
        return stringList[0];
      }
    } else {
      return " ";
    }
  }

  @override
  void initState() {
    fetchSearchData(initial.location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    TextEditingController searchController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          width: size.width,
          height: size.height,
          color: constants.primaryColor.withOpacity(.1),
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: size.height * .6,
                decoration: BoxDecoration(
                    gradient: constants.linearGradientBlue,
                    boxShadow: [
                      BoxShadow(
                          color: constants.primaryColor.withOpacity(.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.circular(12)),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.border_all_rounded,
                                color: Colors.white,
                                size: 40,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    initial.location,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        searchController.clear();
                                        showMaterialModalBottomSheet(
                                            context: context,
                                            builder:
                                                (context) =>
                                                    SingleChildScrollView(
                                                      controller:
                                                          ModalScrollController
                                                              .of(context),
                                                      child: Container(
                                                        height:
                                                            size.height * .6,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 20,
                                                                vertical: 10),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                                width: 70,
                                                                child: Divider(
                                                                  thickness:
                                                                      3.5,
                                                                  color: constants
                                                                      .primaryColor,
                                                                )),
                                                            const SizedBox(
                                                                height: 10),
                                                            TextField(
                                                              onChanged:
                                                                  (searchText) {
                                                                fetchSearchData(
                                                                    searchText);
                                                              },
                                                              controller:
                                                                  searchController,
                                                              autofocus: true,
                                                              decoration: InputDecoration(
                                                                  prefixIcon:
                                                                      const Icon(Icons
                                                                          .search),
                                                                  suffixIcon: GestureDetector(
                                                                      onTap: () => searchController
                                                                          .clear(),
                                                                      child: const Icon(Icons
                                                                          .clear)),
                                                                  hintText:
                                                                      "search for city e.g london",
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: constants.primaryColor))),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                      },
                                      icon: const Icon(Icons.arrow_drop_down))
                                ],
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/profile.png',
                                      width: 35))
                            ]),
                        SizedBox(
                            height: size.height * .2,
                            child:
                                Image.asset('assets/${initial.weatherIcon}')),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Text(
                                  initial.temperature.toString(),
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = constants.shader),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text('o',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = constants.shader))
                            ]),
                        Text(initial.currentWeatherStatus,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                foreground: Paint()
                                  ..shader = constants.shader)),
                        Text(initial.currentDate,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                foreground: Paint()
                                  ..shader = constants.shader)),
                        Divider(thickness: 2, color: constants.primaryColor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WeatherIcon(
                                text: 'wind speed',
                                value: initial.windSpeed.toInt(),
                                unit: 'km',
                                imageUrl: 'assets/wind.png'),
                            WeatherIcon(
                                text: 'humidity',
                                value: initial.humidity.toInt(),
                                unit: '%',
                                imageUrl: 'assets/humidity.png'),
                            WeatherIcon(
                                text: 'clouds',
                                value: initial.cloud.toInt(),
                                unit: '%',
                                imageUrl: 'assets/cloudy.png'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * .3,
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Today",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: constants.primaryColor)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ForecastScreen(
                                        dailyForcastWeather:
                                            initial.dailyWeatherForecast)));
                          },
                          child: Row(
                            children: [
                              Text("More",
                                  style: TextStyle(
                                      color: constants.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.arrow_forward_ios,
                                  size: 15, color: constants.primaryColor)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: size.height * .19,
                      child: ListView.builder(
                          itemCount: initial.hourlyWeatherForecast.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            String time =
                                DateFormat("HH:mm:ss").format(DateTime.now());
                            String forecastTime = initial
                                .hourlyWeatherForecast[index]["time"]
                                .toString()
                                .substring(11, 16);
                            String forecastHour =
                                initial.hourlyWeatherForecast[index]["time"]
                                .toString()
                                .substring(11, 13);
                            String weatherStatus =
                                initial.hourlyWeatherForecast[index]
                                    ["condition"]["text"];
                            String weatherTemperature =
                                "${initial.hourlyWeatherForecast[index]["temp_c"]} c";
                            String weatherIco =
                                "${weatherStatus.replaceAll(" ", "").toLowerCase()}.png";
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              width: 75,
                              decoration: BoxDecoration(
                                  gradient: constants.linearGradientWhiteBlue,
                                  color: time == forecastHour
                                      ? Colors.white
                                      : constants.primaryColor.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(3, 1),
                                        color: constants.primaryColor
                                            .withOpacity(.5),
                                        blurRadius: 4)
                                  ]),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(forecastTime,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                    Image.asset("assets/$weatherIco",
                                        width: 35),
                                    Text(weatherTemperature,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600))
                                  ]),
                            );
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
