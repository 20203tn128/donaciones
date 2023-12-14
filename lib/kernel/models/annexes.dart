class Annexes {
  String? commentary;
  List<String>? photos;

  Annexes({
    this.commentary,
    this.photos,
  });

  static Annexes fromMap(Map<String, dynamic> map) {
    print('Esto es un mapa');
    print(map);
    final anex = Annexes(
      commentary: map['commentary'],
      photos: map['photos']?.whereType<String>().toList(),
    );
    print('esto es despues de mapa');
    print(anex.toMap());
    return anex;
  }

  Map<String, dynamic> toMap() => {
        'commentary': commentary,
        'photos': photos,
      };
}
