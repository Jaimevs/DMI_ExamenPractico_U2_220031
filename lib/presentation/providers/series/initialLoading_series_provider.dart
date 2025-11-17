import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'series_providers.dart';

final initialLoadingSeriesProvider = Provider<bool>((ref) {
  final step1 = ref.watch(airingTodaySeriesProvider).isEmpty;
  final step2 = ref.watch(upcomingSeriesProvider).isEmpty;
  final step3 = ref.watch(popularSeriesProvider).isEmpty;
  final step4 = ref.watch(topRatedSeriesProvider).isEmpty;
  final step5 = ref.watch(mexicanSeriesProvider).isEmpty;

  if (step1 || step2 || step3 || step4 || step5) return true;
  return false;
});