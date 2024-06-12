class User {
  static int id = 0;
  static String email = '';
  static String birthDate = '';
  static String phoneNumber = '';
  static String password = ''; //todo как его хранить то?
  static String firstName = '';
  static String lastName = '';
  static Sex sex = Sex.MALE;
}

enum Sex {
  MALE("Мужчина"),
  FEMALE("Женщина");

  final String sex;
  const Sex(this.sex);
}
