import 'package:flutter/material.dart';
import 'package:shared/presenter/auth/auth_page.dart';

import '../../presenter/home/home_page.dart';
import '../../presenter/post_details_page/post_details_page.dart';
import '../../presenter/post_page/post_page.dart';
import '../../presenter/splash/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SharedRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());

      case SharedRoutes.home:
        return MaterialPageRoute(builder: (_) => HomePage());

      case SharedRoutes.auth:
        return MaterialPageRoute(builder: (_) => AuthPage());
      case SharedRoutes.post:
        return MaterialPageRoute(builder: (_) => PostPage());
      case SharedRoutes.postDetails:
        return MaterialPageRoute(builder: (_) => PostDetailsPage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Rota não encontrada'))),
        );
    }
  }
}
