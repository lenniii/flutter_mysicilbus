import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sicilbus_clean_arch/core/errors/failures.dart';
import 'package:sicilbus_clean_arch/core/usecase.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/repositories/bus_stop_list_repository.dart';

class GetAllBusStops implements UseCase<BusStopsList, NoParams> {
  final BusStopListRepository busStopListRepository;

  GetAllBusStops(this.busStopListRepository);

  @override
  Future<Either<Failure, BusStopsList>> call(NoParams parameters) {
    return busStopListRepository.getAllBusStops();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => null;
}
