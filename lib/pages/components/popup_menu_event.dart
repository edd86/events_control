// ignore_for_file: must_be_immutable, constant_identifier_names

import 'package:events_control/pages/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      onSelected: (value) {
        print('value $id');
      },
    );
  }
}
