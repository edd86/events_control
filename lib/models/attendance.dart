class Attendance {
  final int? id;
  final DateTime date;
  final int status;
  final int eventId;
  final int personId;

  Attendance({
    this.id,
    required this.date,
    required this.status,
    required this.eventId,
    required this.personId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'status': status,
      'eventId': eventId,
      'personId': personId,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'],
      date: DateTime.parse(map['date']),
      status: map['status'],
      eventId: map['eventId'],
      personId: map['personId'],
    );
  }

  Attendance copyWith({
    int? id,
    DateTime? date,
    int? status,
    int? eventId,
    int? personId,
  }) {
    return Attendance(
      id: id ??this.id,
      date: date ?? this.date,
      status: status ?? this.status,
      eventId: eventId ?? this.eventId,
      personId: personId ?? this.personId,
    );
  }
}
