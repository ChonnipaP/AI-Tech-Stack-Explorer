import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../main.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = themeNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text(
                'Dark Mode',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              subtitle: const Text(
                'Bloomberg Dark Theme',
                style: TextStyle(color: AppColors.textSecond),
              ),
              value: _isDark,
              activeColor: AppColors.primary,
              onChanged: (val) {
                setState(() => _isDark = val);
                themeNotifier.value = val;
                sl<SharedPreferences>().setBool('dark_mode', val);
              },
            ),
          ],
        ),
      ),
    );
  }
}