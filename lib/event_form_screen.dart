import 'package:flutter/material.dart';
import 'event_model.dart';
import 'mock_events.dart';

class EventFormScreen extends StatefulWidget {
  final Event? existingEvent; // null means "add new", not null means "edit"

  const EventFormScreen({super.key, this.existingEvent});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController imageUrlController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController categoryController;
  late TextEditingController priceController;
  late TextEditingController seatsController;

  @override
  void initState() {
    super.initState();
    final e = widget.existingEvent;
    nameController = TextEditingController(text: e?.name ?? '');
    imageUrlController = TextEditingController(text: e?.imageUrl ?? '');
    descriptionController = TextEditingController(text: e?.description ?? '');
    locationController = TextEditingController(text: e?.location ?? '');
    categoryController = TextEditingController(text: e?.category ?? '');
    priceController = TextEditingController(text: e != null ? e.price.toString() : '');
    seatsController = TextEditingController(text: e != null ? e.availableSeats.toString() : '');
  }

  @override
  void dispose() {
    nameController.dispose();
    imageUrlController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    categoryController.dispose();
    priceController.dispose();
    seatsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final isEditing = widget.existingEvent != null;

      final newEvent = Event(
        id: isEditing ? widget.existingEvent!.id : DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text.trim(),
        imageUrl: imageUrlController.text.trim(),
        description: descriptionController.text.trim(),
        dateTime: isEditing ? widget.existingEvent!.dateTime : DateTime.now().add(const Duration(days: 7)),
        location: locationController.text.trim(),
        category: categoryController.text.trim(),
        price: double.parse(priceController.text.trim()),
        availableSeats: int.parse(seatsController.text.trim()),
      );

      setState(() {
        if (isEditing) {
          final index = mockEvents.indexWhere((ev) => ev.id == widget.existingEvent!.id);
          mockEvents[index] = newEvent;
        } else {
          mockEvents.add(newEvent);
        }
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingEvent != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Event' : 'Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price (Rs.)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || double.tryParse(value.trim()) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: seatsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Available Seats',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || int.tryParse(value.trim()) == null) {
                    return 'Please enter a valid number of seats';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(isEditing ? 'Save Changes' : 'Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}