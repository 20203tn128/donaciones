class Annexes {
  String? commentary;
  List<String>? photos;

  Annexes({
    this.commentary,
    this.photos,
  });

  static Annexes fromMap(Map<String, dynamic> map) {
    final anex = Annexes(
      commentary: map['commentary'],
      photos: map['photos']?.whereType<String>().toList(),
    );
    return anex;
  }

  Map<String, dynamic> toMap() => {
        'commentary': commentary,
        'photos': photos,
      };
}
