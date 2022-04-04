import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/feature/auction/presentation/bloc/publish_auction/publish_auction_bloc.dart';
import 'package:sparkz/feature/auction/presentation/pages/list_auction_page.dart';

class PublishAuctionButton extends StatefulWidget {
  const PublishAuctionButton({
    Key? key,
    required this.keyForm,
    required this.size,
    required this.waitTime,
    required this.minimunBid,
    required this.isActive,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    required this.locality,
  }) : super(key: key);

  final String size;
  final int waitTime;
  final double minimunBid;
  final bool isActive;
  final String latitude;
  final String longitude;
  final String country;
  final String state;
  final String locality;
  final GlobalKey<FormState> keyForm;

  @override
  _PublishAuctionButtonState createState() => _PublishAuctionButtonState();
}

class _PublishAuctionButtonState
    extends StateWithBloC<PublishAuctionButton, PublishAuctionBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return BlocConsumer<PublishAuctionBloc, PublishAuctionState>(
        listener: (context, state) {
      if (state is PublishAuctionSuccessState) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ListAuctionPage()));
      }
      return;
    }, builder: (context, state) {
      return RoundedButton(
          btnText: 'Publish',
          onPressed: () {
            if (widget.keyForm.currentState?.validate() ?? false) {
              context.read<PublishAuctionBloc>().add(PublishAuctionSentEvent(
                  widget.size,
                  widget.waitTime,
                  widget.minimunBid,
                  widget.isActive,
                  widget.latitude,
                  widget.longitude,
                  widget.country,
                  widget.state,
                  widget.locality));
            }
          });
    });
  }
}
