// ignore_for_file: deprecated_member_use_from_same_package

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'isfirstrun_provider.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

@riverpod
class FirstRunState extends _$FirstRunState {
  @override
  FutureOr<bool> build() {
    return ref.watch(sharedPreferencesProvider).getBool('isFirstRun') ?? true;
  }

  Future<void> setFalse() async {
    await ref.read(sharedPreferencesProvider).setBool('isFirstRun', false);
  }
}
