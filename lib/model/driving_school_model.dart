import '../constant/url.dart';

class DrivingSchoolModel {
  final int id;
  final String userId;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String dateCreated;
  final String dateUpdated;
  final String profileImage;

  final double rating;
  final double distance;
  final int reviewCount;
  final int accredited;
  DrivingSchoolModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.dateCreated,
    required this.dateUpdated,
    required this.profileImage,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    required this.accredited,
  });

  factory DrivingSchoolModel.fromJson(Map<String, dynamic> json) {
    return DrivingSchoolModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      address: json['address'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      dateCreated: json['date_created'],
      dateUpdated: json['date_updated'],
      profileImage: WEBSITE_URL + json['profile_image'],
      rating: double.parse(json['rating'].toString()),
      reviewCount: int.parse(json['review_count'].toString()),
      distance: double.parse(json['distance'].toString()),
      accredited: int.parse(json['accreditation_status'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'date_created': dateCreated,
      'date_updated': dateUpdated,
      'profile_image': profileImage,
    };
  }
}
