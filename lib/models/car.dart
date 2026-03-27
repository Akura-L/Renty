class Car {
  final String id;
  final String name;
  final String subName;
  final String location;
  final String exactLocation;
  final int year;
  final double price;
  final String imageUrl;
  final String category;

  // --- UI details (optional, used by the PDF-matching wireframe) ---
  final double rating;
  final int reviewCount;
  final bool topRated;
  final bool featured;
  final bool luxury;
  final bool availableToday;
  final List<String> specs;
  final String about;
  final List<CarReview> reviews;

  const Car({
    required this.id,
    required this.name,
    this.subName = '',
    required this.location,
    this.exactLocation = '',
    required this.year,
    required this.price,
    required this.imageUrl,
    this.category = 'All',
    this.rating = 4.8,
    this.reviewCount = 100,
    this.topRated = false,
    this.featured = false,
    this.luxury = false,
    this.availableToday = true,
    this.specs = const [],
    this.about = '',
    this.reviews = const [],
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      subName: json['subName'] ?? '',
      location: json['location'] ?? '',
      exactLocation: json['exactLocation'] ?? '',
      year: json['year'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? 'All',
      rating: (json['rating'] ?? 4.8).toDouble(),
      reviewCount: json['reviewCount'] ?? 100,
      topRated: json['topRated'] ?? false,
      featured: json['featured'] ?? false,
      luxury: json['luxury'] ?? false,
      availableToday: json['availableToday'] ?? true,
      specs: (json['specs'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      about: json['about'] ?? '',
      reviews: (json['reviews'] as List<dynamic>? ?? const [])
          .map((e) => CarReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subName': subName,
        'location': location,
        'exactLocation': exactLocation,
        'year': year,
        'price': price,
        'imageUrl': imageUrl,
        'category': category,
        'rating': rating,
        'reviewCount': reviewCount,
        'topRated': topRated,
        'featured': featured,
        'luxury': luxury,
        'availableToday': availableToday,
        'specs': specs,
        'about': about,
        'reviews': reviews.map((r) => r.toJson()).toList(),
      };

  @override
  String toString() => 'Car(name: $name, price: $price)';
}

class CarReview {
  final String initials;
  final String text;
  final String name;
  final String monthYear;

  const CarReview({
    required this.initials,
    required this.text,
    required this.name,
    required this.monthYear,
  });

  factory CarReview.fromJson(Map<String, dynamic> json) {
    return CarReview(
      initials: json['initials']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      monthYear: json['monthYear']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'initials': initials,
        'text': text,
        'name': name,
        'monthYear': monthYear,
      };
}
