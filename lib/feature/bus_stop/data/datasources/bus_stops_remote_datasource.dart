import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sicilbus_clean_arch/core/errors/errros.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/models/bus_stop_list_model.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';
import 'package:meta/meta.dart';

abstract class BusStopsRemoteDatasource {
  Future<BusStopsListModel> getAllBusStops();
  Future<BusStopsListModel> getBusStopsFromBusStop(
      BusStop busStop, DateTime dateTime);
}

class BusStopsRemoteDatasourceImpl implements BusStopsRemoteDatasource {
  final Dio client;

  BusStopsRemoteDatasourceImpl({@required this.client});
  @override
  Future<BusStopsListModel> getAllBusStops() async {
    final apiCall = await client.get("http://localhost:3001");
    if (apiCall.statusCode == 200) {
      return BusStopsListModel.fromJson(json.decode(apiCall.data));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<BusStopsListModel> getBusStopsFromBusStop(
      BusStop busStop, DateTime dateTime) async {
    final options = Options(headers: {"Content-Type": "application/json"});
    final response = await client.post(
      "http://localhost:3001",
      data: {"start": busStop.id, "datetime": DateTime.now().toString()},
      options: options,
    );
    if (response.statusCode == 200)
      return BusStopsListModel.fromJson(json.decode(response.data));
    else
      throw ServerException();
  }
}
