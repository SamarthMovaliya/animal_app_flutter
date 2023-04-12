class Animal_Modal {
  final String name;
  final String loction;
  final String average_litter_size;
  final String color;
  final String skin_type;
  final String lifespan;
  final String type;
  final String diet;

  Animal_Modal(
      {required this.name,
        required this.color,
        required this.average_litter_size,
        required this.loction,
        required this.skin_type,
        required this.lifespan,
        required this.type,
        required this.diet});

  factory Animal_Modal.fromMap({required Map data}) {
    print("-------------------------------");
    print(data);
    print("-------------------------------");

    Animal_Modal a1 = Animal_Modal(
        name: data['name'],
        color: data['color'],
        average_litter_size: data['average_litter_size'],
        loction: data['loction'],
        skin_type: data['skin_type'],
        lifespan: data['lifespan'],
        type: data['type'],
        diet: data['diet']);

    print(a1.name);
    print(a1.color);
    print(a1.average_litter_size);
    print(a1.loction);
    print(a1.skin_type);
    print(a1.lifespan);
    print(a1.type);
    print(a1.diet);

    return a1;
  }
}