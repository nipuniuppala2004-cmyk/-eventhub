import 'event_model.dart';

List<Event> mockEvents = [
  Event(
    id: '1',
    name: 'Colombo Music Festival',
    imageUrl: 'https://picsum.photos/seed/music/400/300',
    description: 'A night of live music from local bands and artists.',
    dateTime: DateTime(2026, 10, 12, 18, 0),
    location: 'Viharamahadevi Park, Colombo',
    category: 'Music',
    price: 1500.0,
    availableSeats: 120,
  ),
  Event(
    id: '2',
    name: 'Tech Innovators Meetup',
    imageUrl: 'https://picsum.photos/seed/tech/400/300',
    description: 'Meet local developers and hear talks on emerging tech.',
    dateTime: DateTime(2026, 10, 20, 14, 0),
    location: 'BMICH, Colombo',
    category: 'Technology',
    price: 0.0,
    availableSeats: 60,
  ),
  Event(
    id: '3',
    name: 'Food & Craft Fair',
    imageUrl: 'https://picsum.photos/seed/food/400/300',
    description: 'Explore local food stalls and handmade crafts.',
    dateTime: DateTime(2026, 10, 25, 10, 0),
    location: 'Galle Face Green, Colombo',
    category: 'Food',
    price: 200.0,
    availableSeats: 200,
  ),
];