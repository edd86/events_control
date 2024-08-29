import 'package:events_control/functions/date_time_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class EventDialog extends StatelessWidget {
  EventDialog({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Añadir evento',
        style: GoogleFonts.kanit(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 25.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                icon: const FaIcon(FontAwesomeIcons.letterboxd),
                label: Text(
                  'Nombre del evento',
                  style: GoogleFonts.kanit(fontSize: 15.sp),
                ),
              ),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                icon: const FaIcon(FontAwesomeIcons.mapLocation),
                label: Text(
                  'Ubicación',
                  style: GoogleFonts.kanit(fontSize: 15.sp),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    DateTimeFunctions().dateToString(DateTime.now()),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    DateTimeFunctions().timeToString(DateTime.now()),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Añadir'),
        ),
      ],
    );
  }
}
