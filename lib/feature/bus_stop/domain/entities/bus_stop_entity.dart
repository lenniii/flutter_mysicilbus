import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class BusStop extends Equatable {
  final int id;
  final String label;

  BusStop({@required this.id, @required this.label});

  @override
  List<Object> get props => [id, label];
}
