import 'package:events_control/data/database_helper.dart';
import 'package:events_control/models/event.dart';
import 'package:sqflite/sqflite.dart';

class EventRepository {
  Future<Event> addEvent(Event event) async {
    final db = await DatabaseHelper().database;
    try {
      final id = await db.insert('events', event.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return event.copyWith(id: id);
    } catch (e) {
      print(e);
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

  Future<bool> deleteEvent(int id) async {
    bool deleted = false;
    final db = await DatabaseHelper().database;
    int eventDeleted =
        await db.delete('events', where: 'id = ?', whereArgs: [id]);
    if (eventDeleted > 0) {
      deleted = true;
    }
    return deleted;
  }
}
