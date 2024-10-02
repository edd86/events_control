import 'package:events_control/models/attendance.dart';
import 'package:sqflite/sql.dart';
import '../data/database_helper.dart';

class AttendanceRepository {
  Future<Attendance> addAttendance(Attendance attendance) async {
    final db = await DatabaseHelper().database;
    try {
      final id = await db.insert('attendances', attendance.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return attendance.copyWith(id: id);
    } catch (e) {
      return attendance;
    }
  }

  Future<List<Attendance>> getAttendances() async {
    final db = await DatabaseHelper().database;
    try {
      var attendanceMaps = await db.query('attendances');
      List<Attendance> attendances = [];
      attendanceMaps.map((attendanceMap) =>
          attendances.add(Attendance.fromMap(attendanceMap)));
      return attendances;
    } catch (e) {
      return [];
    }
  }

  Future<Attendance?> updateAttendance(Attendance attendance) async {
    try {
      final db = await DatabaseHelper().database;
      await db.update('attendances', attendance.toMap(),
          where: 'id = ?', whereArgs: [attendance.id]);
      return attendance;
    } catch (e) {
      return null;
    }
  }

  Future<Attendance?> deleteAttendance(Attendance attendance) async {
    try {
      final db = await DatabaseHelper().database;
      await db
          .delete('attendances', where: 'id = ?', whereArgs: [attendance.id]);
      return attendance;
    } catch (e) {
      return null;
    }
  }
}
