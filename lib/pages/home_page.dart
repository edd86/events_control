import 'package:events_control/pages/components/card_event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../providers/events_provider.dart';
import 'components/event_dialog.dart';
import 'people_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: GoogleFonts.kanit(
            fontSize: 25,
            color: Colors.black,
            shadows: [
              const Shadow(
                offset: Offset(0, 0.5),
                blurRadius: 0.5,
                color: Colors.grey,
              ),
            ],
          ),
          elevation: 5,
          shadowColor: Colors.grey,
          title: const Text(
            'Eventos',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Edward Cristobal Diaz Valda'),
            )
          ],
        ),
        body: Consumer<EventsProvider>(
          builder: (context, dataprovider, child) {
            final events = dataprovider.events;
            if (events.isEmpty) {
              return Center(
                child: Text(
                  'No hay eventos registrados.',
                  style: GoogleFonts.kanit(fontSize: 17.sp),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return GestureDetector(
                    child: CardEvent(
                      event: event,
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PeoplePage(event),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          tooltip: 'Añadir evento',
          child: const FaIcon(FontAwesomeIcons.calendarPlus),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const EventDialog(),
            );
          },
        ),
      ),
    );
  }
}
