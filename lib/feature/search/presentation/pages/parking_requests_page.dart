import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:sparkz/core/global/_widgets/custom_tile.dart';
import 'package:sparkz/core/global/_widgets/custom_bottom_nav_bar.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';
import 'package:sparkz/di/inyector.dart';
import 'package:sparkz/feature/auction/domain/entity/location_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';

import 'package:sparkz/feature/auction/presentation/pages/list_auction_page.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_response_entity.dart';
import 'package:sparkz/feature/search/presentation/bloc/list_compatible_spots/list_compatible_spots_bloc.dart';
import 'package:sparkz/feature/search/presentation/widgets/custom_button_delete_search.dart';

import 'auction_invitations_page.dart';

class ParkingRequestsPage extends StatefulWidget {
  ParkingRequestsPage({Key? key, this.routeParams}) : super(key: key);
  final RouteParams? routeParams;

  @override
  _ParkingRequestsPageState createState() => _ParkingRequestsPageState();
}

class _ParkingRequestsPageState
    extends StateWithBloC<ParkingRequestsPage, ListCompatibleSpotsBloc> {
  bool showDetail = false;
  int detailIndex = 0;
  late AddUnparkedEntity compatibleSpots;
  late UserProfile _userProfile;
  late List<ListCompatibleSpotsResponseEntity> searchResult;
  @override
  void initState() {
    super.initState();
    _userProfile = (Injector.instance!.getDependency());

    compatibleSpots = (_userProfile.getUnparked() != null)
        ? _userProfile.getUnparked()!.first
        : AddUnparkedEntity(
            id: 0,
            brand: '',
            color: '',
            latitude: '',
            country: '',
            locality: '',
            longitude: '',
            model: '',
            plateNumber: '',
            size: '',
            state: '',
            timePeriodFrom: '2021-12-14T21:47:36.553729',
            timePeriodTo: '');
    searchResult = [];
    bloc?.add(ListCompatibleSpotsSentEvent(
        brand: compatibleSpots.brand,
        color: compatibleSpots.color,
        country: compatibleSpots.country,
        desiredSize: compatibleSpots.size,
        desiredTimeFrom: compatibleSpots.timePeriodFrom,
        desiredTimeTo: compatibleSpots.timePeriodTo ?? '',
        latitude: compatibleSpots.latitude,
        locality: compatibleSpots.locality,
        longitude: compatibleSpots.longitude,
        model: compatibleSpots.model,
        orderBy: "brand",
        orderDirection: "ASC",
        pageNumber: 1,
        pageSize: 100,
        plateNumber: compatibleSpots.plateNumber,
        state: compatibleSpots.state));
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size _sizeScreen = MediaQuery.of(context).size;
    final _appBarPreferredSize = _sizeScreen.height * 0.15;
    final _padding = MediaQuery.of(context).padding;
    return BlocConsumer<ListCompatibleSpotsBloc, ListCompatibleSpotsState>(
        listener: (context, state) {
      return;
    }, builder: (context, state) {
      return ModalProgressHUD(
          inAsyncCall: state is ListCompatibleSpotsSentState,
          child: Scaffold(
              backgroundColor: Color(0xFF2E3238),
              appBar: PreferredSize(
                  child: CustomAppBar(
                    leading: CustomUpperButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      icon: Icons.arrow_back,
                    ),
                    actions: [
                      Container(
                          width: _sizeScreen.width * 0.18,
                          child: DeleteSearchButton(
                              onHandleDelete: compatibleSpots.id ?? 0)),
                    ],
                    title: 'Parking Requests',
                  ),
                  preferredSize: Size(_sizeScreen.width, _appBarPreferredSize)),
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
                    (_sizeScreen.height - _appBarPreferredSize - _padding.top),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: StreamBuilder<
                              List<ListCompatibleSpotsResponseEntity>>(
                            stream: bloc?.subject.stream,
                            builder: (context,
                                AsyncSnapshot<
                                        List<ListCompatibleSpotsResponseEntity>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.length != 0) {
                                  searchResult = [];
                                  searchResult.addAll(snapshot.data!);
                                  return RefreshIndicator(
                                    onRefresh: _pullToRefresh,
                                    child: ListView.builder(
                                      itemCount: searchResult.length,
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            showDetail = !showDetail;
                                            detailIndex = index;
                                          });
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        AuctionInvitationsPage(
                                                          routeParams:
                                                              ParamsFromSearchAuction(
                                                                  ParkedEntity(
                                                                      searchResult[
                                                                              index]
                                                                          .id,
                                                                      searchResult[
                                                                              index]
                                                                          .locationId,
                                                                      '${searchResult[index].size}',
                                                                      searchResult[
                                                                              index]
                                                                          .waitTime,
                                                                      searchResult[
                                                                              index]
                                                                          .minimunBid,
                                                                      searchResult[
                                                                              index]
                                                                          .isActive,
                                                                      LocationEntity(
                                                                        searchResult[index]
                                                                            .locationId,
                                                                        '${searchResult[index].location.latitude}',
                                                                        '${searchResult[index].location.longitude}',
                                                                        '${searchResult[index].location.country}',
                                                                        '${searchResult[index].location.state}',
                                                                        '${searchResult[index].location.locality}',
                                                                      )),
                                                                  compatibleSpots
                                                                      .id!),
                                                        )));
                                          },
                                          child: CustomTile(
                                            isActive: false,
                                            textTime:
                                                '${searchResult[index].waitTime}',
                                            textLocation:
                                                '${searchResult[index].location.locality} ${searchResult[index].location.state} ${searchResult[index].location.country}',
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else
                                  return Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search_off,
                                            color: Colors.white60,
                                            size: 30,
                                          ),
                                          Text(
                                            'No results found',
                                            style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                              } else {
                                return Container(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search_off,
                                          color: Colors.white60,
                                          size: 30,
                                        ),
                                        Text(
                                          'No results found',
                                          style: TextStyle(
                                              color: Colors.white60,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
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
                isAuctionPressed: false,
                isSearchPressed: true,
              )));
    });
  }

  Future<Null> _pullToRefresh() async {
    bloc?.add(ListCompatibleSpotsSentEvent(
        brand: compatibleSpots.brand,
        color: compatibleSpots.color,
        country: compatibleSpots.country,
        desiredSize: compatibleSpots.size,
        desiredTimeFrom: compatibleSpots.timePeriodFrom,
        desiredTimeTo: compatibleSpots.timePeriodTo ?? '',
        latitude: compatibleSpots.latitude,
        locality: compatibleSpots.locality,
        longitude: compatibleSpots.longitude,
        model: compatibleSpots.model,
        orderBy: "brand",
        orderDirection: "ASC",
        pageNumber: 1,
        pageSize: 100,
        plateNumber: compatibleSpots.plateNumber,
        state: compatibleSpots.state));
  }
}
