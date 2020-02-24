import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/usecases/get_all_bus_stops.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/usecases/get_bus_stops_from_bus_stop.dart';
import 'package:meta/meta.dart';
part 'bus_stop_event.dart';
part 'bus_stop_state.dart';

const SERVER_FAILURE_MESSAGE = "Server error, please try again";

class BusStopBloc extends Bloc<BusStopEvent, BusStopState> {
  final GetAllBusStops getAllBusStops;
  final GetBusStopsFromBusStop getBusStopsFromBusStop;

  BusStopBloc(
      {@required this.getAllBusStops, @required this.getBusStopsFromBusStop});
  @override
  BusStopState get initialState => BusStopInitial();

  @override
  Stream<BusStopState> mapEventToState(
    BusStopEvent event,
  ) async* {
    if (event is GetBusStopList) {
      yield LoadingBusStopsList();
      final failureOrBusStops = await getAllBusStops(NoParams());
      yield* failureOrBusStops.fold((failure) async* {
        yield ErrorBusStopsList(SERVER_FAILURE_MESSAGE);
      }, (busStopsList) async* {
        yield LoadedBusStopsList(busStopsList);
      });
    } else if (event is GetBusStopListFromBusStop) {
      yield LoadingBusStopsList();
      final failureOrBusStops = await getBusStopsFromBusStop(
          Params(busStop: event.busStop, dateTime: event.dateTime));
      yield* failureOrBusStops.fold((failure) async* {
        yield ErrorBusStopsList(SERVER_FAILURE_MESSAGE);
      }, (busStopsList) async* {
        yield LoadedBusStopsList(busStopsList);
      });
    }
  }
}
