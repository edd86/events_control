import 'package:events_control/data/database_helper.dart';
import 'package:events_control/models/event.dart';
import 'package:sqflite/sqflite.dart';

class EventRepository {
  Future<Event> addEvent(Event event) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert('event', event.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return event.copyWith(id: id);
  }

  Future<List<Event>> getEvents() async {
    final db = await DatabaseHelper().database;
    var eventMaps = await db.query('events');

    ///{
    ///  "id": 1,
    ///  "name": "Event 1",
    ///  "date": "2023-01-01 T00:00:00.000Z",
    ///  "location": "Location 1"
    ///} {
    ///  "id": 2,
    ///  "name": "Event 2",
    ///  "date": "2023-01-02 T00:00:00.000Z",
    ///  "location": "Location 2"
    ///}
    ///
    List<Event> events = [];
    for (var eventMap in eventMaps) {
      events.add(Event.fromMap(eventMap));
    }
    return events;
  }

  Future<Event> updateEvent(Event event) async {
    final db = await DatabaseHelper().database;
    await db
        .update('event', event.toMap(), where: 'id = ?', whereArgs: [event.id]);
    return event;
  }

  Future<Event> deleteEvent(Event event) async {
    final db = await DatabaseHelper().database;
    await db.delete('event', where: 'id = ?', whereArgs: [event.id]);
    return event;
  }
}
