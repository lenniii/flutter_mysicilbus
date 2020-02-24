import 'package:sicilbus_clean_arch/feature/bus_stop/data/models/bus_stop_model.dart';
import 'package:sicilbus_clean_arch/feature/bus_stop/domain/entities/bus_stop_list_entity.dart';
import 'package:meta/meta.dart';

class BusStopsListModel extends BusStopsList {
  final List<BusStopModel> busStopList;
  final String description;

  BusStopsListModel({@required this.busStopList, @required this.description});

  factory BusStopsListModel.fromJson(Map<String, dynamic> decodedJson) {
    return BusStopsListModel(
        busStopList: (decodedJson["stops"] as List)
            .map((stop) => BusStopModel.fromJson(stop))
            .toList(),
        description: decodedJson["description"]);
  }

  Map<String, dynamic> toJson() {
    return {"description": "TEST", "stops": busStopList};
  }
}
