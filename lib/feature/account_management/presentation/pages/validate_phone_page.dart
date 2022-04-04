import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_count_down_button.dart';
import 'package:sparkz/core/global/_widgets/custom_single_code.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/update_profile/update_profile_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/validate_phone/validate_phone_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/pages/edit_user_page.dart';
import 'package:sparkz/feature/account_management/presentation/pages/recover_password_page.dart';
import 'package:sparkz/feature/account_management/presentation/pages/sign_up_confirmation.dart';

class ValidatePhonePage extends StatefulWidget {
  ValidatePhonePage(this._userProfile, {this.routeParams});
  final RouteParams? routeParams;
  final UserProfile _userProfile;

  @override
  _NumberValidationPageState createState() => _NumberValidationPageState();
}

class _NumberValidationPageState
    extends StateWithBloC<ValidatePhonePage, ValidatePhoneBloc>
    with TickerProviderStateMixin {
  String? userName = '';
  String? email = '';
  String? country = '';
  String? number = '';
  String phoneNumber = '';
  String code = '';

  late String c1;
  late String c2;
  late String c3;
  late String c4;
  late String c5;
  late String c6;

  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final FocusNode f3 = FocusNode();
  final FocusNode f4 = FocusNode();
  final FocusNode f5 = FocusNode();
  final FocusNode f6 = FocusNode();

  late AnimationController _controller;
  static const int MaxCountDown = 10;

  @override
  void initState() {
    super.initState();

    c1 = '';
    c2 = '';
    c3 = '';
    c4 = '';
    c5 = '';
    c6 = '';

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: MaxCountDown),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          bloc?.add(ValidatePhoneInitialEvent());
        }
      });

    _parseRouteParams();
  }

  void _parseRouteParams() {
    if (widget.routeParams is ParamsFromRecoveryAccountPage) {
      final params = widget.routeParams as ParamsFromRecoveryAccountPage;
      email = params.email;
      phoneNumber = widget._userProfile.getPhoneNumber()!;
    }

    if (widget.routeParams is ParamsFromSignUpPage) {
      final params = widget.routeParams as ParamsFromSignUpPage;
      email = params.email;
      phoneNumber = params.phoneNumber;
    }

    if (widget.routeParams is ParamsFromUpdateUserProfile) {
      final params = widget.routeParams as ParamsFromUpdateUserProfile;
      userName = params.userName;
      email = widget._userProfile.getEmail();
      country = params.country;
      number = params.number;

      print('email: $email');
    }
  }

  bool _checkValidationPhoneState(ValidatePhoneState state) {
    return (state is UpdateProfileSentState ||
        state is RequestVerificationCodeSentState ||
        state is ValidateCodeRequestSentState);
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _screenSize.height * 0.15;
    return BlocConsumer<ValidatePhoneBloc, ValidatePhoneState>(
        listener: (context, state) {
      if (state is ValidatePhoneSuccessState) {
        if (widget.routeParams is ParamsFromRecoveryAccountPage) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => RecoverPasswordPage(
                      routeParams: ParamsFromValidatePhonePage(code))));
        } else if (widget.routeParams is ParamsFromSignUpPage) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => SignUpConfirmation()));
        } else if (widget.routeParams is ParamsFromSignUpPage) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => SignUpConfirmation()));
        } else if (widget.routeParams is ParamsFromUpdateUserProfile) {
          bloc?.add(UpdateUserProfileSentEvent(
              country: country, email: email, name: userName, number: number));
        }
      }

      if (state is UpdateUserProfileSuccessState) {
        widget._userProfile
            .setEmail(email == '' ? widget._userProfile.getEmail()! : email!);
        widget._userProfile.setFullName(
            userName == '' ? widget._userProfile.getFullName()! : userName!);
        widget._userProfile
            .setPhoneCode(country ?? widget._userProfile.getPhoneCode()!);
        widget._userProfile
            .setphoneNumber(number ?? widget._userProfile.getPhoneNumber()!);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => EditUserPage(widget._userProfile)));
      }

      if (state is ValidateCodeRequestSuccessState) {
        bloc?.add(UpdateUserProfileSentEvent(
            name: userName, email: email, country: country, number: number));
      }
      return;
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: _checkValidationPhoneState(state),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              child: CustomAppBar(
                leading: CustomUpperButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: '',
              ),
              preferredSize: Size(_screenSize.width, _appBarPreferredSize)),
          backgroundColor: Color(0xFF2E3238),
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height:
                  (_screenSize.height - _appBarPreferredSize - _padding.top),
              width: _screenSize.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFF34393F),
                    Color(0xFF1B1C20),
                  ])),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            heightFactor: 0.6,
                            child: Image.asset(
                              'assets/images/blur.png',
                            ),
                          ),
                          Image(image: AssetImage('assets/images/shield.png'))
                        ],
                      ),
                    ),
                    SizedBox(height: _screenSize.height * 0.04),
                    Text('Phone Number Verification',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFF4F01),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 14),
                    RichText(
                        text: TextSpan(
                            children: [
                          // if(1==2){
                          TextSpan(
                              text:
                                  'Enter the code sent to $country$number'), //}
                          TextSpan(
                              text: phoneNumber,
                              style: TextStyle(color: Colors.white)),
                        ],
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFC0C1C2),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ))),
                    SizedBox(height: 42),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomSingleCode(
                            node: f1,
                            onChange: (value) {
                              c1 = value;
                              f1.unfocus();
                              FocusScope.of(context).requestFocus(f2);
                            }),
                        CustomSingleCode(
                            node: f2,
                            onChange: (value) {
                              c2 = value;
                              f2.unfocus();
                              FocusScope.of(context).requestFocus(f3);
                            }),
                        CustomSingleCode(
                            node: f3,
                            onChange: (value) {
                              c3 = value;
                              f3.unfocus();
                              FocusScope.of(context).requestFocus(f4);
                            }),
                        CustomSingleCode(
                            node: f4,
                            onChange: (value) {
                              c4 = value;
                              f4.unfocus();
                              FocusScope.of(context).requestFocus(f5);
                            }),
                        CustomSingleCode(
                            node: f5,
                            onChange: (value) {
                              c5 = value;
                              f5.unfocus();
                              FocusScope.of(context).requestFocus(f6);
                            }),
                        CustomSingleCode(
                            node: f6,
                            onChange: (value) {
                              c6 = value;
                              f6.unfocus();
                              FocusScope.of(context).requestFocus(f1);
                            }),
                      ],
                    ),
                    SizedBox(height: 15),
                    BlocBuilder<ValidatePhoneBloc, ValidatePhoneState>(
                      builder: (context, state) {
                        if (state is WrongValidatePhoneState) {
                          return Text('Wrong verification code',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFFF4F01),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ));
                        }
                        return Container();
                      },
                    ),
                    SizedBox(height: 25),
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Didn\'t received the code? ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFC0C1C2),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                )),
                            BlocBuilder<ValidatePhoneBloc, ValidatePhoneState>(
                                builder: (context, state) {
                              if (state is RefreshValidateCodeSentState) {
                                return CustomCountDownButton(
                                    animation:
                                        StepTween(begin: MaxCountDown, end: 0)
                                            .animate(_controller));
                              }
                              return TextButton(
                                  onPressed: () {
                                    _controller.forward(from: 0.0);
                                    bloc?.add(
                                        RefreshValidateCodeSentEvent(email!));
                                  },
                                  child: Text('Resend',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFFF4F01),
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                      )));
                            })
                          ]),
                    ),
                    SizedBox(height: 5),
                    RoundedButton(
                        btnText: 'Verify',
                        onPressed: () {
                          code = c1 + c2 + c3 + c4 + c5 + c6;
                          if (widget.routeParams
                              is ParamsFromUpdateUserProfile) {
                            bloc?.add(ValidateCodeRequestSentEvent(
                                '$country$number', code));
                            print('Actualizar de UserProfile: ' +
                                widget._userProfile.getEmail()!);
                          } else {
                            bloc?.add(ValidatePhoneSentEvent(email!, code));
                            print('Actualizar de email: ' + email!);
                          }
                        }),
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
