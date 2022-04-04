import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_intl_phone.dart';
import 'package:sparkz/core/global/_widgets/custom_menu_button.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/generics_inputs.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/core/global/endpoints.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';
import 'package:sparkz/core/utils/index.dart';
import 'package:sparkz/di/inyector.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/update_profile/update_profile_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/validate_phone/validate_phone_bloc.dart';

import 'package:sparkz/feature/account_management/presentation/pages/validate_phone_page.dart';
import 'dart:io' show Platform;

class EditUserPage extends StatefulWidget {
  EditUserPage(this.userProfile);
  final UserProfile userProfile;

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends StateWithBloC<EditUserPage, UpdateProfileBloc>
    with Utils {
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final double avatarSize = 155;
  File? fileImage;
  var padding = const EdgeInsets.symmetric(horizontal: 20.0);
  String oldName = '';
  String oldEmail = '';
  String? oldCountry = '';
  String oldNumber = '';
  String name = '';
  String email = '';
  String? country = '';
  String number = '';
  bool updatePhone = false;

  final keyForm = GlobalKey<FormState>();

  @override
  Widget buildWidget(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _screenSize.height * 0.15;
    return BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
      if (state is UpdateUserProfileSuccessState ||
          state is UploadAvatarSuccessState ||
          state is UpdateProfileSuccessState) {
        showMessage(message: 'User information has been updated');
      }
      if (state is RequestVerificationCodeSuccessState) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ValidatePhonePage(
                    Injector.instance!.getDependency(),
                    routeParams: ParamsFromUpdateUserProfile(
                        userName: name,
                        number: number,
                        country: country,
                        email: email))));
      }
    }, builder: (context, state) {
      //oldName = widget.userProfile.getFullName()!;
      //oldEmail = widget.userProfile.getEmail()!;
      oldCountry = widget.userProfile.getPhoneCode();
      oldNumber = widget.userProfile.getPhoneNumber()!;
      return ModalProgressHUD(
        inAsyncCall: state is UpdateProfileSentState ||
            state is RequestVerificationCodeSentState,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: PreferredSize(
                child: CustomAppBar(
                  leading: CustomUpperButton(
                    icon: Icons.arrow_back,
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                  title: 'Account',
                ),
                preferredSize: Size(_screenSize.width, _appBarPreferredSize)),
            backgroundColor: Color(0xFF2E3238),
            body: Form(
                key: keyForm,
                child: Container(
                  height: (_screenSize.height -
                      _appBarPreferredSize -
                      _padding.top),
                  width: MediaQuery.of(context).size.width,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: _buildHeader()),
                        Padding(
                          padding: padding,
                          child: GenericInput(
                            labelText: 'Name',
                            fieldHint: 'Robert Plant',
                            iconLink: 'assets/images/icon_user.png',
                            keyType: TextInputType.text,
                            initialValue: widget.userProfile.getFullName(),
                            validatorHandler: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Name';
                              } else
                                return null;
                            },
                            changeHandler: (value) {
                              name = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: padding,
                          child: GenericInput(
                            labelText: 'Your email',
                            fieldHint: 'example@company.com',
                            keyType: TextInputType.emailAddress,
                            iconLink: 'assets/images/icon_email.png',
                            iconHeight: 12,
                            iconWidth: 18,
                            initialValue: widget.userProfile.getEmail(),
                            validatorHandler: (value) {
                              if (value == null || value.isEmpty) return null;

                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return 'Please enter a valid email';
                              }
                            },
                            changeHandler: (value) {
                              email = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: padding,
                          child: Text('Phone Number',
                              style: TextStyle(
                                  color: Color(0xFFC0C1C2),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat')),
                        ),
                        updatePhone == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CustomIntlPhone(
                                  handleCountryCode: (code) =>
                                      country = code.dialCode,
                                  handlePhoneNumber: (value) => number = value,
                                  validatePhone: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a phone number';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            : const SizedBox(height: 5),
                        Padding(
                          padding: padding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  widget.userProfile.getPhoneCode()! +
                                      ' ' +
                                      widget.userProfile.getPhoneNumber()!,
                                  style: TextStyle(
                                      color: Color(0xFFC0C1C2),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat')),
                              RoundedButton(
                                btnText:
                                    updatePhone == true ? 'Cancel' : 'Update',
                                onPressed: () {
                                  setState(() {
                                    updatePhone = !updatePhone;
                                  });
                                },
                                color: Color(0xFF1B1C20),
                                width: 105,
                                height: 45,
                                textColor: const Color(0xFFFF4F01),
                                borderColor: Colors.transparent,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: padding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RoundedButton(
                                btnText: 'Cancel',
                                onPressed: () {
                                  /*Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditUserPage(widget.userProfile)),
                                      (route) => false);*/
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              super.widget));
                                },
                                color: Color(0xFF1B1C20),
                                width: 150,
                              ),
                              RoundedButton(
                                btnText: 'Accept',
                                onPressed: () {
                                  if (keyForm.currentState?.validate() ??
                                      false) {
                                    if (name.isEmpty &&
                                        email.isEmpty &&
                                        number.isEmpty) return null;

                                    if (keyForm.currentState?.validate() ??
                                        false) {
                                      if (updatePhone) {
                                        if (number.isEmpty ||
                                            (oldCountry == country &&
                                                oldNumber == number)) return;
                                        bloc?.add(
                                            RequestVerificationCodeSentEvent(
                                                '$country$number'));
                                      } else {
                                        bloc?.add(UpdateProfileSentEvent(
                                            //name.isEmpty ? oldName : name,
                                            //email.isEmpty ? oldEmail : email
                                            name,
                                            email));
                                      }
                                    }
                                  }
                                },
                                width: 150,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
      );
    });
  }

  Widget _buildHeader() => Container(
        child: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(child: loadAvatarImage()),
              Container(
                margin: EdgeInsets.only(top: 100.0, left: 100.0),
                child: CustomMenuButton(Icons.camera_alt, () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFF2E3238),
                          title: Text('Choose option',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat')),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                InkWell(
                                  splashColor: Color(0xFFC0C1C2),
                                  child: Row(
                                    children: [
                                      Icon(Icons.camera,
                                          color: Color(0xFFFF4F01)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('Camera',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat')),
                                    ],
                                  ),
                                  onTap: () async {
                                    if (Platform.isIOS) {
                                      bloc?.add(
                                          UpdateImageEvent(ImageSource.camera));
                                    } else {
                                      await openCamera();
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(height: 20),
                                InkWell(
                                  splashColor: Color(0xFFC0C1C2),
                                  child: Row(
                                    children: [
                                      Icon(Icons.image,
                                          color: Color(0xFFFF4F01)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('Gallery',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat')),
                                    ],
                                  ),
                                  onTap: () async {
                                    bloc?.add(
                                        UpdateImageEvent(ImageSource.gallery));
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }),
              )
            ],
          ),
        ),
      );

  Widget loadAvatarImage() {
    if (fileImage != null) {
      return ClipOval(
        child: Image.file(
          fileImage!,
          width: avatarSize,
          height: avatarSize,
          fit: BoxFit.cover,
        ),
      );
    }

    if (widget.userProfile.getAvatar()?.isNotEmpty ?? false) {
      final url = Endpoint.API_AZURE_STORAGE + widget.userProfile.getAvatar()!;
      return ClipOval(
          child: Image.network(url,
              width: avatarSize, height: avatarSize, fit: BoxFit.cover));
    }

    return ClipOval(
        child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/avatar_background.png'))),
      child: Image.asset(
        'assets/images/avatar.png',
        width: avatarSize,
        height: avatarSize,
        fit: BoxFit.cover,
      ),
    ));
  }

  Future<void> openCamera() async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CameraCamera(
              onFile: (file) {
                bloc?.add(UpdateImageEventCamera(file));
                Navigator.pop(context);
              },
            )));
  }
}
