class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> categoryIds;
  final DateTime updatedAt;
  final String? posterName;
  final String? posterImage;

  Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.categoryIds,
    required this.updatedAt,
    this.posterName,
    this.posterImage,
  });
}
