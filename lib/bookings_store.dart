import 'booking_model.dart';

// A simple shared list that holds all bookings made in the app.
// Every screen can read from and add to this same list.
class BookingsStore {
  static final List<Booking> bookings = [];

  static void addBooking(Booking booking) {
    bookings.add(booking);
  }

  static void cancelBooking(String bookingId) {
    final booking = bookings.firstWhere((b) => b.id == bookingId);
    booking.status = 'Cancelled';
  }
}