import 'package:events_control/functions/date_time_functions.dart';
import 'package:events_control/models/event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({required this.event, super.key});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal[100],
      child: SizedBox(
        height: 20.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              event.name,
              style: GoogleFonts.kanit(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              event.location,
              style: GoogleFonts.kanit(),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(
                  FontAwesomeIcons.solidCalendarDays,
                  size: 2.h,
                ),
                Text(
                  DateTimeFunctions().dateToString(event.date),
                  style: GoogleFonts.kanit(
                    fontSize: 15,
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.clock,
                  size: 2.h,
                ),
                Text(
                  DateTimeFunctions().timeToString(event.date),
                  style: GoogleFonts.kanit(
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
