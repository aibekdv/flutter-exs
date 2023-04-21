class Student {
  Student({
    required this.id,
    required this.name,
    required this.surName,
    required this.age,
    this.phone,
    required this.email,
    this.address,
    required this.group,
    required this.gender,
    this.marrige,
  });
  final int id;
  final String name;
  final String surName;
  final int age;
  String? phone;
  final String email;
  final String? address;
  int group;
  final String gender;
  String? marrige;
}

final daniyar = Student(
  id: 1,
  name: "Daniyar",
  surName: "Askarov",
  age: 20,
  phone: "0707770077",
  email: "d.a.gmail.com",
  address: "Osh",
  group: 1,
  gender: "male",
  marrige: "single",
);

final dinara = Student(
  id: 2,
  name: "Dinara",
  surName: "Nurbaeva",
  age: 30,
  phone: "0707774531",
  email: "d.n.gmail.com",
  address: "Talas",
  group: 1,
  gender: "female",
  marrige: "married",
);

final hanzada = Student(
  id: 3,
  name: "Hanzada",
  surName: "Nuralieva",
  age: 22,
  phone: "0777124456",
  email: "h.n.gmail.com",
  address: "Bishkek",
  group: 1,
  gender: "female",
  marrige: "single",
);

final mirbek = Student(
  id: 4,
  name: "Mirbek",
  surName: "Alymbekov",
  age: 26,
  phone: "0550987784",
  email: "m.a.gmail.com",
  address: "Jalal-Abad",
  group: 1,
  gender: "male",
  marrige: "married",
);

final aybek = Student(
  id: 5,
  name: "Aybek",
  surName: "Borubaev",
  age: 28,
  phone: "0220991434",
  email: "Aybek@gmail.com",
  address: "Batken",

  group: 1,
  gender: "male",
  marrige: "single",
);


