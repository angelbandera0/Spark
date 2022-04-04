import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/global/_widgets/custom_appbar.dart';
import 'package:sparkz/core/global/_widgets/generics_inputs.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/recovery_password/recover_password_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/pages/recovery_success_page.dart';

class RecoverPasswordPage extends StatefulWidget {
  RecoverPasswordPage({this.routeParams});
  final RouteParams? routeParams;

  @override
  _RecoveryPasswordPageState createState() => _RecoveryPasswordPageState();
}

class _RecoveryPasswordPageState
    extends StateWithBloC<RecoverPasswordPage, RecoverPasswordBloc> {
  final keyForm = GlobalKey<FormState>();
  final passwordRegExp = RegExp(
      r"^(?=.{8,})(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+*!=]).*$");

  late String code;
  late String password;
  late String confirmPassword;

  @override
  void initState() {
    super.initState();
    code = widget.routeParams is ParamsFromValidatePhonePage
        ? (widget.routeParams as ParamsFromValidatePhonePage).code
        : '';
    password = '';
    confirmPassword = '';
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BlocConsumer<RecoverPasswordBloc, RecoverPasswordState>(
        listener: (context, state) {
      if (state is RecoverPasswordSuccessState) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => RecoverySuccessPage()));
      }
      return;
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is RecoverPasswordSentState,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppBar(
            title: 'Confirm Password',
          ),
          backgroundColor: Color(0xFF2E3238),
          body: SingleChildScrollView(
            child: Form(
              key: keyForm,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xFF34393F),
                      Color(0xFF1B1C20),
                    ])),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRect(
                          child: Align(
                            alignment: Alignment.center,
                            heightFactor: 0.6,
                            child: Image.asset(
                              'assets/images/blur.png',
                            ),
                          ),
                        ),
                        Image.asset('assets/images/shield.png')
                      ],
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GenericInput(
                        labelText: 'Password',
                        fieldHint: 'Password',
                        iconLink: 'assets/images/icon_lock.png',
                        isFieldPassword: true,
                        iconHeight: 18,
                        validatorHandler: (value) {
                          final validPassword =
                              passwordRegExp.hasMatch(value ?? "");
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Password';
                          } else if (!validPassword) {
                            return 'Please use at least 8 characters, a capital letter, a special key, and a number';
                          } else
                            return null;
                        },
                        changeHandler: (value) {
                          password = value;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GenericInput(
                        labelText: 'Confirm password',
                        fieldHint: 'Password',
                        iconLink: 'assets/images/icon_lock.png',
                        isFieldPassword: true,
                        iconHeight: 18,
                        validatorHandler: (value) {
                          final validPassword =
                              passwordRegExp.hasMatch(value ?? "");

                          if (value == null || value.isEmpty) {
                            return 'Please enter a Password';
                          } else if (!validPassword) {
                            return 'Please use at least 8 characters, a capital letter, a special key, and a number';
                          } else if (password != value) {
                            return 'Passwords do not match';
                          } else
                            return null;
                        },
                        changeHandler: (value) {
                          confirmPassword = value;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: RoundedButton(
                          btnText: 'Confirm',
                          onPressed: () {
                            if (keyForm.currentState?.validate() ?? false) {
                              bloc?.add(RecoverPasswordSentEvent(
                                  code, password, confirmPassword));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
