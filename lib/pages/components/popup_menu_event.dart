// ignore_for_file: must_be_immutable, constant_identifier_names, use_build_context_synchronously

import 'package:events_control/pages/constants/constants.dart';
import 'package:events_control/providers/events_provider.dart';
import 'package:events_control/repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

enum Items { Edit, Delete }

class PopupMenuEvent extends StatelessWidget {
  final int id;
  PopupMenuEvent(this.id, {super.key});

  Items? selectedItem;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: selectedItem,
      color: Colors.teal[300],
      shadowColor: Colors.blueGrey[800],
      itemBuilder: (context) => <PopupMenuEntry<Items>>[
        PopupMenuItem<Items>(
            value: Items.values[0],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: Colors.teal[100],
                  size: 16.sp,
                ),
                Text(
                  'Editar',
                  style: Constants().menuItemStyle,
                ),
              ],
            )),
        PopupMenuItem<Items>(
          value: Items.values[1],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FaIcon(
                FontAwesomeIcons.trash,
                color: Colors.teal[100],
                size: 16.sp,
              ),
              Text(
                'Eliminar',
                style: Constants().menuItemStyle,
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) async {
        switch (value) {
          case Items.Delete:
            final int deletedPersons = await EventRepository().deleteEvent(id);
            if (deletedPersons > 0) {
              modifyListener(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Se eliminaron $deletedPersons personas'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Evento Inexistente'),
                ),
              );
            }
            break;
          case Items.Edit:
            break;
        }
      },
    );
  }

  void modifyListener(BuildContext context) {
    final dataNotifier = Provider.of<EventsProvider>(context, listen: false);
    dataNotifier.loadEvents();
  }
}
