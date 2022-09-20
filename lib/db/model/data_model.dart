import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String domain;
  @HiveField(5)
  final String photo;

  StudentModel(
      {required this.name,
      required this.id,
      required this.age,
      required this.phone,
      required this.domain,
      required this.photo});
}
