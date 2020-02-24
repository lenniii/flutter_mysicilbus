part of 'bus_stop_bloc.dart';

abstract class BusStopState extends Equatable {
  const BusStopState();
}

class BusStopInitial extends BusStopState {
  @override
  List<Object> get props => [];
}

class LoadingBusStopsList extends BusStopState {
  @override
  List<Object> get props => null;
}

class LoadedBusStopsList extends BusStopState {
  final BusStopsList busStopsList;

  LoadedBusStopsList(this.busStopsList);
  @override
  List<Object> get props => [busStopsList];
}

class ErrorBusStopsList extends BusStopState {
  final String errorMessage;

  ErrorBusStopsList(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
