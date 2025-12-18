import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:money_scope/src/core/constants/app_routes.dart';
import 'package:money_scope/src/presentation/providers/theme/app_theme_provider.dart';
import 'package:money_scope/src/presentation/providers/theme/theme_state.dart';
import 'package:money_scope/src/presentation/views/dashboard/settings/widgets/settings_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text("Settings"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "GENERAL",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),

            SettingsItem(
              icon: Icons.person,
              label: "Account",
              onTap: () => context.pushNamed(AppRoutes.profile),
              action: const Icon(Icons.arrow_forward_ios_rounded),
              iconColor: Colors.grey,
            ),

            SettingsItem(
              icon: Icons.wallet_rounded,
              label: "Currency",
              onTap: () {},
              action: const Icon(Icons.arrow_forward_ios_rounded),
              iconColor: Colors.lightGreen,
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "PREFERENCES",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),

            Consumer(
              builder: (context, ref, child) {
                final themeState = ref.watch(appThemeProvider);

                final isLight = themeState is LightTheme;

                return SettingsItem(
                  icon: isLight ? Icons.light_mode : Icons.dark_mode,
                  label: "Theme",
                  iconColor: isLight ? Colors.amber : Colors.grey,
                  action: SizedBox(
                    height: 24,
                    child: Switch.adaptive(
                      activeTrackColor: colors.secondary,
                      thumbColor: WidgetStatePropertyAll(Colors.white),
                      value: isLight,
                      onChanged: (bool value) {
                        ref.read(appThemeProvider.notifier).toggleTheme();
                      },
                    ),
                  ),
                );
              },
            ),

            SettingsItem(
              icon: Icons.wallet_rounded,
              label: "Notifications",
              onTap: () {},
              action: const Icon(Icons.arrow_forward_ios_rounded),
              iconColor: Colors.blueGrey,
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "DATA & SECURITY",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),

            SettingsItem(
              icon: Icons.list_alt,
              label: "Manage Categories",
              onTap: () {},
              action: const Icon(Icons.arrow_forward_ios_rounded),
              iconColor: Colors.blue,
            ),

            SettingsItem(
              icon: Icons.folder_zip_rounded,
              label: "Data Export (CSV)",
              onTap: () {},
              action: const Icon(Icons.arrow_forward_ios_rounded),
              iconColor: Colors.green,
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "PRIVACY POLICY",
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),

            SettingsItem(
              icon: Icons.privacy_tip_rounded,
              label: "Privacy Policy",
              onTap: () {},
              action: const Icon(Icons.arrow_forward_ios_rounded),
              iconColor: Colors.blue,
            ),

            SettingsItem(
              icon: Icons.description_rounded,
              label: "Terms & Conditions",
              onTap: () {},
              action: const Icon(Icons.arrow_forward_ios_rounded),
            ),

            const SizedBox(height: 12),

            SettingsItem(
              icon: Icons.cloud_download_rounded,
              label: "Cloud Backup",
              iconColor: Colors.amber,
              action: SizedBox(
                height: 24,
                child: Switch.adaptive(
                  activeTrackColor: colors.secondary,
                  thumbColor: WidgetStatePropertyAll(Colors.white),
                  value: true,
                  onChanged: (bool value) {},
                ),
              ),
            ),

            SettingsItem(
              icon: Icons.lock_open_rounded,
              label: "Change Passcode",
              onTap: () {},
              action: const Icon(Icons.arrow_forward_ios_rounded),
            ),

            SettingsItem(
              icon: Icons.delete_forever,
              label: "Delete All Data",
              onTap: () {},
              action: const Icon(Icons.arrow_forward_ios_rounded),
              iconColor:  Colors.red,
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
