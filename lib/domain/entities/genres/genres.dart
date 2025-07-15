class GenresEntity {
  final String id;
  final String name;
  final String image;
  final String description;
  final List<String> tag;

  GenresEntity({
    required this.name,
    required this.image,
    required this.id,
    required this.description,
    required this.tag,
  });
}
