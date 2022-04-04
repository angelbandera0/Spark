import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/global/_widgets/custom_detail_tile.dart';
import 'package:sparkz/core/global/_widgets/custom_tile.dart';
import 'package:sparkz/core/global/_widgets/custom_bottom_nav_bar.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/rounded_btn.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';

import 'package:sparkz/feature/auction/data/model/list_auction_response_model.dart';
import 'package:sparkz/feature/auction/presentation/bloc/list_auction/list_auction_bloc.dart';

import 'add_auction_page.dart';
import 'edit_auction_page.dart';

class ListAuctionPage extends StatefulWidget {
  ListAuctionPage({Key? key}) : super(key: key);

  @override
  _ListAuctionPageState createState() => _ListAuctionPageState();
}

class _ListAuctionPageState
    extends StateWithBloC<ListAuctionPage, ListAuctionBloc> {
  late List<ListAuctionResponseModel> items;

  bool showDetail = false;
  int detailIndex = 0;

  @override
  void initState() {
    super.initState();
    items = [];
    bloc?.add(ListAuctionSentEvent(1, 10));
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _screenSize.height * 0.15;
    return BlocConsumer<ListAuctionBloc, ListAuctionState>(
        listener: (context, state) {
      return;
    }, builder: (context, state) {
      return ModalProgressHUD(
          inAsyncCall: state is ListAuctionSentState,
          child: Scaffold(
              backgroundColor:  Color(0xFF34393F),
              appBar: PreferredSize(
                child: Container (
                  margin: EdgeInsets.only(right:60.0),
                  child: CustomAppBar(
                    leading: CustomUpperButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      icon: Icons.arrow_back,
                    ),
                    title: 'My Auctions',
                  ),),
                  preferredSize: Size(_screenSize.width, _appBarPreferredSize)),

              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xFF34393F),
                      Color(0xFF1B1C20),
                    ])),
                height:
                    (_screenSize.height - _appBarPreferredSize - _padding.top),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    RoundedButton(
                        btnText: 'Create an Auction',
                        width: MediaQuery.of(context).size.width * 0.90,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AddAuctionPage()));
                        }),
                    SizedBox(
                      height: _screenSize.height * 0.02,
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: StreamBuilder<List<ListAuctionResponseModel>>(
                            stream: bloc?.subject.stream,
                            builder: (context,
                                AsyncSnapshot<List<ListAuctionResponseModel>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                items = [];
                                items.addAll(snapshot.data!);
                                return ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        showDetail = !showDetail;
                                        detailIndex = index;
                                      });
                                    },
                                    child: showDetail && detailIndex == index
                                        ? CustomDetailTile(
                                            isActive: items[index].isActive,
                                            size: items[index].size,
                                            textTime: items[index]
                                                .waitTime
                                                .toString(),
                                            textLocation:
                                                items[index].location.locality,
                                            onHandleEdit: () {
                                              final entity = items[index];
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          EditAuctionPage(
                                                            routeParams:
                                                                ParamsFromListAuction(
                                                                    entity),
                                                          )));
                                            },
                                            onHandleDelete: items[index].id!,
                                            onHandleStart: items[index].id!)
                                        : CustomTile(
                                            isActive: items[index].isActive,
                                            textTime: items[index]
                                                .waitTime
                                                .toString(),
                                            textLocation:
                                                items[index].location.locality,
                                          ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              extendBody: true,
              bottomNavigationBar: CustomHomeBottomNavBar(
                isAuctionPressed: true,
                isSearchPressed: false,
              )));
    });
  }
}
