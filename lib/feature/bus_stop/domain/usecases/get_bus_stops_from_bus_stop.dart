import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sicilbus_clean_arch/core/errors/failures.dart';
import 'package:sicilbus_clean_arch/core/usecase.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/repositories/bus_stop_list_repository.dart';
import 'package:meta/meta.dart';

class GetBusStopsFromBusStop implements UseCase<BusStopsList, Params> {
  final BusStopListRepository busStopListRepository;

  GetBusStopsFromBusStop(this.busStopListRepository);

  @override
  Future<Either<Failure, BusStopsList>> call(Params params) {
    return busStopListRepository.getBusStopsListFromBusStop(
        params.busStop, params.dateTime);
  }
}

class Params extends Equatable {
  final BusStop busStop;
  final DateTime dateTime;

  Params({@required this.busStop, @required this.dateTime});
  @override
  List<Object> get props => [busStop, dateTime];
}
