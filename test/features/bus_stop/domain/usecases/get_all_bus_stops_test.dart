import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/repositories/bus_stop_list_repository.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/usecases/get_all_bus_stops.dart';

class MockBusStopListRepository extends Mock implements BusStopListRepository {}

void main() {
  // Here we declare dependencies we need to test
  MockBusStopListRepository busStopListRepository;
  GetAllBusStops getAllBusStops;

  setUp(() {
    // Here we setup all the instances for dependencies
    busStopListRepository = MockBusStopListRepository();
    getAllBusStops = GetAllBusStops(busStopListRepository);
  });

  final testBusStopsList = BusStopsList(
      busStopList: [BusStop(id: 1, label: "TEST")], description: "TEST");
  test('Should receive [BusStopsList] from Repository', () async {
    when(busStopListRepository.getAllBusStops())
        .thenAnswer((_) async => Right(testBusStopsList));
    final expectedResult = await getAllBusStops(NoParams());
    expect(expectedResult, Right(testBusStopsList));
    verify(busStopListRepository.getAllBusStops());
    verifyNoMoreInteractions(busStopListRepository);
  });
}
