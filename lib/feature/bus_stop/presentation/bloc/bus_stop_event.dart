part of 'bus_stop_bloc.dart';

abstract class BusStopEvent extends Equatable {
  const BusStopEvent();
}

class GetBusStopList extends BusStopEvent {
  @override
  List<Object> get props => null;
}

class GetBusStopListFromBusStop extends BusStopEvent {
  final BusStop busStop;
  final DateTime dateTime;

  GetBusStopListFromBusStop({@required this.busStop, @required this.dateTime});

  @override
  List<Object> get props => [busStop, dateTime];
}
