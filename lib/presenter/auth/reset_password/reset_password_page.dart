import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared/presenter/auth/reset_password/store/reset_password_store.dart';
import 'package:shared/utils/dependencies.dart';

import '../../../components/button/main_button.dart';
import '../../../components/dialogs/info_dialog.dart';
import '../../../components/loadings/small_loading.dart';
import '../../../components/textfield/textfield.dart';
import '../../../responsiveness/responsive.dart';
import '../../../responsiveness/shared_font_style.dart';
import '../../../theme/colors.dart';
import '../../../utils/assets.dart';
import '../../../utils/validators/email_validator.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final store = getIt<ResetPasswordStore>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height: Responsive.getSize(40)),

        Text(
          'SharEd',
          style: SharedFontStyle.h2Bold.copyWith(color: secondaryColor),
        ),
        SizedBox(height: Responsive.getSize(20)),
        Image.asset(SharedAssets.student, height: Responsive.getSize(448)),
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
                  child: Text('Recuperar senha', style: SharedFontStyle.h4Bold),
                ),
                SizedBox(height: Responsive.getSize(20)),

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
                Observer(
                  builder: (context) {
                    return SharedMainButton(
                      onTap: () async {
                        if (!store.formKey.currentState!.validate()) return;
                        final response = await store.resetPassword();
                        if (response == false && context.mounted) {
                          await InfoDialog.show(
                            'Falha',
                            store.exception!,
                            context,
                          );
                          return;
                        }
                        if (context.mounted) {
                          await InfoDialog.show(
                            'Sucesso',
                            'Te enviamos um email para você resetar a sua senha',
                            context,
                          );
                        }
                      },
                      buttonColor: primaryColor,
                      label: store.isLoading
                          ? SharedSmallLoading()
                          : Text(
                              'Recuperar',
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
    );
  }
}
