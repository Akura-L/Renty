class Car {
  final String id;
  final String name;
  final String location;
  final int year;
  final double price;
  final String imageUrl;

  const Car({
    required this.id,
    required this.name,
    required this.location,
    required this.year,
    required this.price,
    required this.imageUrl,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      year: json['year'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'year': year,
        'price': price,
        'imageUrl': imageUrl,
      };

  @override
  String toString() => 'Car(name: $name, price: $price)';
}
