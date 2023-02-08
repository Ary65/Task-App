// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int id;
  final String caption;
  final String createdAt;
  final String videoUrl;

  UserModel({
    required this.id,
    required this.caption,
    required this.createdAt,
    required this.videoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      caption: json['caption'],
      createdAt: json['created_at'] ?? 'created_at',
      videoUrl: json['video_url'] ?? 'video_url',
    );
  }
}
