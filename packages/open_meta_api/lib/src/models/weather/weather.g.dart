// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityTemperature _$CityTemperatureFromJson(Map<String, dynamic> json) =>
    CityTemperature(
      temperature: (json['temperature'] as num).toDouble(),
      weathercode: json['weathercode'] as int,
    );

Map<String, dynamic> _$CityTemperatureToJson(CityTemperature instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'weathercode': instance.weathercode,
    };
