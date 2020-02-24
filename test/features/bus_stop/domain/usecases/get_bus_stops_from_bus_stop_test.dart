import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/repositories/bus_stop_list_repository.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/usecases/get_bus_stops_from_bus_stop.dart';

class MockBusStopListRepository extends Mock implements BusStopListRepository {}

void main() {
  // Here we declare dependencies we need to test
  MockBusStopListRepository busStopListRepository;
  GetBusStopsFromBusStop busStopsFromBusStop;

  setUp(() {
    // Here we setup all the instances for dependencies
    busStopListRepository = MockBusStopListRepository();
    busStopsFromBusStop = GetBusStopsFromBusStop(busStopListRepository);
  });

  final testBusStopsList = BusStopsList(
      busStopList: [BusStop(id: 1, label: "TEST")], description: "TEST");
  final testBusStop = BusStop(id: 1, label: "TEST");
  final testDateTime = DateTime.now();
  test('Should receive [BusStopsList] with given BusStop from Repository',
      () async {
    when(busStopListRepository.getBusStopsListFromBusStop(any, any))
        .thenAnswer((_) async => Right(testBusStopsList));
    final expectedResult = await busStopsFromBusStop(
        Params(busStop: testBusStop, dateTime: testDateTime));
    expect(expectedResult, Right(testBusStopsList));
    verify(busStopListRepository.getBusStopsListFromBusStop(
        testBusStop, testDateTime));
    verifyNoMoreInteractions(busStopListRepository);
  });
}
