import 'package:events_control/functions/date_time_functions.dart';
import 'package:events_control/models/event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../providers/events_provider.dart';
import '../../repository/event_repository.dart';
import '../constants/constants.dart';

class EventDialog extends StatefulWidget {
  const EventDialog({super.key});

  @override
  State<EventDialog> createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final googleStyle = GoogleFonts.kanit(fontSize: 15.sp);
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Añadir evento',
        style: Constants().dialogTitleStyle,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 25.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: nameController,
              style: googleStyle,
              decoration: InputDecoration(
                icon: const FaIcon(FontAwesomeIcons.letterboxd),
                label: Text(
                  'Nombre del evento',
                  style: googleStyle,
                ),
              ),
            ),
            TextField(
              controller: locationController,
              style: googleStyle,
              decoration: InputDecoration(
                icon: const FaIcon(FontAwesomeIcons.mapLocation),
                label: Text(
                  'Ubicación',
                  style: googleStyle,
                ),
              ),
            ),
            TextButton(
              child: Text(
                '${DateTimeFunctions().dateToString(now)} ${DateTimeFunctions().timeToString(now)}',
                style: googleStyle,
              ),
              onPressed: () async {
                final DateTime? newDate = await showOmniDateTimePicker(
                  context: context,
                  is24HourMode: true,
                  firstDate: now,
                  initialDate: now,
                );
                if (newDate != null) {
                  changeDateState(newDate);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancelar',
            style: googleStyle,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            'Añadir',
            style: googleStyle,
          ),
          onPressed: () async {
            String name = nameController.text;
            String location = locationController.text;
            Event event = Event(
              name: name,
              location: location,
              date: now,
            );
            await EventRepository().addEvent(event);
            modifyListener();
            backPage();
          },
        ),
      ],
    );
  }

  void changeDateState(DateTime newDate) {
    setState(() {
      now = newDate;
    });
  }

  void modifyListener() {
    final dataNotifier = Provider.of<EventsProvider>(context, listen: false);
    dataNotifier.loadEvents();
  }

  void backPage() {
    Navigator.pop(context);
  }
}
