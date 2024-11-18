import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

@immutable
class Typo {
  const Typo._();

  // Header
  static const TextStyle t40sb = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 1.6,
    leadingDistribution: TextLeadingDistribution.even,
    fontFamily: 'SUIT',
  );

  static const TextStyle st32sb = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 1.6,
    leadingDistribution: TextLeadingDistribution.even,
    fontFamily: 'SUIT',
  );

  static const TextStyle st32r = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.6,
    leadingDistribution: TextLeadingDistribution.even,
    fontFamily: 'SUIT',
  );

  static const TextStyle h24Sb = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.6,
    leadingDistribution: TextLeadingDistribution.even,
    fontFamily: 'SUIT',
  );

  static const TextStyle h24r = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.6,
    leadingDistribution: TextLeadingDistribution.even,
    fontFamily: 'SUIT',
  );

  static const TextStyle b16r = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    leadingDistribution: TextLeadingDistribution.even,
    fontFamily: 'SUIT',
  );

  static const TextStyle c12r = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.6,
    leadingDistribution: TextLeadingDistribution.even,
    fontFamily: 'SUIT',
  );
}
