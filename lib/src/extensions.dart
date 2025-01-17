// ignore_for_file: prefer_collection_literals, cascade_invocations

import "package:flutter/material.dart";

extension ColorExtension on Color {
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.from(
        alpha: a,
        red: r * f,
        green: g  * f,
        blue: b * f,
    );
  }

  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);

    var p = percent / 100;

    return Color.from(
        alpha: a,
        red: r + ((255 - r) * p),
        green: g + ((255 - g) * p),
        blue: b + ((255 - b) * p),
    );
  }
}
