import 'package:flutter/material.dart';
import 'package:sparkz/feature/car/presentation/pages/add_car_page.dart';

class CustomAddButton extends StatelessWidget {
  const CustomAddButton(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgorund_leading.png'),
            fit: BoxFit.fill,
          ),
        ),
        margin: EdgeInsets.only(right: 5),
        child: IconButton(
          onPressed: () {
            //temporal
             Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                AddCarPage()));
                                  
            
          },
          padding: EdgeInsets.all(32),
          iconSize: 30,
          icon: Image.asset('assets/images/add_plus_orange.png'),
        ));
  }
}
