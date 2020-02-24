import 'package:dartz/dartz.dart';
import 'package:sicilbus_clean_arch/core/errors/errros.dart';
import 'package:sicilbus_clean_arch/core/errors/failures.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/data/datasources/bus_stops_remote_datasource.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/repositories/bus_stop_list_repository.dart';
import 'package:meta/meta.dart';

class BusStopListRepositoryImpl implements BusStopListRepository {
  final BusStopsRemoteDatasource busStopsRemoteDatasource;

  BusStopListRepositoryImpl({@required this.busStopsRemoteDatasource});
  @override
  Future<Either<Failure, BusStopsList>> getAllBusStops() async {
    try {
      final busStopsListData = await busStopsRemoteDatasource.getAllBusStops();
      return Right(busStopsListData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BusStopsList>> getBusStopsListFromBusStop(
      BusStop busStop, DateTime dateTime) async {
    try {
      final busStopsListData = await busStopsRemoteDatasource
          .getBusStopsFromBusStop(busStop, dateTime);
      return Right(busStopsListData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
