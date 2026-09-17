import 'event_model.dart';

class Booking {
  final String id;
  final Event event;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final int numberOfSeats;
  final DateTime bookingDate;
  String status; // 'Confirmed' or 'Cancelled'

  Booking({
    required this.id,
    required this.event,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.numberOfSeats,
    required this.bookingDate,
    this.status = 'Confirmed',
  });
}