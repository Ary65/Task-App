// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskDataModel {
  final int id;
  final String caption;
  final String createdAt;
  final String videoUrl;

  TaskDataModel({
    required this.id,
    required this.caption,
    required this.createdAt,
    required this.videoUrl,
  });

  factory TaskDataModel.fromJson(Map<String, dynamic> json) {
    return TaskDataModel(
      id: json['id'],
      caption: json['caption'],
      createdAt: json['created_at'] ?? 'created_at',
      videoUrl: json['video_url'] ?? 'video_url',
    );
  }
}
