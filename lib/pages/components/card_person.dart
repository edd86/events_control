import 'package:events_control/functions/date_time_functions.dart';
import 'package:events_control/pages/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../models/registers.dart';

class CardPerson extends StatefulWidget {
  final Registers register;
  const CardPerson({required this.register, super.key});

  @override
  State<CardPerson> createState() => _CardPersonState();
}

class _CardPersonState extends State<CardPerson> {
  bool status = false;

  @override
  void initState() {
    super.initState();
    status = widget.register.status == 1 ? true : false;
  }

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
                    widget.register.fullName,
                    style: Constants().labelStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateTimeFunctions().dateToString(widget.register.date),
                        style: Constants().textSubtitleStyle,
                      ),
                      Text(
                        widget.register.phone,
                        style: Constants().textSubtitleStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Checkbox(
              value: status,
              activeColor: Colors.teal[300],
              onChanged: (value) {
                setState(() {
                  status = value!;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
