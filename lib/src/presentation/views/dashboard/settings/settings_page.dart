import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              icon: Icons.wallet_rounded,
              label: "Currency",
              onTap: () {},
              action: Icon(Icons.arrow_forward_ios_rounded),
            ),

            Consumer(
              builder: (context, ref, child) {
                final isLight = ref.watch(appThemeProvider) is LightTheme;
                return SettingsItem(icon:isLight ? Icons.light_mode: Icons.dark_mode,
                  label: "Theme",
                  onTap: () {}, action: SizedBox(
                    height: 24,
                    child: Switch.adaptive(
                      activeTrackColor: colors.secondary,
                      thumbColor: WidgetStatePropertyAll(Colors.white),
                      value: isLight,
                      onChanged: (bool value) {
                        ref.read(appThemeProvider.notifier).toggleTheme();
                      },
                    ),
                  ),);
              },
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

            SettingsItem(
              icon: Icons.wallet_rounded,
              label: "Notifications",
              onTap: () {},
              action: Icon(Icons.arrow_forward_ios_rounded),
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
              icon: Icons.category_rounded,
              label: "Manage Categories",
              onTap: () {},
              action: Icon(Icons.arrow_forward_ios_rounded),
            ),

            SettingsItem(
              icon: Icons.folder_zip_rounded,
              label: "Data Export (CSV)",
              onTap: () {},
              action: Icon(Icons.arrow_forward_ios_rounded),
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
              action: Icon(Icons.arrow_forward_ios_rounded),
            ),

            SettingsItem(
              icon: Icons.folder_zip_rounded,
              label: "Terms & Conditions",
              onTap: () {},
              action: Icon(Icons.arrow_forward_ios_rounded),
            ),

            const SizedBox(height: 12),

            SettingsItem(
              icon: Icons.folder_zip_rounded,
              label: "Cloud Backup",
              onTap: () {},
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
              icon: Icons.folder_zip_rounded,
              label: "Change Passcode",
              onTap: () {},
              action: Icon(Icons.arrow_forward_ios_rounded),
            ),

            SettingsItem(
              icon: Icons.delete_forever,
              label: "Delete All Data",
              onTap: () {},
              action: Icon(Icons.arrow_forward_ios_rounded),
              iconColor: Colors.red,
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
