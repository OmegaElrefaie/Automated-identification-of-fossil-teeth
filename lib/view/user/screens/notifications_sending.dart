import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomNotification extends StatefulWidget {
  @override
  _CustomNotificationState createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  final CollectionReference _customNotificationsCollection =
      FirebaseFirestore.instance.collection('CustomNotifications');

  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _bodyController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child:
                  _isSubmitting ? CircularProgressIndicator() : Text('Submit'),
              onPressed: () async {
                // Get the title and body values from the text fields
                String title = _titleController.text.trim();
                String body = _bodyController.text.trim();

                if (title.isEmpty || body.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Title and body cannot be empty.'),
                    ),
                  );
                  return;
                }

                // Ask the user to confirm before submitting
                bool confirmed = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirm'),
                    content: Text(
                        'Are you sure you want to submit this notification?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: Text('Submit'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                );

                if (confirmed) {
                  // Set the submitting state to true
                  setState(() {
                    _isSubmitting = true;
                  });

                  // Save the notification data to Firestore
                  await _customNotificationsCollection.add({
                    'Title': title,
                    'Body': body,
                  });

                  // Show a success message to the user
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Notification Saved'),
                      content: Text('Notification has been sent to all users.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );

                  // Reset the text fields and the submitting state
                  _titleController.clear();
                  _bodyController.clear();
                  setState(() {
                    _isSubmitting = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
