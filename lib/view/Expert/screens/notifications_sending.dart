import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';

class CustomNotification extends StatefulWidget {
  const CustomNotification({super.key});
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
        title: Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: () {
              context.go('/home_expert');
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Add Notifications",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.5,
                    fontFamily: 'Inter',
                    fontSize: 25.0,
                    color: kTextColor),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _bodyController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
                onPressed: () async {
                  // Get the title and body values from the text fields
                  String title = _titleController.text.trim();
                  String body = _bodyController.text.trim();

                  if (title.isEmpty || body.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Title and body cannot be empty.'),
                      ),
                    );
                    return;
                  }

                  // Ask the user to confirm before submitting
                  bool confirmed = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text(
                          'Are you sure you want to submit this notification?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: const Text('Submit'),
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
                        title: const Text('Notification Saved'),
                        content: const Text(
                            'Notification has been sent to all users.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
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
      ),
    );
  }
}
