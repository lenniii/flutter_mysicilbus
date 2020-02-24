import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sicilbus_clean_arch/core/errors/errros.dart';
import 'package:sicilbus_clean_arch/core/errors/failures.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/datasources/bus_stops_remote_datasource.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/models/bus_stop_list_model.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/models/bus_stop_model.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/repostories/bus_stop_repository_impl.dart';

class MockRemoteDataSource extends Mock implements BusStopsRemoteDatasource {}

main() {
  MockRemoteDataSource mockRemoteDataSource;
  BusStopListRepositoryImpl busStopListRepositoryImpl;

  final testBusStop = BusStopModel(id: 1, label: "TEST");
  final testBusStopsList =
      BusStopsListModel(busStopList: [testBusStop], description: "TEST");
  final testDateTime = DateTime.now();

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    busStopListRepositoryImpl = BusStopListRepositoryImpl(
        busStopsRemoteDatasource: mockRemoteDataSource);
  });

  test("Should return remote data when api call is succesful", () async {
    when(mockRemoteDataSource.getAllBusStops())
        .thenAnswer((_) async => testBusStopsList);
    final expectedResult = await busStopListRepositoryImpl.getAllBusStops();
    verify(mockRemoteDataSource.getAllBusStops());
    expect(expectedResult, Right(testBusStopsList));
  });
  test("Should return [ServerFailure] when api call return ServerException",
      () async {
    when(mockRemoteDataSource.getAllBusStops()).thenThrow(ServerException());
    final expectedResult = await busStopListRepositoryImpl.getAllBusStops();
    verify(mockRemoteDataSource.getAllBusStops());
    expect(expectedResult, Left(ServerFailure()));
  });
  test("Should return remote data when api call is succesful", () async {
    when(mockRemoteDataSource.getBusStopsFromBusStop(any, any))
        .thenAnswer((_) async => testBusStopsList);
    final expectedResult = await busStopListRepositoryImpl
        .getBusStopsListFromBusStop(testBusStop, testDateTime);
    verify(
        mockRemoteDataSource.getBusStopsFromBusStop(testBusStop, testDateTime));
    expect(expectedResult, Right(testBusStopsList));
  });
  test("Should return [ServerFailure] when api call return ServerException",
      () async {
    when(mockRemoteDataSource.getBusStopsFromBusStop(any, any))
        .thenThrow(ServerException());
    final expectedResult = await busStopListRepositoryImpl
        .getBusStopsListFromBusStop(testBusStop, testDateTime);
    verify(
        mockRemoteDataSource.getBusStopsFromBusStop(testBusStop, testDateTime));
    expect(expectedResult, Left(ServerFailure()));
  });
}
