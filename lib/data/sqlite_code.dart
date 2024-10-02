String eventsTable = '''
CREATE TABLE IF NOT EXISTS events (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT NOT NULL,
date TEXT NOT NULL,
location TEXT NOT NULL);
''';

String peopleTable = '''
CREATE TABLE IF NOT EXISTS people (
id INTEGER PRIMARY KEY AUTOINCREMENT,
fullName TEXT NOT NULL,
genre TEXT NOT NULL,
age INTEGER NOT NULL,
email TEXT NOT NULL,
phone TEXT NOT NULL);
''';

String attendanceTable = '''
CREATE TABLE IF NOT EXISTS attendances (
id INTEGER PRIMARY KEY AUTOINCREMENT,
date TEXT NOT NULL,
status INTEGER NOT NULL,
eventId INTEGER NOT NULL,
personId INTEGER NOT NULL,
FOREIGN KEY(eventId) REFERENCES events(id),
FOREIGN KEY(personId) REFERENCES people(id));
''';

String getEventsTable = '''
SELECT * FROM events;
''';
