import 'package:flutter/material.dart';
import 'bookings_store.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  void _cancelBooking(String bookingId) {
    setState(() {
      BookingsStore.cancelBooking(bookingId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking cancelled')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookings = BookingsStore.bookings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text('You have no bookings yet.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                final isCancelled = booking.status == 'Cancelled';

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.event.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('Seats: ' + booking.numberOfSeats.toString()),
                        Text('Booked by: ' + booking.customerName),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text('Status: '),
                            Text(
                              booking.status,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isCancelled
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (!isCancelled)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => _cancelBooking(booking.id),
                              child: const Text('Cancel Booking'),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}