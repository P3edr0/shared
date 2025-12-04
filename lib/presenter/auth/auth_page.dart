import 'package:flutter/material.dart';
import 'package:shared/presenter/auth/create_account/create_account_page.dart';
import 'package:shared/presenter/auth/login/login_page.dart';
import 'package:shared/presenter/auth/reset_password/reset_password_page.dart';
import 'package:shared/theme/colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  List<Widget> _pages = [];
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pages = [LoginPage(), CreateAccountPage(), ResetPasswordPage()];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return Scaffold(
                body: Container(
                  decoration: BoxDecoration(color: primaryColor),

                  child: SingleChildScrollView(
                    child: Column(children: [_pages[index]]),
                  ),
                ),
              );
            },
            itemCount: _pages.length,
            onPageChanged: (newIndex) => setState(() {
              _currentPage = newIndex;
            }),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 50),
          color: secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                height: 10,
                width: _currentPage == index ? 30 : 10,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? primaryColor
                      : primaryColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
