import 'package:flutter_test/flutter_test.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/models/bus_stop_list_model.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/models/bus_stop_model.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';

import '../../../../mocks/mocks_reader.dart';

void main() {
  final busStopList = [BusStopModel(id: 1, label: "TEST")];
  final testBusStopListModel =
      BusStopsListModel(busStopList: busStopList, description: "TEST");

  test("Should be a subclass of [BusStopList]", () {
    expect(testBusStopListModel, isA<BusStopsList>());
  });

  test("Should return a valid [BusStopList] from a json", () {
    final jsonMap = getDecodedJson("all_bus_stops.json");
    final expectedResult = BusStopsListModel.fromJson(jsonMap);
    expect(expectedResult, testBusStopListModel);
  });

  test("Should return a valid jsonMap from [BusStopList]", () {
    final expectedResult = {
      "description": "TEST",
      "stops": busStopList,
    };

    expect(expectedResult, testBusStopListModel.toJson());
  });
}
