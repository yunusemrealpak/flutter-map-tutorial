import 'package:flutter/material.dart';
import 'package:flutter_map_tutorial/model/marker_model.dart';

class CustomMarker extends StatefulWidget {
  final int selectedIndex;
  final MarkerModel markerModel;
  const CustomMarker(
      {super.key, required this.markerModel, required this.selectedIndex});

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.selectedIndex == widget.markerModel.id;
    return AnimatedScale(
      duration: const Duration(milliseconds: 500),
      scale: 1.0,
      child: _buildContent(isSelected),
    );
  }

  Stack _buildContent(bool isSelected) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? Colors.black : Colors.white,
            boxShadow: [
              BoxShadow(
                color: isSelected ? Colors.black12 : Colors.black,
                spreadRadius: 1,
                blurRadius: 5.5,
                offset: const Offset(0, 1),
              )
            ],
          ),
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              width: isSelected ? 100 : 80,
              height: isSelected ? 100 : 80,
              child: Image.network(
                widget.markerModel.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
