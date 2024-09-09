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
      elevation: 7,
      shadowColor: Colors.blueGrey[800],
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
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              event.location,
              style: GoogleFonts.kanit(
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(
                  FontAwesomeIcons.solidCalendarDays,
                  size: 16.sp,
                ),
                Text(
                  DateTimeFunctions().dateToString(event.date),
                  style: GoogleFonts.kanit(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                FaIcon(
                  FontAwesomeIcons.clock,
                  size: 16.sp,
                ),
                Text(
                  DateTimeFunctions().timeToString(event.date),
                  style: GoogleFonts.kanit(
                    fontSize: 16.sp,
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
