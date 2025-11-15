import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'theme/theme_manager.dart';
import 'theme/app_themes.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';
import 'dart:developer' as developer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  developer.log('Initializing Parse...');
  // Initialize Back4App
  const keyApplicationId = 'xJFeVxlx0DxFr7BLkqfyXAKFNFQTWitmMi9aIl0g';
  const keyClientKey = 'rg3vm7FKDgXzZarOMfMKiNx5qQIzNjYnxfaW1MVP';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
  );
  developer.log('Parse initialized.');

  developer.log('Loading theme...');
  final themeManager = ThemeManager();
  await themeManager.loadThemeMode();
  developer.log('Theme loaded.');

  // Diagnostic delay
  await Future.delayed(const Duration(seconds: 3));

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeManager,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, _) {
        return MaterialApp(
          title: 'Task Manager',
          debugShowCheckedModeBanner: false,
          themeMode: themeManager.getThemeMode(),
          theme: AppThemes.getLightTheme(),
          darkTheme: AppThemes.getDarkTheme(),
          home: const AuthChecker(),
        );
      },
    );
  }
}

class AuthChecker extends StatefulWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  Future<ParseUser?>? _currentUserFuture;

  @override
  void initState() {
    super.initState();
    developer.log('AuthChecker: initState');
    _currentUserFuture = _getCurrentUser();
  }

  Future<ParseUser?> _getCurrentUser() async {
    developer.log('AuthChecker: _getCurrentUser');
    try {
      final user = await ParseUser.currentUser().then((value) => value as ParseUser?);
      developer.log('AuthChecker: _getCurrentUser success');
      return user;
    } catch (e) {
      // Handle errors, e.g., by logging them or showing an error message.
      developer.log('Error getting current user: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    developer.log('AuthChecker: build');
    return FutureBuilder<ParseUser?>(
      future: _currentUserFuture,
      builder: (context, snapshot) {
        developer.log('AuthChecker: FutureBuilder builder');
        if (snapshot.connectionState == ConnectionState.waiting) {
          developer.log('AuthChecker: FutureBuilder waiting');
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
        }
        
        if (snapshot.hasData && snapshot.data != null) {
          developer.log('AuthChecker: FutureBuilder hasData');
          return const MainScreen();
        }
        
        developer.log('AuthChecker: FutureBuilder noData');
        return const LoginScreen();
      },
    );
  }
}