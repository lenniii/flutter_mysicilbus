import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_entity.dart';
import 'package:meta/meta.dart';

class BusStopModel extends BusStop {
  final int id;
  final String label;

  BusStopModel({@required this.id, @required this.label});

  factory BusStopModel.fromJson(Map<String, dynamic> decodedJson) {
    return BusStopModel(
      id: int.parse(decodedJson['id']),
      label: decodedJson["label"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "label": label};
  }
}
