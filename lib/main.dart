import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared/firebase_options.dart';
import 'package:shared/presenter/auth/auth_page.dart';
import 'package:shared/theme/custom_themes/theme.dart';

import 'locale/locale_controller.dart';
import 'locale/localizations.dart';
import 'utils/dependencies.dart';
import 'utils/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(const App());
}

final navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = LocaleController.instance();
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: AppPages.onGenerateRoute,
      localizationsDelegates: SharedLocalizations.localizationsDelegates,
      supportedLocales: SharedLocalizations.supportedLocales,
      theme: ShareAppTheme.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      locale: localeController.locale,
      home: const AuthPage(),
    );
  }
}
