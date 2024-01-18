import 'package:flutter/material.dart';


class TimetablePage extends StatefulWidget {
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  DateTime selectedDate = DateTime.now();
  List<TimetableEntry> timetableEntries = [];

  // Correct the declaration
  String startAMPM = 'AM';
  String endAMPM = 'AM';
  String startTime = '08:00';
  String endTime = '09:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Timetable'),
      ),
      body: Column(
        children: [
          _buildDateSelection(),
          Expanded(
            child: _buildTimetable(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEntryDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Widget _buildDateSelection() {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(7, (index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          bool isSelected = date.weekday == selectedDate.weekday;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
            },
            child: Container(
              color: isSelected ? Colors.blue : null,
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  _getWeekdayName(date.weekday),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

Widget _buildTimetable() {
  // Filter timetableEntries for the selected day
  List<TimetableEntry> selectedDayTimetable = timetableEntries
      .where((entry) =>
          _parseTime(entry.startTime).day == selectedDate.day &&
          _parseTime(entry.startTime).month == selectedDate.month &&
          _parseTime(entry.startTime).year == selectedDate.year)
      .toList();

  // Sort the filtered timetableEntries based on time
  selectedDayTimetable.sort((a, b) {
    DateTime timeA = _parseTime(a.startTime);
    DateTime timeB = _parseTime(b.startTime);

    return timeA.compareTo(timeB);
  });

  if (selectedDayTimetable.isEmpty) {
    return Center(
      child: Text('No entries for the selected day.'),
    );
  }
  return Table(
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    columnWidths: {
      0: IntrinsicColumnWidth(),
      1: IntrinsicColumnWidth(),
      2: IntrinsicColumnWidth(),
    },
    children: [
      TableRow(
        children: [
          TableCell(
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.grey,
              child: Text(
                'Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TableCell(
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.grey,
              child: Text(
                'Work',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TableCell(
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.grey,
              child: Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      for (int index = 0; index < selectedDayTimetable.length; index++)
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  '${selectedDayTimetable[index].startTime} - ${selectedDayTimetable[index].endTime}',
                ),
              ),
            ),
            TableCell(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  selectedDayTimetable[index].work,
                ),
              ),
            ),
            TableCell(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditEntryDialog(context, index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        timetableEntries.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
    ],
  );
}



Future<void> _showAddEntryDialog(BuildContext context) async {
  String time = '';
  String work = '';

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Timetable Entry'),
            content: Column(
              children: [
                _buildTimePicker('Time', (value) {
                  time = value;
                }, (value) {
                  startAMPM = value;
                }),
                TextField(
                  onChanged: (value) {
                    work = value;
                  },
                  decoration: InputDecoration(labelText: 'Work'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    timetableEntries.add(
                      TimetableEntry(
                        startTime: '$time $startAMPM',
                        endTime: '$endTime $endAMPM',
                        work: work,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> _showEditEntryDialog(BuildContext context, int index) async {
  String work = timetableEntries[index].work;
  String editedStartTime = timetableEntries[index].startTime;
  String editedEndTime = timetableEntries[index].endTime;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Edit Timetable Entry'),
            content: Column(
              children: [
                _buildTimePicker('Start Time', (value) {
                  editedStartTime = value;
                }, (value) {
                  startAMPM = value;
                }, initialTime: _parseTime(timetableEntries[index].startTime)),
                _buildTimePicker('End Time', (value) {
                  editedEndTime = value;
                }, (value) {
                  endAMPM = value;
                }, initialTime: _parseTime(timetableEntries[index].endTime)),
                TextField(
                  onChanged: (value) {
                    work = value;
                  },
                  controller: TextEditingController(text: work),
                  decoration: InputDecoration(labelText: 'Work'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    timetableEntries[index] = TimetableEntry(
                      startTime: '$editedStartTime $startAMPM',
                      endTime: '$editedEndTime $endAMPM',
                      work: work,
                    );
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    timetableEntries.removeAt(index);
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Delete'),
              ),
            ],
          );
        },
      );
    },
  );
}

 Widget _buildTimePicker(String label, Function(String) onTimeChanged,
    Function(String) onAMPMChanged,
    {DateTime? initialTime}) {
  return Row(
    children: [
      Text('$label:'),
      SizedBox(width: 8),
      DropdownButton<String>(
       value: (initialTime?.hour ?? 0) < 12 ? 'AM' : 'PM',

        onChanged: (String? value) {
          if (value != null) {
            onAMPMChanged(value);
          }
        },
        items: ['AM', 'PM'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      SizedBox(width: 8),
      ElevatedButton(
        onPressed: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(initialTime ?? DateTime.now()),
          );

          if (pickedTime != null) {
            onTimeChanged('${pickedTime.hourOfPeriod}:${pickedTime.minute}');
          }
        },
        child: Text('Select Time'),
      ),
    ],
  );
}

DateTime _parseTime(String time) {
  List<String> components = time.split(' ');
  List<String> timeComponents = components[0].split(':');
  int hour = int.parse(timeComponents[0]);
  int minute = int.parse(timeComponents[1]);

  if (components[1].toLowerCase() == 'pm' && hour < 12) {
    hour += 12;
  } else if (components[1].toLowerCase() == 'am' && hour == 12) {
    hour = 0;
  }

  return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
}


}

class TimetableEntry {
  final String startTime;
  final String endTime;
  final String work;

  TimetableEntry({
    required this.startTime,
    required this.endTime,
    required this.work,
  });
}
