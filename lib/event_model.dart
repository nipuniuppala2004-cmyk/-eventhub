class Event {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final DateTime dateTime;
  final String location;
  final String category;
  final double price;
  final int availableSeats;

  Event({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.category,
    required this.price,
    required this.availableSeats,
  });
}