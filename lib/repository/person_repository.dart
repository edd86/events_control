import 'package:events_control/models/person.dart';
import 'package:sqflite/sqflite.dart';
import '../data/database_helper.dart';

///CRUD Operations for Person
///
///   APP => PERSON_REPOSITORY => DATABASE

class PersonRepository {
  Future<Person> addPerson(Person person) async {
    final db = await DatabaseHelper().database;
    try {
      final id = await db.insert('people', person.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return person.copyWith(id: id);

      ///Tiene id
    } catch (e) {
      return person;

      ///No tiene id
    }
  }

  Future<List<Person>> getPersons() async {
    final db = await DatabaseHelper().database;
    try {
      var personMaps = await db.query('people');
      List<Person> persons = [];
      personMaps.map((personMap) => persons.add(Person.fromMap(personMap)));
      return persons;
    } catch (e) {
      return [];
    }
  }

  Future<Person?> updatePerson(Person person) async {
    try {
      final db = await DatabaseHelper().database;
      await db.update('people', person.toMap(),
          where: 'id = ?', whereArgs: [person.id]);
      return person;
    } catch (e) {
      return null;
    }
  }

  Future<Person?> deletePerson(Person person) async {
    try {
      final db = await DatabaseHelper().database;
      await db.delete('people', where: 'id = ?', whereArgs: [person.id]);
      return person;
    } catch (e) {
      return null;
    }
  }

  Future<Person?> getPersonById(int personId) async {
    try {
      final db = await DatabaseHelper().database;
      var personMaps = await db.query(
        'people',
        where: 'id = ?',
        whereArgs: [personId],
      );
      Person person = Person.fromMap(personMaps.first);
      return person;
    } catch (e) {
      return null;
    }
  }
}
