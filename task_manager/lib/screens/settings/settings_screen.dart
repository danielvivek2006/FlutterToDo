import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../../theme/app_colors.dart';
import '../../theme/theme_manager.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoading = false;

  Future<void> _logout() async {
    setState(() => _isLoading = true);
    final response = await ParseUser.currentUser().then((user) => user?.logout());
    setState(() => _isLoading = false);

    if (response?.success ?? false) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      _showError(response?.error?.message ?? 'Logout failed');
    }
  }

  void _showError(String message) {
    final isIOS = !kIsWeb && Platform.isIOS;
    if (isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isIOS = !kIsWeb && Platform.isIOS;
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          'Settings',
          style: isIOS
              ? Theme.of(context).textTheme.displayLarge
              : Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              color: colors.cardBackground,
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dark Mode',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: colors.textSecondary),
                        ),
                        Switch.adaptive(
                          value: themeManager.isDarkMode,
                          onChanged: (value) {
                            themeManager.toggleTheme(value);
                          },
                          activeColor: colors.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: colors.cardBackground,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colors.error),
                ),
                trailing: _isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: colors.error,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(isIOS ? CupertinoIcons.arrow_right_circle : Icons.logout, color: colors.error),
                onTap: _logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}