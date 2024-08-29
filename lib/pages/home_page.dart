import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
        //TODO: FutureBuilder to get the events from DB
        body: Container(
          color: Colors.red,
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
