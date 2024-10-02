// ignore_for_file: use_build_context_synchronously

import 'package:events_control/models/attendance.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../models/person.dart';
import '../../repository/attendance_repository.dart';
import '../../repository/person_repository.dart';
import '../constants/constants.dart';

final TextEditingController fullNameController = TextEditingController();
final TextEditingController genderController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();

class PersonDialog extends StatelessWidget {
  final int eventId;
  const PersonDialog(this.eventId, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const FaIcon(FontAwesomeIcons.person),
      title: Text(
        'Agregar Persona',
        style: Constants().dialogTitleStyle,
      ),
      content: SizedBox(
        height: 30.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                label: Text(
                  'Nombre Completo',
                  style: Constants().labelStyle,
                ),
              ),
              style: Constants().textFieldStyle,
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text(
                  'Correo Electrónico',
                  style: Constants().labelStyle,
                ),
              ),
              style: Constants().textFieldStyle,
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                label: Text(
                  'Teléfono',
                  style: Constants().labelStyle,
                ),
              ),
              style: Constants().textFieldStyle,
              keyboardType: TextInputType.phone,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30.w,
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      label: Text(
                        'Edad',
                        style: Constants().labelStyle,
                      ),
                    ),
                    style: Constants().textFieldStyle,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                SizedBox(
                  width: 30.w,
                  child: TextField(
                    controller: genderController,
                    decoration: InputDecoration(
                      label: Text(
                        'Género',
                        style: Constants().labelStyle,
                      ),
                    ),
                    style: Constants().textFieldStyle,
                    keyboardType: TextInputType.text,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancelar',
            style: Constants().labelStyle,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            'Añadir',
            style: Constants().labelStyle,
          ),
          onPressed: () async {
            if (validateTextEditingControllers()) {
              final person = Person(
                fullName: fullNameController.text,
                email: emailController.text,
                phone: phoneController.text,
                age: int.parse(ageController.text),
                genre: genderController.text,
              );
              final personRepository = PersonRepository();
              final personAdded = await personRepository.addPerson(person);

              /// va a tener id o no
              if (personAdded.id != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Persona Registrada'),
                  ),
                );
                Attendance attendance = Attendance(
                  date: DateTime.now(),
                  status: 0,
                  eventId: eventId,
                  personId: personAdded.id!,
                );
                final attendanceRepository = AttendanceRepository();
                final attendanceRegistered =
                    await attendanceRepository.addAttendance(attendance);
                if (attendanceRegistered.id != null) {
                  cleanTextEditingControllers(
                    fullNameController,
                    emailController,
                    phoneController,
                    ageController,
                    genderController,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Persona registrada en el Evento'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Error al registrar la persona en el Evento'),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Persona no Registrada'),
                  ),
                );
              }
            }
          },
        ),
      ],
    );
  }

  bool validateTextEditingControllers() {
    bool valid = false;
    if (fullNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        genderController.text.isNotEmpty) {
      valid = true;
    }
    return valid;
  }

  void cleanTextEditingControllers(
      TextEditingController fullNameController,
      TextEditingController emailController,
      TextEditingController phoneController,
      TextEditingController ageController,
      TextEditingController genderController) {
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    ageController.clear();
    genderController.clear();
  }
}
