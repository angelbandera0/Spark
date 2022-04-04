import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/feature/car/presentation/bloc/delete_car/delete_car_bloc.dart';
import 'package:sparkz/feature/car/presentation/pages/car_menu_page.dart';

class CustomDetailCard extends StatelessWidget {
  CustomDetailCard(
      {Key? key,
      required this.title,
      required this.cardBran,
      required this.cardModel,
      required this.cardSize,
      required this.plateNumber,
      required this.carColor,
      this.onHandleEdit,
      required this.onHandleDelete})
      : super(key: key);
  final String title;
  final String cardBran;
  final String cardModel;
  final String cardSize;
  final String plateNumber;
  final String carColor;
  final VoidCallback? onHandleEdit;
  final int onHandleDelete;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.38,
      margin: EdgeInsets.only(bottom: 15, right: 20, left: 20, top: 5),
      width: size.width,
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: -4,
          shadowDarkColorEmboss: Colors.black87,
          shadowLightColorEmboss: Colors.white54,
          color: Colors.transparent,
        ),
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: Color(0xFFC0C1C2),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            fontSize: 18)),
                    Spacer(),
                    IconButton(
                        constraints:
                            BoxConstraints(minHeight: 10, minWidth: 10),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        onPressed: onHandleEdit,
                        icon: Icon(
                          FontAwesomeIcons.solidEdit,
                          size: 16,
                          color: const Color(0xFFC0C1C2),
                        )),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    DeleteCarButton(onHandleDelete: onHandleDelete)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Car Brand',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(cardBran,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: size.width * 0.15),
                            child: Text('Model',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(cardModel,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Car Size',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(cardSize,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Plate Number',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(plateNumber,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text('Car Color',
                                style: TextStyle(
                                    color: Color(0xFFC0C1C2),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                            child: Text(carColor,
                                style: TextStyle(
                                    color: Color(0xFFFF4F01),
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12)))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteCarButton extends StatefulWidget {
  const DeleteCarButton({
    Key? key,
    required this.onHandleDelete,
  }) : super(key: key);

  final int onHandleDelete;

  @override
  _DeleteCarButtonState createState() => _DeleteCarButtonState();
}

class _DeleteCarButtonState
    extends StateWithBloC<DeleteCarButton, DeleteCarBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return BlocConsumer<DeleteCarBloc, DeleteCarState>(
        listener: (context, state) {
      if (state is DeleteCarSuccessState) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CarMenuPage()));
      }
      return;
    }, builder: (context, state) {
      return IconButton(
          constraints: BoxConstraints(minHeight: 10, minWidth: 10),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.zero,
          onPressed: () {
            context
                .read<DeleteCarBloc>()
                .add(DeleteCarSentEvent(widget.onHandleDelete));
            //
          },
          icon: Icon(
            FontAwesomeIcons.trash,
            size: 16,
            color: const Color(0xFFFF4F01),
          ));
    });
  }
}
