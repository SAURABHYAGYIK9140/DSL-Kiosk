class Professional {
  final int id;
  final String proName;
  final String proDesignation;
  final String proProfession;
  final String? image;
  final int rating;

  Professional({
    required this.id,
    required this.proName,
    required this.proDesignation,
    required this.proProfession,
    required this.image,
    required this.rating,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json['id'],
      proName: json['pro_name'],
      proDesignation: json['pro_designation'],
      proProfession: json['pro_profession'],
      image: json['image'],
      rating: json['rating'],
    );
  }
}
