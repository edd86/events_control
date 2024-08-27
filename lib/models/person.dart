class Person {
  final int? id;
  final String fullName;
  final String genre;
  final int age;
  final String email;
  final String phone;

  Person({
    this.id,
    required this.fullName,
    required this.genre,
    required this.age,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'genre': genre,
      'age': age,
      'email': email,
      'phone': phone,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      fullName: map['fullName'],
      genre: map['genre'],
      age: map['age'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  Person copyWith({
    int? id,
    String? fullName,
    String? genre,
    int? age,
    String? email,
    String? phone,
  }){
    return Person(
      id: this.id,
      fullName: fullName ?? this.fullName,
      genre: genre ?? this.genre,
      age: age ?? this.age,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
