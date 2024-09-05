import 'package:events_control/pages/components/card_event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../repository/event_repository.dart';
import 'components/event_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: GoogleFonts.kanit(
            fontSize: 25,
            color: Colors.black,
          ),
          elevation: 5,
          shadowColor: Colors.grey,
          title: const Text(
            'Eventos',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),

        ///FutureBuilder to get the events from the database
        ///Provider to get the events from the database
        body: FutureBuilder(
          future: EventRepository().getEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No hay eventos registrados',
                    style: GoogleFonts.kanit(
                      fontSize: 15.sp,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data![index];
                  return CardEvent(event: event);
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error al obtener eventos',
                  style: GoogleFonts.kanit(
                    fontSize: 15.sp,
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const FaIcon(FontAwesomeIcons.calendarPlus),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => EventDialog(),
            );
          },
        ),
      ),
    );
  }
}
