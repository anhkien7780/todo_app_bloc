import 'package:flutter/cupertino.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  ///Black
  static const black = TextStyle(
    color: AppColors.textBlack,
    fontWeight: FontWeight.w400,
  );

  ///s14
  static final blackS14 = black.copyWith(fontSize: 14);
  static final blackS14Medium = black.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static final blackS14SemiBold = black.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static final blackS14Bold = black.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  ///s16
  static final blackS16 = black.copyWith(fontSize: 16);
  static final blackS16Medium = black.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final blackS16SemiBold = black.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static final blackS16Bold = black.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  /// White
  static const white = TextStyle(
    color: AppColors.textWhite,
    fontWeight: FontWeight.w400,
  );

  /// s14
  static final whiteS14 = white.copyWith(fontSize: 14);
  static final whiteS14Medium = white.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static final whiteS14SemiBold = white.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static final whiteS14Bold = white.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  /// s16
  static final whiteS16 = white.copyWith(fontSize: 16);
  static final whiteS16Medium = white.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final whiteS16SemiBold = white.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static final whiteS16Bold = white.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  /// s30
  static final whiteS30 = white.copyWith(fontSize: 30);
  static final whiteS30Medium = white.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );
  static final whiteS30SemiBold = white.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
  static final whiteS30Bold = white.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );
}
