import 'package:events_control/models/event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({required this.event, super.key});
  final Event event;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      color: Colors.teal[100],
      child: SizedBox(
        height: size.height * .2,
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
            SizedBox(height: size.height * .015),
            Text(
              event.location,
              style: GoogleFonts.kanit(),
            ),
            SizedBox(height: size.height * .025),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(
                  FontAwesomeIcons.solidCalendarDays,
                  size: 20,
                ),
                Text('25/01/2025'),
                FaIcon(
                  FontAwesomeIcons.clock,
                  size: 20,
                ),
                Text('10:00 AM'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
