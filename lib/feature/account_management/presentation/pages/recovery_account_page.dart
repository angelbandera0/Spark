import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/generics_inputs.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';
import 'package:sparkz/di/inyector.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/recover_account/recover_account_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/pages/validate_phone_page.dart';

class RecoveryAccountPage extends StatefulWidget {
  const RecoveryAccountPage({Key? key}) : super(key: key);

  @override
  _RecoveryAccountPageState createState() => _RecoveryAccountPageState();
}

class _RecoveryAccountPageState
    extends StateWithBloC<RecoveryAccountPage, RecoverAccountBloc> {
  String email = "";
  final keyForm = GlobalKey<FormState>();

  @override
  Widget buildWidget(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _screenSize.height * 0.15;
    return BlocConsumer<RecoverAccountBloc, RecoverAccountState>(
        listener: (context, state) {
      if (state is RecoverAccountSuccessState) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ValidatePhonePage(
                    Injector.instance!.getDependency(),
                    routeParams: ParamsFromRecoveryAccountPage(email))));
      }
      return;
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is RecoverAccountSentState,
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
                title: 'Recovery Password',
              ),
              preferredSize: Size(_screenSize.width, _appBarPreferredSize)),
          backgroundColor: Color(0xFF2E3238),
          body: SingleChildScrollView(
            child: Container(
              height:
                  (_screenSize.height - _appBarPreferredSize - _padding.top),
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
              child: Form(
                key: keyForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Image.asset(
                          'assets/images/recovery.png',
                          height: 130,
                          width: 200,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                        child: Text(
                            'Enter your email address to recover your password',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.2,
                              color: Color(0xFFC0C1C2),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GenericInput(
                        labelText: 'Your email',
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
                        },
                        changeHandler: (value) {
                          email = value;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                        child: RoundedButton(
                            btnText: 'Send',
                            onPressed: () {
                              if (keyForm.currentState?.validate() ?? false) {
                                bloc?.add(RecoverAccountSentEvent(email));
                              }
                            })),
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
