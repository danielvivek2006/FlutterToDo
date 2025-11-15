import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'theme/theme_manager.dart';
import 'theme/app_themes.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  
  // Initialize Back4App
  const keyApplicationId = 'xJFeVxlx0DxFr7BLkqfyXAKFNFQTWitmMi9aIl0g';
  const keyClientKey = 'rg3vm7FKDgXzZarOMfMKiNx5qQIzNjYnxfaW1MVP';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    debug: true,
    autoSendSessionId: true,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
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

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  Future<ParseUser?> _getCurrentUser() async {
    return await ParseUser.currentUser().then((value) => value as ParseUser?);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ParseUser?>(
      future: _getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
          return const MainScreen();
        }
        
        return const LoginScreen();
      },
    );
  }
}