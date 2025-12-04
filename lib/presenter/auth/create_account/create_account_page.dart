import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../components/button/main_button.dart';
import '../../../components/dialogs/info_dialog.dart';
import '../../../components/loadings/small_loading.dart';
import '../../../components/textfield/textfield.dart';
import '../../../responsiveness/responsive.dart';
import '../../../responsiveness/shared_font_style.dart';
import '../../../theme/colors.dart';
import '../../../utils/assets.dart';
import '../../../utils/dependencies.dart';
import '../../../utils/routes/app_navigator.dart';
import '../../../utils/routes/app_routes.dart';
import '../../../utils/validators/email_validator.dart';
import '../../../utils/validators/empty_validator.dart';
import 'store/create_account_store.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final store = getIt<CreateAccountStore>();
  final navigator = AppNavigator();

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
          Image.asset(
            SharedAssets.studentThree,

            height: Responsive.getSize(250),
          ),
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
              key: store.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text('Criar conta', style: SharedFontStyle.h4Bold),
                  ),

                  SizedBox(height: Responsive.getSize(16)),
                  SharedTextfield(
                    label: 'Email',
                    controller: store.emailController,
                    hint: 'Email',
                    validator: (value) {
                      if (EmailValidator.validEmail(value)) {
                        return null;
                      }
                      return "Insira um email válido";
                    },
                  ),
                  SizedBox(height: Responsive.getSize(16)),

                  SharedTextfield(
                    controller: store.passwordController,
                    hint: 'Senha',
                    label: 'Senha',
                    isObscureText: true,

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
                  SizedBox(height: Responsive.getSize(16)),

                  SharedTextfield(
                    label: 'Confirme a senha',
                    controller: store.confirmPasswordController,
                    hint: 'Confirme a senha',
                    isObscureText: true,
                    validator: (value) {
                      final password = value as String?;
                      if (!EmptyValidator.emptyValidator(password)) {
                        return "Insira uma senha válida.";
                      }
                      if (password!.length < 6) {
                        return "A senha não pode ter menos de 6 caracteres";
                      }

                      if (!store.isSamePassword) {
                        return "As senhas são diferentes.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Responsive.getSize(30)),
                  Observer(
                    builder: (context) {
                      return SharedMainButton(
                        onTap: () async {
                          if (!store.formKey.currentState!.validate()) return;
                          final response = await store.createAccount();

                          if (response == false && context.mounted) {
                            await InfoDialog.show(
                              'Falha',
                              store.exception!,
                              context,
                            );
                            return;
                          }

                          navigator.goto(SharedRoutes.home, replace: true);
                        },
                        buttonColor: primaryColor,
                        label: store.isLoading
                            ? SharedSmallLoading()
                            : Text(
                                'Criar',
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
