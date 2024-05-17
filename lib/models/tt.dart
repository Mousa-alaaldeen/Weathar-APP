class Tt {
  final int dt;
  final Main main;
  final List<Weath> weather;
  final Clouds clouds;
  final Wind wind;
  final String dtTxt;

  Tt({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.dtTxt,
  });

  factory Tt.fromJson(Map<String, dynamic> json) {
    return Tt(
      dt: json['dt'],
      main: Main.fromJson(json['main']),
      weather: (json['weather'] as List).map((i) => Weath.fromJson(i)).toList(),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      dtTxt: json['dt_txt'],
    );
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
    );
  }
}

class Weath {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weath({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weath.fromJson(Map<String, dynamic> json) {
    return Weath(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Wind {
  final double speed;
  final int deg;

  Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
    );
  }
}
