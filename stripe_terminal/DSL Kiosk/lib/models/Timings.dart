class Timings {
  final int  id;
  final String slot;
  final String date;

  Timings({
    required this.id,
    required this.slot,
    required this.date,
  });

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      id: json['id'],
      slot: json['slot'],
      date: json['date'],
    );
  }
}
