// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppTheme)
const appThemeProvider = AppThemeProvider._();

final class AppThemeProvider extends $NotifierProvider<AppTheme, ThemeState> {
  const AppThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeHash();

  @$internal
  @override
  AppTheme create() => AppTheme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeState>(value),
    );
  }
}

String _$appThemeHash() => r'80eecc0f6937343baeb01d9667460dbe2c60aad8';

abstract class _$AppTheme extends $Notifier<ThemeState> {
  ThemeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemeState, ThemeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeState, ThemeState>,
              ThemeState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
