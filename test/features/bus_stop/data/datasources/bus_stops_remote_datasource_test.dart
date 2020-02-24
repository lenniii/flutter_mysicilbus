import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sicilbus_clean_arch/core/errors/errros.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/datasources/bus_stops_remote_datasource.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/models/bus_stop_list_model.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/models/bus_stop_model.dart';

import '../../../../mocks/mocks_reader.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  MockHttpClient mockDioClient;
  BusStopsRemoteDatasource remoteDatasourceImpl;
  final testBusStop = BusStopModel(id: 1, label: "TEST");
  final busStopList = [testBusStop];
  final testBusStopListModel =
      BusStopsListModel(busStopList: busStopList, description: "TEST");

  final testDateTime = DateTime.now();

  setUp(() {
    mockDioClient = MockHttpClient();
    remoteDatasourceImpl = BusStopsRemoteDatasourceImpl(client: mockDioClient);
  });

  test("Should return data from API call", () async {
    when(mockDioClient.get(any)).thenAnswer((_) async =>
        Response(data: mockReader("all_bus_stops.json"), statusCode: 200));
    remoteDatasourceImpl.getAllBusStops();
    verify(mockDioClient.get("http://localhost:3001"));
  });

  test("Should return [BusStopsListModel] from API call if response is 200",
      () async {
    when(mockDioClient.get(any)).thenAnswer((_) async =>
        Response(data: mockReader("all_bus_stops.json"), statusCode: 200));
    final result = await remoteDatasourceImpl.getAllBusStops();
    expect(result, testBusStopListModel);
  });
  test("Should return [ServerError] if response is not 200", () async {
    when(mockDioClient.get(any))
        .thenAnswer((_) async => Response(data: "", statusCode: 400));
    final apiCall = remoteDatasourceImpl.getAllBusStops;
    expect(() => apiCall(), throwsA(isInstanceOf<ServerException>()));
  });
  test("Should do a POST call to api", () async {
    when(mockDioClient.post(any,
            data: anyNamed("data"), options: anyNamed("options")))
        .thenAnswer((_) async =>
            Response(data: mockReader("all_bus_stops.json"), statusCode: 200));
    remoteDatasourceImpl.getBusStopsFromBusStop(testBusStop, testDateTime);
    verify(mockDioClient.post("http://localhost:3001",
        data: anyNamed("data"), options: anyNamed("options")));
  });
  test("Should return [BusStopsList after a post request if status code is 200",
      () async {
    when(mockDioClient.post(any,
            data: anyNamed("data"), options: anyNamed("options")))
        .thenAnswer((_) async =>
            Response(data: mockReader("all_bus_stops.json"), statusCode: 200));
    final expectedResult = await remoteDatasourceImpl.getBusStopsFromBusStop(
        testBusStop, testDateTime);
    expect(expectedResult, testBusStopListModel);
  });
  test(
      "Should return [SERVER ERROR] after a post request if statuscode is not 200",
      () async {
    when(mockDioClient.post(any,
            data: anyNamed("data"), options: anyNamed("options")))
        .thenAnswer(
            (_) async => Response(data: "Server Error", statusCode: 400));
    final expectedResult = remoteDatasourceImpl.getBusStopsFromBusStop;
    expect(() => expectedResult(testBusStop, testDateTime),
        throwsA(isInstanceOf<ServerException>()));
  });
}
