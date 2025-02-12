// ignore_for_file: prefer_collection_literals, cascade_invocations

import "package:flutter/material.dart";

extension ColorExtension on Color {
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(
        a.toInt(),
        (r.toInt() * f).round(),
        (g.toInt()  * f).round(),
        (b.toInt() * f).round(),
    );
  }

  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        a.toInt(),
        r.toInt() + ((255 - r.toInt()) * p).round(),
        g.toInt() + ((255 - g.toInt()) * p).round(),
        b.toInt() + ((255 - b.toInt()) * p).round(),
    );
  }
}
