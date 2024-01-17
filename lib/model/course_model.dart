import '../constant/url.dart';

class CourseModel {
  final String id;
  final String schoolId;
  final String name;
  final String thumbnail;
  final String status;
  final int type;
  final List<dynamic> variants;
  final String description;
  final String dateCreated;
  final String dateUpdated;
  final double rating;
  final int reviewCount;
  int selectedVariant = 0;
  CourseModel({
    required this.id,
    required this.schoolId,
    required this.name,
    required this.thumbnail,
    required this.status,
    required this.type,
    required this.variants,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.dateCreated,
    required this.dateUpdated,
  });
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      schoolId: json['school_id'],
      name: json['name'],
      thumbnail: WEBSITE_URL + json['thumbnail'],
      status: json['status'].toString(),
      description: json['description'].toString(),
      variants: json['variants'],
      type: int.parse(json['type'].toString()),
      rating: double.parse(json['rating'].toString()),
      reviewCount: int.parse(json['review_count'].toString()),
      dateCreated: json['date_created'],
      dateUpdated: json['date_updated'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'name': name,
      'thumbnail': thumbnail,
      'status': status,
      'description': description,
      'date_created': dateCreated,
      'date_updated': dateUpdated,
    };
  }
}
