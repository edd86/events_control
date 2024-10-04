import 'package:events_control/pages/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class CardPerson extends StatefulWidget {
  const CardPerson({super.key});

  @override
  State<CardPerson> createState() => _CardPersonState();
}

class _CardPersonState extends State<CardPerson> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal[100],
      elevation: 5,
      shadowColor: Colors.blueGrey[800],
      child: SizedBox(
        height: 7.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(
              FontAwesomeIcons.userTag,
              size: 20.sp,
              color: Colors.teal[300],
            ),
            SizedBox(
              width: 60.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Nombre de la persona',
                    style: Constants().labelStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fecha de registro',
                        style: Constants().textSubtitleStyle,
                      ),
                      Text(
                        'Teléfono',
                        style: Constants().textSubtitleStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Checkbox(value: false, onChanged: (value) {})
          ],
        ),
      ),
    );
  }
}
