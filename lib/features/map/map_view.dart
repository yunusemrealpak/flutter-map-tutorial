import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tutorial/core/base/base_loader.dart';
import 'package:flutter_map_tutorial/extensions/string_extensions.dart';
import 'package:flutter_map_tutorial/features/map/map_viewmodel.dart';
import 'package:flutter_map_tutorial/features/map/widgets/custom_marker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../app_constants.dart';
import '../../model/marker_model.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with TickerProviderStateMixin {
  int index = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final overlayImages = <BaseOverlayImage>[
      OverlayImage(
          bounds: LatLngBounds(LatLng(51.5, -0.09), LatLng(48.8566, 2.3522)),
          opacity: 0.8,
          imageProvider: const NetworkImage(
              'https://images.pexels.com/photos/231009/pexels-photo-231009.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=300&w=600')),
    ];

    return ChangeNotifierProvider(
      create: (context) => MapViewModel(),
      builder: (context, child) => Consumer<MapViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(title: const Text('Animated MapController')),
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.refreshMarkers(),
            child: const Icon(Icons.refresh),
          ),
          body: BaseLoader(
            isLoading: model.isLoading,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text('This is a map that is showing (51.5, -0.9).'),
                  ),
                  Flexible(
                    child: FlutterMap(
                      options: MapOptions(
                        center: LatLng(51.5, -0.09),
                        zoom: 5,
                        maxZoom: 10,
                        minZoom: 3,
                        interactiveFlags:
                            InteractiveFlag.all - InteractiveFlag.rotate,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: AppConstants.mapBoxStyleId,
                          additionalOptions: const {
                            "access_token": AppConstants.mapBoxAccessToken,
                          },
                          userAgentPackageName:
                              'com.example.flutter_map_tutorial',
                        ),
                        //OverlayImageLayer(overlayImages: overlayImages),
                        MarkerLayer(
                            markers: model.markers
                                .map((e) => Marker(
                                      point: e.latLng!,
                                      builder: (context) => GestureDetector(
                                        onTap: () {
                                          model.onTapMarker(e.id!);
                                        },
                                        child: CustomMarker(markerModel: e, selectedIndex: model.selectedMarkerIndex),
                                      ),
                                    ))
                                .toList()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final String label;
  final Color color;

  const _Circle({Key? key, required this.label, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          label,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
