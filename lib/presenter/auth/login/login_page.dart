import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared/components/dialogs/info_dialog.dart';
import 'package:shared/utils/routes/app_routes.dart';

import '../../../components/button/main_button.dart';
import '../../../components/loadings/small_loading.dart';
import '../../../components/textfield/textfield.dart';
import '../../../responsiveness/responsive.dart';
import '../../../responsiveness/shared_font_style.dart';
import '../../../theme/colors.dart';
import '../../../utils/assets.dart';
import '../../../utils/dependencies.dart';
import '../../../utils/routes/app_navigator.dart';
import '../../../utils/validators/email_validator.dart';
import '../../../utils/validators/empty_validator.dart';
import 'store/login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _store = getIt<LoginStore>();
final _navigator = AppNavigator();

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final size = MediaQuery.of(context).size;
      final pixelRatio = MediaQuery.of(context).devicePixelRatio;
      Responsive.defineSize(size, pixelRatio: pixelRatio);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: primaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: Responsive.getSize(40)),

          Text(
            'SharEd',
            style: SharedFontStyle.h2Bold.copyWith(color: secondaryColor),
          ),

          SizedBox(height: Responsive.getSize(20)),
          Image.asset(SharedAssets.studentTwo, height: Responsive.getSize(370)),
          Container(
            padding: EdgeInsets.all(Responsive.getSize(16)),
            alignment: Alignment.topCenter,
            width: double.infinity,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Form(
              key: _store.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text('Entrar', style: SharedFontStyle.h4Bold),
                  ),

                  SharedTextfield(
                    label: 'Email',
                    controller: _store.emailController,
                    hint: 'Email',
                    validator: (value) {
                      if (EmailValidator.validEmail(value)) {
                        return null;
                      }
                      return "Insira um email válido";
                    },
                  ),
                  SizedBox(height: Responsive.getSize(16)),
                  Text('Senha', style: SharedFontStyle.titleBold),
                  SharedTextfield(
                    controller: _store.passwordController,
                    isObscureText: true,
                    hint: 'Senha',
                    validator: (value) {
                      final password = value as String?;
                      if (!EmptyValidator.emptyValidator(password)) {
                        return "Insira uma senha válida.";
                      }
                      if (password!.length < 6) {
                        return "A senha não pode ter menos de 6 caracteres";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Responsive.getSize(30)),
                  Observer(
                    builder: (context) {
                      return SharedMainButton(
                        onTap: () async {
                          if (!_store.formKey.currentState!.validate()) return;
                          final response = await _store.login();
                          if (response == null && context.mounted) {
                            await InfoDialog.show(
                              'Falha',
                              _store.exception!,
                              context,
                            );
                            return;
                          }
                          _navigator.goto(SharedRoutes.home, replace: true);
                        },
                        buttonColor: primaryColor,
                        label: _store.isLoading
                            ? SharedSmallLoading()
                            : Text(
                                'Entrar',
                                style: SharedFontStyle.bodyLargeBold.copyWith(
                                  color: secondaryColor,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
