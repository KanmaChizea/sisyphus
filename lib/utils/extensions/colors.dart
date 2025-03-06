import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// Converts the Color to a hex string, e.g., #RRGGBB or #AARRGGBB
  String toHex({bool includeAlpha = false}) {
    final r = this.r.toInt().toRadixString(16).padLeft(2, '0');
    final g = this.g.toInt().toRadixString(16).padLeft(2, '0');
    final b = this.b.toInt().toRadixString(16).padLeft(2, '0');
    final a = this.a.toInt().toRadixString(16).padLeft(2, '0');

    return includeAlpha ? '#$a$r$g$b'.toUpperCase() : '#$r$g$b'.toUpperCase();
  }
}
