import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/custom_app_bar.dart';

class AppointmentBookingScreen extends ConsumerStatefulWidget {
  final String? dentistId;
  
  const AppointmentBookingScreen({super.key, this.dentistId});

  @override
  ConsumerState<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends ConsumerState<AppointmentBookingScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  String? _selectedDentist;
  String? _selectedReason;
  final TextEditingController _notesController = TextEditingController();
  
  final List<String> _reasons = [
    'Regular Checkup',
    'Cleaning',
    'Filling',
    'Root Canal',
    'Tooth Extraction',
    'Braces Consultation',
    'Dental Emergency',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Book Appointment',
        actions: [
          IconButton(
            onPressed: _saveDraft,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Selection
            _buildDateSelector(),
            const SizedBox(height: 24),
            
            // Time Slots
            _buildTimeSlots(),
            const SizedBox(height: 24),
            
            // Dentist Selection
            _buildDentistSelector(),
            const SizedBox(height: 24),
            
            // Reason Selection
            _buildReasonSelector(),
            const SizedBox(height: 24),
            
            // Notes
            _buildNotesField(),
            const SizedBox(height: 32),
            
            // Book Button
            ElevatedButton(
              onPressed: _bookAppointment,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDateSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Date',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(14, (index) {
                  final date = DateTime.now().add(Duration(days: index));
                  final isSelected = _selectedDate.year == date.year &&
                      _selectedDate.month == date.month &&
                      _selectedDate.day == date.day;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                        _selectedTime = null;
                      });
                    },
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Theme.of(context).primaryColor 
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected 
                              ? Theme.of(context).primaryColor 
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE').format(date),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date.day.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            DateFormat('MMM').format(date),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTimeSlots() {
    final timeSlots = _generateTimeSlots();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Time',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: timeSlots.map((time) {
                final isSelected = _selectedTime == time;
                final isAvailable = _isTimeSlotAvailable(time);
                
                return FilterChip(
                  label: Text(time),
                  selected: isSelected,
                  onSelected: isAvailable 
                      ? (selected) {
                          setState(() {
                            _selectedTime = selected ? time : null;
                          });
                        }
                      : null,
                  selectedColor: Theme.of(context).primaryColor,
                  backgroundColor: isAvailable 
                      ? Colors.grey.shade100 
                      : Colors.grey.shade300,
                  labelStyle: TextStyle(
                    color: isSelected 
                        ? Colors.white 
                        : isAvailable ? Colors.black : Colors.grey,
                  ),
                  showCheckmark: false,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
  
  List<String> _generateTimeSlots() {
    return [
      '09:00 AM', '09:30 AM', '10:00 AM', '10:30 AM',
      '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM',
      '01:00 PM', '01:30 PM', '02:00 PM', '02:30 PM',
      '03:00 PM', '03:30 PM', '04:00 PM', '04:30 PM',
    ];
  }
  
  bool _isTimeSlotAvailable(String time) {
    // TODO: Check with backend
    return true;
  }
  
  // Other builder methods...
}