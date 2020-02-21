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
    return busStopListRepository.getBusStopsListFromBusStop(params.busStop);
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => null;
}

class Params extends Equatable {
  final BusStop busStop;

  Params({@required this.busStop});
  @override
  List<Object> get props => [busStop];
}
