import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiceBearAvatar extends StatelessWidget {
  const DiceBearAvatar({
    super.key,
    required this.seed,
    required this.radius,
    required this.backgroundColor,
  });

  final String seed;
  final double radius;
  final Color backgroundColor;

  String _toHex(Color color) {
    return color.value
        .toRadixString(16)
        .substring(2)
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final url =
        "https://api.dicebear.com/10.x/lorelei/svg"
        "?seed=$seed"
        "&backgroundColor=${_toHex(backgroundColor)}"
        "&borderRadius=50";

    return ClipOval(
      child: SvgPicture.network(
        url,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
      ),
    );
  }
}