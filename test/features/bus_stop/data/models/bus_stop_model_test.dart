import 'package:flutter_test/flutter_test.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/models/bus_stop_model.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';

import '../../../../mocks/mocks_reader.dart';

void main() {
  final testBusStopModel = BusStopModel(id: 1, label: "TEST");

  test("Should be a subclass of [BusStop] entity", () {
    expect(testBusStopModel, isA<BusStop>());
  });

  test('should return valid [BusStop] from a Json', () {
    final jsonMap = getDecodedJson("bus_stop.json");
    final expectedResult = BusStopModel.fromJson(jsonMap);
    expect(expectedResult, testBusStopModel);
  });

  test("should return valid json from [BusStop]", () {
    final jsonResult = testBusStopModel.toJson();
    final expectedJson = {"id": 1, "label": "TEST"};
    expect(jsonResult, expectedJson);
  });
}
