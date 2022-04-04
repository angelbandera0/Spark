import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/feature/auction/presentation/bloc/delete_auction/delete_auction_bloc.dart';
import 'package:sparkz/feature/auction/presentation/bloc/start_auction/start_auction_bloc.dart';
import 'package:sparkz/feature/auction/presentation/pages/list_auction_page.dart';

class CustomDetailTile extends StatelessWidget {
  CustomDetailTile(
      {Key? key,
      this.textTime,
      required this.size,
      this.textLocation = 'Fill Location',
      required this.isActive,
      this.onHandleEdit,
      required this.onHandleDelete,
      required this.onHandleStart})
      : super(key: key);

  final String? textTime;
  final String textLocation;
  final String size;
  final bool isActive;
  final VoidCallback? onHandleEdit;
  final int onHandleDelete;
  final int onHandleStart;

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 15, left: 15, top: 5),
      child: Neumorphic(
        style: NeumorphicStyle(
            depth: -4,
            shadowDarkColorEmboss: Colors.black87,
            shadowLightColorEmboss: Colors.white54,
            color: Colors.transparent),
        child: Container(
          margin:
              const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Parking Location: ',
                      style: TextStyle(
                          color: Color(0xFFC0C1C2),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                  Spacer(),
                  (isActive)
                      ? Container()
                      : Container(
                          child: IconButton(
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
                        ),
                  SizedBox(
                    width: _screenSize.width * 0.02,
                  ),
                  DeleteAuctionButton(onHandleDelete: onHandleDelete)
                ],
              ),
              SizedBox(height: _screenSize.height * 0.01),
              Text(textLocation,
                  style: TextStyle(
                      color: Color(0xFFFF4F01),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                      fontSize: 14)),
              SizedBox(height: _screenSize.height * 0.03),
              Row(
                children: [
                  Text('Parking Spot Size:',
                      style: TextStyle(
                          color: Color(0xFFC0C1C2),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                  Spacer(),
                  Text('Time:',
                      style: TextStyle(
                          color: Color(0xFFC0C1C2),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                ],
              ),
              SizedBox(height: _screenSize.height * 0.01),
              Row(
                children: [
                  Text(size,
                      style: TextStyle(
                          color: Color(0xFFFF4F01),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w300,
                          fontSize: 14)),
                  Spacer(),
                  Text(textTime!,
                      style: TextStyle(
                          color: Color(0xFFFF4F01),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w300,
                          fontSize: 14)),
                ],
              ),
              SizedBox(height: _screenSize.height * 0.01),
              (isActive)
                  ? Container()
                  : StartAuctionButton(onHandleStart: onHandleStart),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAuctionButton extends StatefulWidget {
  const DeleteAuctionButton({
    Key? key,
    required this.onHandleDelete,
  }) : super(key: key);

  final int onHandleDelete;

  @override
  _DeleteAuctionButtonState createState() => _DeleteAuctionButtonState();
}

class _DeleteAuctionButtonState
    extends StateWithBloC<DeleteAuctionButton, DeleteAuctionBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return BlocConsumer<DeleteAuctionBloc, DeleteAuctionState>(
        listener: (context, state) {
      if (state is DeleteAuctionSuccessState) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ListAuctionPage()));
      }
      return;
    }, builder: (context, state) {
      return IconButton(
          constraints: BoxConstraints(minHeight: 10, minWidth: 10),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.zero,
          onPressed: () {
            context
                .read<DeleteAuctionBloc>()
                .add(DeleteAuctionSentEvent(widget.onHandleDelete));
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

class StartAuctionButton extends StatefulWidget {
  const StartAuctionButton({
    Key? key,
    required this.onHandleStart,
  }) : super(key: key);

  final int onHandleStart;

  @override
  _StartAuctionButtonState createState() => _StartAuctionButtonState();
}

class _StartAuctionButtonState
    extends StateWithBloC<StartAuctionButton, StartAuctionBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return BlocConsumer<StartAuctionBloc, StartAuctionState>(
        listener: (context, state) {
      if (state is StartAuctionSuccessState) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ListAuctionPage()));
      }
      return;
    }, builder: (context, state) {
      return Center(
          child: RoundedButton(
              width: 180,
              btnText: 'Start an Auction',
              onPressed: () {
                context
                    .read<StartAuctionBloc>()
                    .add(StartAuctionSentEvent(widget.onHandleStart));
              }));
    });
  }
}
