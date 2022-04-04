import 'package:flutter/material.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/feature/help/presentation/widgets/custom_text_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/feature/help/presentation/bloc/contact_us/contact_us_bloc.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends StateWithBloC<ContactPage, ContactUsBloc> {
  String body = "";
  final keyForm = GlobalKey<FormState>();

  @override
  Widget buildWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final appBarPreferredSize = size.height * 0.15;

    return BlocConsumer<ContactUsBloc, ContactUsState>(
        listener: (context, state) {
      if (state is ContactUsSuccessState) {}
    }, builder: (context, state) {

      return ModalProgressHUD(
        inAsyncCall: state is ContactUsSentState,
        child: Scaffold(
          appBar: PreferredSize(


              child: Container(

                margin: EdgeInsets.only(right:60.0),
                 child: CustomAppBar(
                    leading: CustomUpperButton(
                      icon: Icons.arrow_back,
                    ),
                    title: 'Contact Us',

                  ),),
              preferredSize: Size(size.width, appBarPreferredSize)),
          backgroundColor:Color(0xFF34393F),
          body: Form(
            key: keyForm,
            child: Container(

                height: (size.height - appBarPreferredSize - padding.top),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xFF34393F),
                      Color(0xFF1B1C20),
                    ])),
                child: Container(
                  height: (size.height - appBarPreferredSize - padding.top),
                  width: size.width,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tell us about your problem, we will try to help you',
                          style: TextStyle(
                              height: 1.5,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFC0C1C2)),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        CustomTextBox(
                          validatorHandler: (value) {
                            if (value?.isEmpty ?? true) {
                              return ('');
                            }
                            return null;
                          },
                          changeHandler: (value) {
                            body = value;
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Center(
                            child: RoundedButton(
                                btnText: 'Send',
                                onPressed: () {
                                  if (keyForm.currentState?.validate() ??
                                      false) {
                                    bloc?.add(ContactUsSentEvent(body));
                                  }
                                })),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      );
    });
  }
}
