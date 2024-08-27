import 'package:events_control/models/person.dart';
import 'package:sqflite/sqflite.dart';
import '../data/database_helper.dart';

///CRUD Operations for Person
///
///   APP => PERSON_REPOSITORY => DATABASE

class PersonRepository {
  Future<Person> addPerson(Person person) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert('people', person.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return person.copyWith(id: id);
  }

  Future<List<Person>> getPersons() async {
    final db = await DatabaseHelper().database;
    var personMaps = await db.query('people');
    List<Person> persons = [];
    personMaps.map((personMap) => persons.add(Person.fromMap(personMap)));
    return persons;
  }

  Future<Person> updatePerson(Person person) async {
    final db = await DatabaseHelper().database;
    await db
        .update('people', person.toMap(), where: 'id = ?', whereArgs: [person.id]);
    return person;
  }

  Future<Person> deletePerson(Person person) async {
    final db = await DatabaseHelper().database;
    await db.delete('people', where: 'id = ?', whereArgs: [person.id]);
    return person;
  }
}
