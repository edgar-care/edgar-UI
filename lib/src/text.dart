import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors.dart';

/// Size and font weight of the widget text
enum TxtStyles {
  ///Sm size
  sm,

  /// BoldSm
  boldSm,

  ///Md
  md,

  /// BoldMD
  boldMd,

  ///lg size
  lg,

  /// Boldlg
  boldLg,

  ///Xl size
  xl,

  /// BoldSm
  boldXl,

  ///2Xl
  xxl,

  ///Bold2Xl
  bold2Xl,

  ///3XL
  xxxl,

  ///4XL
  xxxxl,

  ///5Xl
  xxxxxl,

  ///6Xl
  xxxxxxl,

  ///7XL
  xxxxxxxl,

  ///8XL
  xxxxxxxxl,
}

/// Custom text
class CustomText extends StatelessWidget {
  /// String de text
  final String txt;

  /// Color of the text
  final Color? txtColor;

  /// Size and font weight of the txt
  final TxtStyles txtStyles;

  /// Requires Txt
  const CustomText(
      {super.key, required this.txt, this.txtColor, required this.txtStyles});

  @override
  Widget build(BuildContext context) {
    FontWeight fontweight;
    double fontSize;

    switch (txtStyles) {
      case TxtStyles.boldSm:
        fontweight = FontWeight.w700;
        fontSize = 12;
        break;
      case TxtStyles.boldMd:
        fontweight = FontWeight.w700;
        fontSize = 14;
        break;
      case TxtStyles.boldLg:
        fontweight = FontWeight.w700;
        fontSize = 16;
        break;
      case TxtStyles.boldXl:
        fontweight = FontWeight.w700;
        fontSize = 20;
        break;
      case TxtStyles.bold2Xl:
        fontweight = FontWeight.w700;
        fontSize = 24;
        break;
      case TxtStyles.md:
        fontweight = FontWeight.w600;
        fontSize = 14;
        break;
      case TxtStyles.lg:
        fontweight = FontWeight.w600;
        fontSize = 16;
        break;
      case TxtStyles.xl:
        fontweight = FontWeight.w600;
        fontSize = 20;
        break;
      case TxtStyles.xxl:
        fontweight = FontWeight.w600;
        fontSize = 24;
        break;
      case TxtStyles.xxxl:
        fontweight = FontWeight.w700;
        fontSize = 32;
        break;
      case TxtStyles.xxxxl:
        fontweight = FontWeight.w700;
        fontSize = 36;
        break;
      case TxtStyles.xxxxxl:
        fontweight = FontWeight.w700;
        fontSize = 42;
        break;
      case TxtStyles.xxxxxxl:
        fontweight = FontWeight.w700;
        fontSize = 48;
        break;
      case TxtStyles.xxxxxxxl:
        fontweight = FontWeight.w700;
        fontSize = 64;
        break;
      case TxtStyles.xxxxxxxxl:
        fontweight = FontWeight.w700;
        fontSize = 72;
        break;
      default:
        fontweight = FontWeight.w600;
        fontSize = 12;
        break;
    }

    return Text(
      txt,
      style: GoogleFonts.poppins(
        color: txtColor ?? AppColors.black,
        fontWeight: fontweight,
        fontSize: fontSize,
      ),
    );
  }
}
