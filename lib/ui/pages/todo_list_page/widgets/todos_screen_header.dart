import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_bloc/common/app_colors.dart';
import 'package:todo_app_bloc/ui/widgets/common/svg_image.dart';

class TodosScreenHeader extends StatelessWidget {
  const TodosScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    String date = DateFormat("MMMM dd, yyyy").format(dateTime);
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: [
              Container(
                width: 390,
                height: 252,
                decoration: BoxDecoration(color: AppColors.primary),
              ),
              Positioned(
                top: 78,
                left: -191,
                child: SVGImage(imageUri: "assets/images/ic_ellipse_1.svg"),
              ),
              Positioned(
                top: -27,
                right: -82,
                child: SVGImage(imageUri: "assets/images/ic_ellipse_2.svg"),
              ),
              Positioned(
                top: 34,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 110,
                  ),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
              ),
              Text(
                "My Todo List",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textWhite,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
