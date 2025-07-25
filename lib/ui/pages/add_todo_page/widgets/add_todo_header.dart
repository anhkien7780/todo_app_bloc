import 'package:flutter/material.dart';
import 'package:todo_app_bloc/ui/widgets/common/svg_image.dart';

class AddNewTaskScreenHeader extends StatelessWidget {
  final VoidCallback onCloseButtonPressed;

  const AddNewTaskScreenHeader({super.key, required this.onCloseButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        Container(width: double.infinity, height: 96, color: Color(0xff4A3780)),
        Positioned(
          top: -48,
          left: -191,
          child: SVGImage(imageUri: "lib/assets/icons/ic_ellipse_1.svg"),
        ),
        Positioned(
          top: -27,
          right: -82,
          child: SVGImage(imageUri: "lib/assets/icons/ic_ellipse_2.svg"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onCloseButtonPressed,
              icon: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SVGImage(imageUri: "lib/assets/icons/ic_close_x.svg"),
              ),
            ),
            Text(
              "Add New Task",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 48),
          ],
        ),
      ],
    );
  }
}
