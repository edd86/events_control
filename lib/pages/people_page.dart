// ignore_for_file: must_be_immutable, constant_identifier_names

import 'package:events_control/models/event.dart';
import 'package:events_control/pages/components/card_person.dart';
import 'package:events_control/pages/components/person_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../repository/attendance_repository.dart';
import 'constants/constants.dart';

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
                      'Asistentes',
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
            state == Status.Registered
                ? Expanded(
                    child: FutureBuilder(
                      future: AttendanceRepository()
                          .getRegisters(widget.event.id!, false),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final register = snapshot.data![index];
                              return CardPerson(
                                register: register,
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'No hay registros de personas',
                              style: Constants().labelStyle,
                            ),
                          );
                        }
                      },
                    ),
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: AttendanceRepository()
                          .getRegisters(widget.event.id!, true),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        }
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final register = snapshot.data![index];
                              return CardPerson(
                                register: register,
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              'No hay registros de Asistentes',
                              style: Constants().labelStyle,
                            ),
                          );
                        }
                      },
                    ),
                  )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: FaIcon(
            FontAwesomeIcons.personCirclePlus,
            size: 19.sp,
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => PersonDialog(widget.event.id!),
            );
            setState(() {});
          },
        ),
      ),
    );
  }
}
