import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';

class BusStopsList extends Equatable {
  final List<BusStop> busStopList;
  final String description;

  BusStopsList({@required this.busStopList, @required this.description});

  @override
  List<Object> get props => [busStopList];
}
