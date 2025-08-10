import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGImage extends StatelessWidget {
  final String imageUri;

  const SVGImage({super.key, required this.imageUri});

  @override
  Widget build(BuildContext context) {
    return Center(child: SvgPicture.asset(imageUri));
  }
}
