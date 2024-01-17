import '../constant/url.dart';

class AvailedCourseModel {
  final String id;
  final String studentId;
  final String courseId;
  final String schoolId;
  final String createdBy;
  final double price;
  final double duration;
  final int paymentType;
  final int session;
  final int status;
  final String dateCreated;
  final String thumbnail;
  final String name;
  AvailedCourseModel({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.schoolId,
    required this.createdBy,
    required this.price,
    required this.duration,
    required this.paymentType,
    required this.session,
    required this.status,
    required this.dateCreated,
    required this.thumbnail,
    required this.name,
  });
  factory AvailedCourseModel.fromJson(Map<String, dynamic> json) {
    return AvailedCourseModel(
      id: json['id'],
      studentId: json['student_id'],
      courseId: json['course_id'],
      schoolId: json['school_id'],
      createdBy: json['created_by'] as String,
      price: double.parse(json['price'].toString()),
      duration: double.parse(json['duration'].toString()),
      paymentType: int.parse(json['payment_type'].toString()),
      session: int.parse(json['session'].toString()),
      status: int.parse(json['status'].toString()),
      dateCreated: json['date_created'],
      thumbnail: WEBSITE_URL + json['thumbnail'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'course_id': courseId,
      'school_id': schoolId,
      'created_by': createdBy,
      'price': price,
      'duration': duration,
      'payment_type': paymentType,
      'session': session,
      'status': status,
      'date_created': dateCreated,
      'thumbnail': thumbnail,
      'name': name,
    };
  }
}
