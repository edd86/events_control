import 'package:events_control/data/database_helper.dart';
import 'package:events_control/models/event.dart';
import 'package:events_control/repository/person_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../models/attendance.dart';
import 'attendance_repository.dart';

class EventRepository {
  Future<Event> addEvent(Event event) async {
    final db = await DatabaseHelper().database;
    try {
      final id = await db.insert('events', event.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return event.copyWith(id: id);
    } catch (e) {
      return event;
    }
  }

  Future<List<Event>> getEvents() async {
    final db = await DatabaseHelper().database;
    var eventMaps = await db.query('events');
    List<Event> events = [];
    for (var eventMap in eventMaps) {
      events.add(Event.fromMap(eventMap));
    }
    return events;
  }

  Future<Event> updateEvent(Event event) async {
    final db = await DatabaseHelper().database;
    await db.update('events', event.toMap(),
        where: 'id = ?', whereArgs: [event.id]);
    return event;
  }

  Future<int> deleteEvent(int id) async {
    final db = await DatabaseHelper().database;
    int personsDeleted = 0;
    List<Attendance> attendancesFiltered =
        await AttendanceRepository().getAttendancesByEvent(id);
    if (attendancesFiltered.isNotEmpty) {
      for (var attendance in attendancesFiltered) {
        final personDeleted =
            await PersonRepository().deletePerson(attendance.personId);
        if (personDeleted != null) {
          personsDeleted++;
        }
      }
    }
    await db.delete('events', where: 'id = ?', whereArgs: [id]);
    return personsDeleted;
  }
}
