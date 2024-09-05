class Event {
  final int? id;
  final String name;
  final DateTime date;
  final String location;

  Event({
    this.id,
    required this.name,
    required this.date,
    required this.location,
  });

  ///Method to copy the event with the new values
  ///to update the event in DB
  Event copyWith({
    int? id,
    String? name,
    DateTime? date,
    String? location,
  }){
    return Event(
      id: this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'location': location,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      location: map['location'],
    );
  }
}