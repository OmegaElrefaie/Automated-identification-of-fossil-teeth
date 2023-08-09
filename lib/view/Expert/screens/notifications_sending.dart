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
        title: Text(
          "Add a notification",
        ),
        leading: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              context.pop();
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
              const SizedBox(
                height: 20,
              ),
              _buildStyledTextField(
                controller: _titleController,
                labelText: 'Title',
              ),
              const SizedBox(height: 16.0),
              _buildStyledTextField(
                controller: _bodyController,
                labelText: 'Body',
                maxLines: 5,
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                      // backgroundColor: getColor(kPrimaryColor, kTextColor),
                      ),
                  onPressed: () async {
                    await _submitForm();
                  },
                  child: _isSubmitting
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    String title = _titleController.text.trim();
    String body = _bodyController.text.trim();

    if (title.isEmpty && body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title and body cannot be empty.'),
        ),
      );
      return;
    } else if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title cannot be empty.'),
        ),
      );
      return;
    } else if (body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Body cannot be empty.'),
        ),
      );
      return;
    }

    bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content:
            const Text('Are you sure you want to submit this notification?'),
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
      setState(() {
        _isSubmitting = true;
      });

      await _customNotificationsCollection.add({
        'Title': title,
        'Body': body,
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Notification Saved'),
          content: const Text('Notification has been sent to all users.'),
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

      _titleController.clear();
      _bodyController.clear();
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
