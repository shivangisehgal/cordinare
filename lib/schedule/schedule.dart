import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegecomp/schedule/subject_model.dart';
import 'package:google_fonts/google_fonts.dart';
class AddSubjectDialog extends StatefulWidget {
  @override
  _AddSubjectDialogState createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<AddSubjectDialog> {
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  String selectedDay = 'Monday';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFF35588),
      title: Center(
        child: Text(
            'Add Subject',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Day selection using CupertinoPicker
            CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (int index) {
                setState(() {
                  selectedDay = [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ][index];
                });
              },
              children: List<Widget>.generate(7, (int index) {
                return Center(
                  child: Text([
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ][index],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                    ),
                  ),
                );
              }),
            ),

            // DateTime picker for selecting time1
            ListTile(
              title: Text(
                  'Select Start Time',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
              subtitle: Text(
                "${selectedTime1.format(context)}",
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.pink.shade100,
                  letterSpacing: 1.1,
                ),
              ),
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime1,
                );

                if (pickedTime != null) {
                  setState(() {
                    selectedTime1 = pickedTime;
                  });
                }
              },
            ),

            // DateTime picker for selecting time2
            ListTile(
              title: Text(
                  'Select End Time:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
              subtitle: Text(
                "${selectedTime2.format(context)}",
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.pink.shade100,
                  letterSpacing: 1.1,
                ),
              ),
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime2,
                );

                if (pickedTime != null) {
                  setState(() {
                    selectedTime2 = pickedTime;
                  });
                }
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: subjectNameController,
                cursorColor: Colors.white,

                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), //<-- SEE HERE
                    ),
                    fillColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), //<-- SEE HERE
                    ),
                    labelStyle: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.pink.shade100,
                      letterSpacing: 1.1,
                    ),
                    floatingLabelStyle: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                    labelText: 'Subject Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),              child: TextField(
                controller: roomController,
              cursorColor: Colors.white,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), //<-- SEE HERE
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), //<-- SEE HERE
                    ),
                    floatingLabelStyle: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  labelStyle: GoogleFonts.nunito(
                    fontSize: 16,
                    color: Colors.pink.shade100,
                    letterSpacing: 1.1,
                  ),
                    labelText: 'Classroom'),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.white,
              letterSpacing: 1.1,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Background color
          ),
          onPressed: () {
            // Convert selectedTime1 and selectedTime2 to strings in the "hour:minute AM/PM" format
            String time1 = "${selectedTime1.hourOfPeriod}:${selectedTime1.minute} ${selectedTime1.period.toString().split('.')[1]}";
            String time2 = "${selectedTime2.hourOfPeriod}:${selectedTime2.minute} ${selectedTime2.period.toString().split('.')[1]}";

            // Call a function to add the subject to Firestore
            // Pass the subject details from the input fields
            FirebaseFirestore.instance.collection("subjects").add({
              "day": selectedDay,
              "time1": time1,
              "time2": time2,
              "subjectName": subjectNameController.text,
              "room": roomController.text
            }).then((value) {
              print(value.id);
              //Navigator.pop(context);
            }).catchError(
                    (error) => print('Failed to add new note due to $error'));
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(
              'Add',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Color(0xFFF35588),
              letterSpacing: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:collegecomp/schedule/subject_model.dart';

class Schedule extends StatefulWidget {
  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String selectedDay = 'Monday';

  // Function to fetch subjects for a given day
  Stream<List<SubjectModel>> fetchSubjectsForDay(String day) {
    // Reference to the Firestore "subjects" collection
    final CollectionReference subjectsCollection =
    FirebaseFirestore.instance.collection('subjects');

    // Create a query to filter subjects by the "day" field
    Query query = subjectsCollection.where('day', isEqualTo: day);

    // Create a stream of documents based on the query
    return query.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot doc) {
        // Map each document to a SubjectModel object
        return SubjectModel(
          id: doc.id,
          day: doc['day'],
          subjectName: doc['subjectName'],
          time1: doc['time1'],
          time2: doc['time2'],
          room: doc['room'],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF35588),
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // Pass the selected day to the dialog
              return AddSubjectDialog(); // You can change the day as needed
            },
          );
        },
      ),
      body: ListView(
        children: [
          for (var i = 0; i < 7; i++)
            _buildExpansionTile(
              [
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
                'Sunday'
              ][i],
              i,
            ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(String day, int index) {
    final List<Color> cardColor = [
      Colors.red.shade100,
      Colors.green.shade100,
      Colors.orange.shade100,
      Colors.blue.shade100,
      Colors.yellow.shade100,
      Colors.pink.shade100,
      Colors.deepPurple.shade100,
      Colors.blueGrey.shade100,
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
      child: Card(
        color: cardColor[index % cardColor.length],
        child: ExpansionTile(
          textColor: Colors.black,
          //collapsedIconColor: Colors.black,
          iconColor: Colors.black,
          backgroundColor: cardColor[index % cardColor.length],
          title: Text(
              day,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
          ),
          children: [
            StreamBuilder<List<SubjectModel>>(
              stream: fetchSubjectsForDay(day),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                        'Woohoo! It\'s a free-day!',
                            style: GoogleFonts.nunito(
                              fontSize: 13,
                              letterSpacing: 1.1,
                            ),
                    ),
                  );
                } else {
                  return Column(
                    children: snapshot.data!.map((subject) {
                      return ListTile(
                        title: Text(
                            subject.subjectName,
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.1,
                          ),
                        ),
                        subtitle: Text(
                          '${subject.time1} - ${subject.time2}\n${subject.room}',
                          style: GoogleFonts.nunito(
                            fontSize: 13,
                            letterSpacing: 1.1,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
