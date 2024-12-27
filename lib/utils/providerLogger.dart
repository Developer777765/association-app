import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'color_print.dart';

class ProviderLogger extends ProviderObserver {
  const ProviderLogger();

  @override
  void didAddProvider(ProviderBase<dynamic> provider, Object? value, ProviderContainer container) {
    TColorPrint.green("➕ DidAddProvider: ${provider.name ?? provider.runtimeType},");
    TColorPrint.green("=> value: $value");
  }

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    TColorPrint.red("🗑️ DidDisposeProvider  : ${provider.name ?? provider.runtimeType}");
    super.didDisposeProvider(provider, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    TColorPrint.green("🔄️ DidUpdateProvider: ${provider.name ?? provider.runtimeType},");
    TColorPrint.yellow("=> oldValue: $previousValue,");
    TColorPrint.yellow("=> newValue: $newValue");
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    TColorPrint.red("❌ ProviderDidFail: ${provider.name ?? provider.runtimeType},");
    TColorPrint.red("=> error: $error");
    TColorPrint.red("=> stackTrace: $stackTrace");
  }
}
