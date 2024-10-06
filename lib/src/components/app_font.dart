import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontStyle {
  NotoSansKR('Noto Sans KR'),
  NotoSerifKannada('Noto Serif Kannada'),
  Lato('Lato');

  const FontStyle(this.value);
  final String value;
}

class AppFont extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? decorationColor;
  final TextAlign? textAlign;
  final double? lineHeight;
  final double? letterSpacing;
  final int? maxLine;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final FontStyle font;

  const AppFont(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.color = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.size = 15,
    this.maxLine,
    this.decorationColor,
    this.lineHeight,
    this.overflow,
    this.letterSpacing,
    this.decoration,
    this.font = FontStyle.NotoSansKR,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: overflow,
      textScaler: TextScaler.noScaling,
      style: GoogleFonts.getFont(
        font.value,
        fontSize: size,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
        color: color,
        height: lineHeight,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
    );
  }
}
