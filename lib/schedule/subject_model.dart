import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Define a Subject class to represent subject data
class SubjectModel {
  final String id; // Firestore document ID
  final String day;
  final String subjectName;
  final String time1;
  final String time2;
  final String room;

  SubjectModel({
    required this.id,
    required this.day,
    required this.subjectName,
    required this.time1,
    required this.time2,
    required this.room,
  });
}
//
// // Inside your Schedule widget, fetch and display subjects
// Stream<List<SubjectModel>> fetchSubjectsForDay(String day) {
//   // Implement a Firestore query to fetch subjects for the given day
// }
//
// // Use a StreamBuilder to display subjects for the selected day
// StreamBuilder<List<SubjectModel>>(
// stream: fetchSubjectsForDay(selectedDay), // selectedDay can be a variable
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return CircularProgressIndicator();
// } else if (snapshot.hasError) {
// return Text('Error: ${snapshot.error}');
// } else if (!snapshot.hasData || snapshot.data.isEmpty) {
// return Text('No subjects for this day.');
// } else {
// // Display the subjects using Subject widgets and dropdowns
// return ListView.builder(
// itemCount: snapshot.data.length,
// itemBuilder: (context, index) {
// final subject = snapshot.data[index];
// return Column(
// children: [
// Subject(
// // Pass subject data to the Subject widget
// sub1: subject.subjectName,
// // ...
// // Implement the dropdown for selecting the day
// dayDropdown: DropdownButton<String>(
// value: subject.day,
// onChanged: (newDay) {
// // Implement logic to update the day in Firestore
// },
// items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
//     .map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// ),
// ),
// Divider(), // Add a separator between subjects
// ],
// );
// },
// );
// }
// },
// )
