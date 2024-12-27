import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A Riverpod StateProvider for managing the current locale.
final localeProvider = StateProvider<Locale>((ref) {
  // Default locale set to English (United States)
  return const Locale('en', 'US');
});
