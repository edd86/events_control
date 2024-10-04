class Registers {
  final int personId;
  final int eventId;
  final DateTime date;
  final int status;
  final String fullName;
  final String phone;

  Registers({
    required this.personId,
    required this.eventId,
    required this.date,
    required this.status,
    required this.fullName,
    required this.phone,
  });

  Registers copyWith({
    int? personId,
    int? eventId,
    DateTime? date,
    int? status,
    String? fullName,
    String? phone,
  }) {
    return Registers(
      personId: personId ?? this.personId,
      eventId: eventId ?? this.eventId,
      date: date ?? this.date,
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
    );
  }
}
