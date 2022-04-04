import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_checkbox.dart';
import 'package:sparkz/core/global/_widgets/generics_inputs.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/platform/signalr_service.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/log_in/log_in_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/pages/home_page.dart';
import 'package:sparkz/feature/account_management/presentation/pages/recovery_account_page.dart';
import 'package:sparkz/feature/account_management/presentation/pages/sign_up_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key, required this.signalRService}) : super(key: key);
  final SignalRService signalRService;

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends StateWithBloC<LogInPage, LogInBloc> {
  bool showSpinner = false;
  final passwordRegExp = RegExp(
      r"^(?=.{8,})(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+*!=]).*$");

  final keyForm = GlobalKey<FormState>();

  late String email;
  late String password;
  late bool rememberMe;

  FocusNode userNameNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();
    email = "";
    password = "";
    rememberMe = false;
    bloc?.add(LogInRememberEvent());
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return BlocConsumer<LogInBloc, LogInState>(listener: (context, state) {
      if (state is LogInSuccessState) {
        widget.signalRService.startConnection().whenComplete(() =>
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage())));
      }
      return;
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is LogInSentState,
        child: Scaffold(
          backgroundColor: Color(0xFF34393F),
          body: Form(
              key: keyForm,
              child: SingleChildScrollView(
                  child: SafeArea(
                child: Container(
                  height:
                      _screenSize.height - MediaQuery.of(context).padding.top,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF34393F),
                      Color(0xFF1B1C20),
                    ],
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: _screenSize.height * 0.23,
                          child: Center(
                              child: Image.asset('assets/images/login.png'))),
                      SizedBox(
                        height: _screenSize.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GenericInput(
                          labelText: 'Your email',
                          nameNode: userNameNode,
                          keyType: TextInputType.emailAddress,
                          fieldHint: 'example@company.com',
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
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GenericInput(
                          labelText: 'Password',
                          nameNode: passwordNode,
                          fieldHint: 'Password',
                          iconLink: 'assets/images/icon_lock.png',
                          iconHeight: 19,
                          isFieldPassword: true,
                          validatorHandler: (value) {
                            final validPass =
                                passwordRegExp.hasMatch(value ?? "");
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Password';
                            } else if (!validPass) {
                              return 'Please use at least 8 characters, a capital letter, a special key, and a number';
                            } else
                              return null;
                          },
                          changeHandler: (value) {
                            password = value;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 6, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                CustomCheckBox(
                                    checkBoxValue: rememberMe,
                                    onChangeHandler: (value) {
                                      setState(() {
                                        rememberMe = value!;
                                      });
                                    }),
                              ],
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                ),
                                onPressed: () {
                                  setState(() {
                                    rememberMe = !rememberMe;
                                  });
                                },
                                child: Text(
                                  'Remember me',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: _screenSize.width * 0.044,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFC0C1C2),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RecoveryAccountPage(),
                                    )),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: _screenSize.width * 0.044,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFFF4F01),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _screenSize.height * 0.01,
                      ),
                      Center(
                        child: RoundedButton(
                          btnText: 'Login',
                          onPressed: () {
                            if (keyForm.currentState?.validate() ?? false)
                              bloc?.add(
                                  LogInSendEvent(email, password, rememberMe));
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: _screenSize.width * 0.044,
                                fontWeight: FontWeight.w500,
                                color: (Color(0xFFC0C1C2)),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingUpPage()));
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: _screenSize.width * 0.044,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFF4F01),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))),
        ),
      );
    });
  }
}
