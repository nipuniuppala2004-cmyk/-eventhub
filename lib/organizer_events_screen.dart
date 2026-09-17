import 'package:flutter/material.dart';
import 'event_model.dart';
import 'mock_events.dart';
import 'event_form_screen.dart';
import 'bookings_store.dart';

class OrganizerEventsScreen extends StatefulWidget {
  const OrganizerEventsScreen({super.key});

  @override
  State<OrganizerEventsScreen> createState() => _OrganizerEventsScreenState();
}

class _OrganizerEventsScreenState extends State<OrganizerEventsScreen> {
  void _deleteEvent(Event event) {
    setState(() {
      mockEvents.removeWhere((e) => e.id == event.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Event removed')),
    );
  }

  void _viewBookings(Event event) {
    final bookingsForEvent = BookingsStore.bookings
        .where((b) => b.event.id == event.id)
        .toList();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bookings for ' + event.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (bookingsForEvent.isEmpty)
                const Text('No bookings yet for this event.')
              else
                ...bookingsForEvent.map(
                  (b) => ListTile(
                    title: Text(b.customerName),
                    subtitle: Text('Seats: ' + b.numberOfSeats.toString() + ' - ' + b.status),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Events'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EventFormScreen()),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: mockEvents.isEmpty
          ? const Center(child: Text('No events yet. Tap + to add one.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: mockEvents.length,
              itemBuilder: (context, index) {
                final event = mockEvents[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(event.name),
                    subtitle: Text(event.category + ' - ' + event.location),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventFormScreen(existingEvent: event),
                            ),
                          ).then((_) => setState(() {}));
                        } else if (value == 'delete') {
                          _deleteEvent(event);
                        } else if (value == 'bookings') {
                          _viewBookings(event);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(value: 'delete', child: Text('Remove')),
                        const PopupMenuItem(value: 'bookings', child: Text('View Bookings')),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}