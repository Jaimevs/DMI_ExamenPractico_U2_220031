import 'package:flutter/material.dart';

class RatingHelper {
  static String getUsRating(bool adult, double voteAverage) {
    if (adult) {
      return 'R';
    }

    if (voteAverage >= 8.0) {
      return 'PG-13';
    } else if (voteAverage >= 6.0) {
      return 'PG';
    } else {
      return 'G';
    }
  }

  static Color getRatingColor(String rating) {
    switch (rating) {
      case 'R':
        return const Color(0xFFD32F2F);
      case 'PG-13':
        return const Color(0xFFF57C00);
      case 'PG':
        return const Color(0xFFFBC02D);
      case 'G':
        return const Color(0xFF388E3C);
      default:
        return const Color(0xFF757575);
    }
  }

  static String getRatingDescription(String rating) {
    switch (rating) {
      case 'R':
        return 'Restringido\n(menores 17+)';
      case 'PG-13':
        return 'PG-13\n(menores 13+)';
      case 'PG':
        return 'PG\n(orientación)';
      case 'G':
        return 'General\n(abierta)';
      default:
        return 'NR\n(no clasificada)';
    }
  }
}
