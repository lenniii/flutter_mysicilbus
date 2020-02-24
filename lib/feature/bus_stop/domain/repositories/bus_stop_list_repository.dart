import 'package:dartz/dartz.dart';
import 'package:sicilbus_clean_arch/core/errors/failures.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';

abstract class BusStopListRepository {
  Future<Either<Failure, BusStopsList>> getAllBusStops();
  Future<Either<Failure, BusStopsList>> getBusStopsListFromBusStop(
      BusStop busStop, DateTime dateTime);
}
