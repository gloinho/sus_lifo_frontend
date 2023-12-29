import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const azul = Color(0xFF5277DB);

CustomColors lightCustomColors = const CustomColors(
  sourceAzul: Color(0xFF5277DB),
  azul: Color(0xFF3058BB),
  onAzul: Color(0xFFFFFFFF),
  azulContainer: Color(0xFFDBE1FF),
  onAzulContainer: Color(0xFF00174A),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceAzul,
    required this.azul,
    required this.onAzul,
    required this.azulContainer,
    required this.onAzulContainer,
  });

  final Color? sourceAzul;
  final Color? azul;
  final Color? onAzul;
  final Color? azulContainer;
  final Color? onAzulContainer;

  @override
  CustomColors copyWith({
    Color? sourceAzul,
    Color? azul,
    Color? onAzul,
    Color? azulContainer,
    Color? onAzulContainer,
  }) {
    return CustomColors(
      sourceAzul: sourceAzul ?? this.sourceAzul,
      azul: azul ?? this.azul,
      onAzul: onAzul ?? this.onAzul,
      azulContainer: azulContainer ?? this.azulContainer,
      onAzulContainer: onAzulContainer ?? this.onAzulContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceAzul: Color.lerp(sourceAzul, other.sourceAzul, t),
      azul: Color.lerp(azul, other.azul, t),
      onAzul: Color.lerp(onAzul, other.onAzul, t),
      azulContainer: Color.lerp(azulContainer, other.azulContainer, t),
      onAzulContainer: Color.lerp(onAzulContainer, other.onAzulContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceAzul]
  ///   * [CustomColors.azul]
  ///   * [CustomColors.onAzul]
  ///   * [CustomColors.azulContainer]
  ///   * [CustomColors.onAzulContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceAzul: sourceAzul!.harmonizeWith(dynamic.primary),
      azul: azul!.harmonizeWith(dynamic.primary),
      onAzul: onAzul!.harmonizeWith(dynamic.primary),
      azulContainer: azulContainer!.harmonizeWith(dynamic.primary),
      onAzulContainer: onAzulContainer!.harmonizeWith(dynamic.primary),
    );
  }
}
