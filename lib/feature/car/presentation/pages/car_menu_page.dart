import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_card_car.dart';
import 'package:sparkz/core/global/_widgets/custom_detail_car.dart';

import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';

import 'package:sparkz/feature/car/domain/entity/car_entity_list.dart';
import 'package:sparkz/feature/car/presentation/bloc/list_car/list_car_bloc.dart';
import 'package:sparkz/feature/car/presentation/pages/edit_car_page.dart';
import 'package:sparkz/feature/car/data/datasource/size_enums.dart';

import 'add_car_page.dart';

class CarMenuPage extends StatefulWidget {
  const CarMenuPage({Key? key}) : super(key: key);

  @override
  _CarMenuPageState createState() => _CarMenuPageState();
}

class _CarMenuPageState extends StateWithBloC<CarMenuPage, ListCarBloc> {
  late List<CarEntityList> cars;
  SizesEnums sizesEnums = new SizesEnums();

  bool showDetail = false;
  int detailIntex = 0;

  @override
  void initState() {
    super.initState();
    cars = [];
    bloc?.add(ListCarSentEvent("brand", "ASC", 1, 100));
  }

  final keyForm = GlobalKey<FormState>();
  @override
  Widget buildWidget(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding;
    final _appBarPreferredSize = _screenSize.height * 0.15;
    return BlocConsumer<ListCarBloc, ListCarState>(listener: (context, state) {
      return;
    }, builder: (context, state) {
      return ModalProgressHUD(
          inAsyncCall: state is ListCarSentState,
          child: Scaffold(
              backgroundColor:   Color(0xFF34393F),
              resizeToAvoidBottomInset: true,
              appBar: PreferredSize(
                child:Container(
                 margin: EdgeInsets.only(right:50.0),

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

                        width: _screenSize.width * 0.18,
                        child: CustomUpperButton(

                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddCarPage()));
                          },
                          isLeading: false,
                          icon: Icons.add,
                        ),
                      ),
                    ],
                    title: 'My Car List',
                  ),),
                  preferredSize: Size(_screenSize.width, _appBarPreferredSize)),
              body: StreamBuilder<List<CarEntityList>>(
                stream: bloc?.subject.stream,
                builder:
                    (contetx, AsyncSnapshot<List<CarEntityList>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length != 0) {
                      cars = [];
                      cars.addAll(snapshot.data!);
                      return Container(
                        height: (_screenSize.height -
                            _appBarPreferredSize -
                            _padding.top),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color(0xFF34393F),
                              Color(0xFF1B1C20),
                            ])),
                        child: ListView.builder(
                          itemCount: cars.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                showDetail = !showDetail;
                                detailIntex = index;
                              });
                            },
                            highlightColor: Colors.transparent,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            child: showDetail && detailIntex == index
                                ? CustomDetailCard(
                                    title: "Car ${index + 1}",
                                    cardBran: cars[index].carBrand,
                                    cardModel: cars[index].carModel,
                                    cardSize: sizesEnums
                                        .getValueInMap(cars[index].carSizeType),
                                    plateNumber: cars[index].carPlateNumber,
                                    carColor: cars[index].carColor,
                                    onHandleEdit: () {
                                      final entity = cars[index];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => EditCarPage(
                                                    routeParams:
                                                        ParamsFromListCar(
                                                            entity),
                                                  )));
                                    },
                                    onHandleDelete: cars[index].id,
                                  )
                                : CustomCardCar(
                                    carId: cars[index].carId,
                                    title: "Car ${index + 1}",
                                    cardBran: cars[index].carBrand,
                                    cardModel: cars[index].carModel,
                                    cardSize: sizesEnums
                                        .getValueInMap(cars[index].carSizeType),
                                    plateNumber: cars[index].carPlateNumber,
                                    isSwitched: cars[index].isActive,
                                    carColor: cars[index].carColor),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: (_screenSize.height -
                            _appBarPreferredSize -
                            _padding.top),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color(0xFF34393F),
                              Color(0xFF1B1C20),
                            ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: _screenSize.height * 0.05),
                            Image.asset(
                              "assets/images/no_car_added.png",
                            ),
                            Text(
                              "Your car list is empty, please add one",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16.0,
                                color: Color(0xFFC0C1C2),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    return Container(
                      height: (_screenSize.height -
                          _appBarPreferredSize -
                          _padding.top),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color(0xFF34393F),
                            Color(0xFF1B1C20),
                          ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/no_car_added.png"),
                          Text(
                            "Your car list is empty, please add one",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16.0,
                              color: Color(0xFFC0C1C2),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )));
    });
  }
}
