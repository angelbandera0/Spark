import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_intl_phone.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';

import 'package:sparkz/core/global/_widgets/generics_inputs.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';
import 'package:sparkz/di/inyector.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/pages/log_in_page.dart';
import 'package:sparkz/feature/account_management/presentation/pages/validate_phone_page.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends StateWithBloC<SingUpPage, SignUpBloc> {
  String fullName = "";
  String email = "";
  String pass = "";
  String repass = "";
  String? country = "+1";
  String number = "";

  final keyForm = GlobalKey<FormState>();
  final passwordRegExp = RegExp(
      r"^(?=.{8,})(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+*!=]).*$");

  @override
  Widget buildWidget(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _screenSize.height * 0.15;
    return BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state is SingUpSuccessState) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ValidatePhonePage(
                    Injector.instance!.getDependency(),
                    routeParams:
                        ParamsFromSignUpPage(email, '$country $number'))));
      }
      return;
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is SingUpSentState,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
              child: CustomAppBar(
                leading: CustomUpperButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: 'Create Account',
              ),
              preferredSize: Size(_screenSize.width, _appBarPreferredSize)),
          backgroundColor: Color(0xFF2E3238),
          body: Form(
            key: keyForm,
            child: Container(
              height:
                  (_screenSize.height - _appBarPreferredSize - _padding.top),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFF34393F),
                    Color(0xFF1B1C20),
                  ])),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GenericInput(
                        labelText: 'Name',
                        fieldHint: 'Robert Plant',
                        iconLink: 'assets/images/icon_user.png',
                        keyType: TextInputType.text,
                        validatorHandler: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Name';
                          } else
                            return null;
                        },
                        changeHandler: (value) {
                          fullName = value;
                        },
                      ),
                    ),
                    SizedBox(height: _screenSize.height * 0.01),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GenericInput(
                        labelText: 'Your email',
                        fieldHint: 'example@company.com',
                        keyType: TextInputType.emailAddress,
                        iconLink: 'assets/images/icon_email.png',
                        iconHeight: 12,
                        iconWidth: 18,
                        validatorHandler: (value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value ?? "");
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          } else if (!emailValid) {
                            return 'Please valid enter an email';
                          }
                          return null;
                        },
                        changeHandler: (value) {
                          email = value;
                        },
                      ),
                    ),
                    SizedBox(height: _screenSize.height * 0.01),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomIntlPhone(
                        labelText: 'Phone number',
                        handleCountryCode: (code) => country = code.dialCode,
                        handlePhoneNumber: (value) => number = value,
                        validatePhone: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: _screenSize.height * 0.01),
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
                          pass = value;
                        },
                      ),
                    ),
                    SizedBox(height: _screenSize.height * 0.01),
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
                          } else if (pass != value) {
                            return 'Passwords do not match';
                          } else
                            return null;
                        },
                        changeHandler: (value) {
                          repass = value;
                        },
                      ),
                    ),
                    SizedBox(height: _screenSize.height * 0.01),
                    RoundedButton(
                      btnText: 'Sign Up',
                      onPressed: () {
                        if (keyForm.currentState?.validate() ?? false) {
                          print(number);
                          bloc?.add(SignUpSentEvent(
                              fullName, email, pass, repass, country!, number));
                        }
                      },
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => LogInPage(
                                  signalRService:
                                      Injector.instance!.getDependency())),
                          (route) => false),
                      child: Text(
                        'I am already a member',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          color: Color(0xFFFF4F01),
                        ),
                      ),
                    ),
                    SizedBox(height: _screenSize.height * 0.02),
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
