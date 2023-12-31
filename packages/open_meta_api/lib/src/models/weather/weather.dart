import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class CityTemperature {
  double temperature;
  @JsonKey(name: 'weathercode')
  int weathercode;

  CityTemperature({required this.temperature, required this.weathercode});

  factory CityTemperature.fromJson(Map<String, dynamic> json) {
    return _$CityTemperatureFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CityTemperatureToJson(this);
}
