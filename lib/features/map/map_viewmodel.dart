import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

import '../../model/marker_model.dart';

class MapViewModel with ChangeNotifier {
  bool isLoading = false;
  int selectedMarkerIndex = -1;

  var center = LatLng(53.57, -2.999);
  var markers = [
    MarkerModel(
      0,
      'https://images.pexels.com/photos/231009/pexels-photo-231009.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=300&w=600',
      LatLng(53.57, -2.999),
    ),
    MarkerModel(
      1,
      'https://images.pexels.com/photos/14446254/pexels-photo-14446254.jpeg',
      LatLng(53.37, -2.999),
    ),
  ];

  refreshMarkers() async {
    changeLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    final list = [...markers];
    list.add(MarkerModel(
      2,
      'https://images.pexels.com/photos/14446254/pexels-photo-14446254.jpeg',
      LatLng(53.07, -2.999),
    ));
    markers = list;
    changeLoading(false);
  }

  onTapMarker(int id) {
    final list = [...markers];
    var marker = list.firstWhere((element) => element.id == id);
    list.removeWhere((element) => element.id == id);
    list.add(marker);

    selectedMarkerIndex = selectedMarkerIndex == id ? -1 : id;
    markers = list;
    notifyListeners();
  }

  changeLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
