import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:sicilbus_clean_arch/core/errors/failures.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/usecases/get_all_bus_stops.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/usecases/get_bus_stops_from_bus_stop.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/presentation/bloc/bus_stop_bloc.dart';

class MockGetAllBusStop extends Mock implements GetAllBusStops {}

class MockGetBusStopsFromBusStop extends Mock
    implements GetBusStopsFromBusStop {}

void main() {
  BusStopBloc bloc;
  MockGetAllBusStop mockGetAllBusStop;
  MockGetBusStopsFromBusStop mockGetBusStopsFromBusStop;

  setUp(() {
    mockGetAllBusStop = MockGetAllBusStop();
    mockGetBusStopsFromBusStop = MockGetBusStopsFromBusStop();
    bloc = BusStopBloc(
        getAllBusStops: mockGetAllBusStop,
        getBusStopsFromBusStop: mockGetBusStopsFromBusStop);
  });

  test("Should return empty initial state", () {
    expect(bloc.initialState, BusStopInitial());
  });

  test("Should call repository from usecase", () async {
    final testBusStop = BusStop(id: 1, label: "TEST");
    final testBusStopList =
        BusStopsList(busStopList: [testBusStop], description: "TEST");
    when(mockGetBusStopsFromBusStop(any))
        .thenAnswer((_) async => Right(testBusStopList));
    bloc.add(GetBusStopList());
    await untilCalled(mockGetAllBusStop(any));
    verify(mockGetAllBusStop(NoParams()));
  });
  test("Should emit [InitialState, LoadingBusstops, LoadedBusStops]", () async {
    final testBusStop = BusStop(id: 1, label: "TEST");
    final testBusStopList =
        BusStopsList(busStopList: [testBusStop], description: "TEST");
    when(mockGetAllBusStop(any))
        .thenAnswer((_) async => Right(testBusStopList));
    final expected = [
      bloc.initialState,
      LoadingBusStopsList(),
      LoadedBusStopsList(testBusStopList)
    ];
    expectLater(bloc, emitsInOrder(expected));
    bloc.add(GetBusStopList());
  });
  test("Should emit [InitialState, LoadingBusstops, ErrorBusstops]", () async {
    when(mockGetAllBusStop(any)).thenAnswer((_) async => Left(ServerFailure()));
    final expected = [
      bloc.initialState,
      LoadingBusStopsList(),
      ErrorBusStopsList(SERVER_FAILURE_MESSAGE)
    ];
    expectLater(bloc, emitsInOrder(expected));
    bloc.add(GetBusStopList());
  });

  test("Should call repository from usecase", () async {
    final testBusStop = BusStop(id: 1, label: "TEST");

    final testBusStopList =
        BusStopsList(busStopList: [testBusStop], description: "TEST");
    final testDateTime = DateTime.now();
    when(mockGetBusStopsFromBusStop(any))
        .thenAnswer((_) async => Right(testBusStopList));
    bloc.add(GetBusStopListFromBusStop(
        busStop: testBusStop, dateTime: testDateTime));
    await untilCalled(mockGetBusStopsFromBusStop(any));
    verify(mockGetBusStopsFromBusStop(
        Params(busStop: testBusStop, dateTime: testDateTime)));
  });
  test("Should emit [InitialState, LoadingBusstops, LoadedBusStops]", () async {
    final testBusStop = BusStop(id: 1, label: "TEST");
    final testBusStopList =
        BusStopsList(busStopList: [testBusStop], description: "TEST");
    final testDateTime = DateTime.now();

    when(mockGetBusStopsFromBusStop(any))
        .thenAnswer((_) async => Right(testBusStopList));
    final expected = [
      bloc.initialState,
      LoadingBusStopsList(),
      LoadedBusStopsList(testBusStopList)
    ];
    expectLater(bloc, emitsInOrder(expected));
    bloc.add(GetBusStopListFromBusStop(
        busStop: testBusStop, dateTime: testDateTime));
  });
  test("Should emit [InitialState, LoadingBusstops, ErrorBusstops]", () async {
    final testBusStop = BusStop(id: 1, label: "TEST");
    final testDateTime = DateTime.now();
    when(mockGetBusStopsFromBusStop(any))
        .thenAnswer((_) async => Left(ServerFailure()));
    final expected = [
      bloc.initialState,
      LoadingBusStopsList(),
      ErrorBusStopsList(SERVER_FAILURE_MESSAGE)
    ];
    expectLater(bloc, emitsInOrder(expected));
    bloc.add(GetBusStopListFromBusStop(
        busStop: testBusStop, dateTime: testDateTime));
  });
}
