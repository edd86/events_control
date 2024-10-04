// ignore_for_file: must_be_immutable, constant_identifier_names

import 'package:events_control/models/event.dart';
import 'package:events_control/pages/components/card_person.dart';
import 'package:events_control/pages/components/person_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../repository/attendance_repository.dart';

class PeoplePage extends StatefulWidget {
  Event event;
  PeoplePage(this.event, {super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

enum Status { Accepted, Registered }

class _PeoplePageState extends State<PeoplePage> {
  Status state = Status.Registered;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.event.name),
          backgroundColor: Colors.teal[300],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: SegmentedButton<Status>(
                segments: <ButtonSegment<Status>>[
                  ButtonSegment<Status>(
                    value: Status.Registered,
                    label: Text(
                      'Registrados',
                      style: GoogleFonts.kanit(fontSize: 12.sp),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.registered,
                      size: 13.sp,
                    ),
                  ),
                  ButtonSegment<Status>(
                    value: Status.Accepted,
                    label: Text(
                      'Aceptados',
                      style: GoogleFonts.kanit(fontSize: 12.sp),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.checkDouble,
                      size: 13.sp,
                    ),
                  ),
                ],
                selected: <Status>{state},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    state = newSelection.first;
                  });
                },
              ),
            ),
            const CardPerson()
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: FaIcon(
            FontAwesomeIcons.personCirclePlus,
            size: 19.sp,
          ),
          onPressed: () {
            /*showDialog(
              context: context,
              builder: (context) => PersonDialog(widget.event.id!),
            );*/
            showRegisters();
          },
        ),
      ),
    );
  }

  void showRegisters() async {
    final registers =
        await AttendanceRepository().getRegisters(widget.event.id!);
    for (var register in registers) {
      print(register.personId);
    }
    //registers.map((register) => print(register.personId));
  }
}
