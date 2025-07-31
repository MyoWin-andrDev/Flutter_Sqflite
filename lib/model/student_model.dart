class StudentModel {
  static Map<String, dynamic> insertStudent({
    required String name,
    required String email,
    required String address,
    required String phone,
  }) {
    return {'name': name, 'email': email, 'address': address, 'phone': phone};
  }
}
