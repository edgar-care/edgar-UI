// ignore_for_file: unused_local_variable

import 'package:edgar/colors.dart';
import 'package:flutter/material.dart';

/// Type of the
enum Variant {
  /// Variant primary
  primary,

  /// Variant secondary
  secondary,

  /// Variant tertiary
  tertiary,

  /// Variant primary with some border
  primaryBordered,

  /// Variant validate
  validate,

  /// Variant delete
  delete,

  /// Variant delete with some border
  deleteBordered
}

/// Size of the buttion
enum SizeButton {
  /// Size sm
  sm,

  /// Size md
  md,

  /// Size lg
  lg,

  /// Size xl
  xl,

  /// Size xxl
  xxl,

  /// Size xxxl
  xxxl,
}

/// A button with different font size and color
// ignore: must_be_immutable
class Buttons extends StatelessWidget {
  /// The variant so the type of button
  Variant variant;

  /// The size of the different element inside the button
  SizeButton size;

  /// The text of the button
  Text msg;

  /// A functionon to do something on press
  Function? onPressed;

  /// The Width of the button
  int? widthBtn;

  /// Required : Variant , Size , Msg
  Buttons(
      {super.key,
      required this.variant,
      required this.size,
      required this.msg,
      this.onPressed,
      this.widthBtn});

  @override
  Widget build(BuildContext context) {
    Color backgroundcolor;
    BorderSide borderSide;
    TextStyle textStyle;
    Color? borderColor;
    double radius;

    switch (size) {
      case SizeButton.sm:
        textStyle = TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: variant == Variant.secondary
              ? const Color(0xFF2E4C9A)
              : variant == Variant.deleteBordered
                  ? AppColors.red700
                  : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 8;
        break;
      case SizeButton.md:
        textStyle = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: variant == Variant.secondary
              ? const Color(0xFF2E4C9A)
              : variant == Variant.deleteBordered
                  ? AppColors.red700
                  : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 10;
        break;
      case SizeButton.lg:
        textStyle = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: variant == Variant.secondary
              ? const Color(0xFF2E4C9A)
              : variant == Variant.deleteBordered
                  ? AppColors.red700
                  : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 12;
        break;
      case SizeButton.xl:
        textStyle = TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: variant == Variant.secondary
              ? const Color(0xFF2E4C9A)
              : variant == Variant.deleteBordered
                  ? AppColors.red700
                  : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 12;
        break;
      case SizeButton.xxl:
        textStyle = TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: variant == Variant.secondary
              ? const Color(0xFF2E4C9A)
              : variant == Variant.deleteBordered
                  ? AppColors.red700
                  : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 16;
        break;
      case SizeButton.xxxl:
        textStyle = TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: variant == Variant.secondary
              ? const Color(0xFF2E4C9A)
              : variant == Variant.deleteBordered
                  ? AppColors.red700
                  : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 16;
        break;
      default:
        textStyle = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.blue300,
          fontFamily: 'Poppins',
        );
        radius = 8;
        break;
    }

    switch (variant) {
      case Variant.primary:
        backgroundcolor = AppColors.blue700;
        borderSide = const BorderSide(
          color: AppColors.blue700,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variant.secondary:
        backgroundcolor = Colors.white;
        borderSide = const BorderSide(
          color: AppColors.blue200,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variant.tertiary:
        backgroundcolor = AppColors.grey500;
        borderSide = const BorderSide(
          color: AppColors.grey400,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variant.primaryBordered:
        backgroundcolor = AppColors.blue700;
        borderSide = const BorderSide(
          color: AppColors.blue700,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variant.validate:
        backgroundcolor = AppColors.green600;
        borderSide = const BorderSide(
          color: AppColors.green600,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variant.delete:
        backgroundcolor = AppColors.red600;
        borderSide = const BorderSide(
          color: AppColors.red600,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variant.deleteBordered:
        backgroundcolor = Colors.white;
        borderSide = const BorderSide(
          color: Color.fromRGBO(255, 159, 159, 1),
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      default:
        backgroundcolor = Colors.grey;
        borderSide = const BorderSide(
          color: Colors.transparent,
          style: BorderStyle.solid,
          width: 0,
        );
        break;
    }

    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        onPressed!();
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth,
        ),
        padding: EdgeInsets.symmetric(
            vertical: size == SizeButton.sm ||
                    size == SizeButton.lg ||
                    size == SizeButton.md
                ? 6
                : 12,
            horizontal: size == SizeButton.sm ||
                    size == SizeButton.lg ||
                    size == SizeButton.md
                ? 16
                : 24),
        decoration: BoxDecoration(
          color: backgroundcolor,
          border: Border.fromBorderSide(borderSide),
          borderRadius: BorderRadius.circular(radius),
        ),
        // ignore: prefer_null_aware_operators
        width: widthBtn != null ? widthBtn!.toDouble() : double.infinity,
        child: Center(
          child: Text(
            msg.data.toString(),
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
