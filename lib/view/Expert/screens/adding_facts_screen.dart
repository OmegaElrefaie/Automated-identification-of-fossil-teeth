import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/domain/facts_model.dart';
import '../../../constants.dart';
import '../../../data/repositories/facts_repo.dart';
import '../../user/widgets/getcolor.dart';

FactRepository factRepo = FactRepository.instance;

class AddingFacts extends StatefulWidget {
  const AddingFacts({super.key});

  @override
  State<AddingFacts> createState() => _AddingFactsState();
}

class _AddingFactsState extends State<AddingFacts> {
  final TextEditingController _textController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a fact to the database'),
        elevation: 0,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              _buildStyledTextField(
                controller: _textController,
                labelText: 'Text',
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: getColor(kPrimaryColor, kTextColor),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 18,
                          ),
                        ),
                  onPressed: () async {
                    String text = _textController.text.trim();
                    if (text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Text cannot be empty.'),
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
                            'Are you sure you want to submit this fact?'),
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
                      final fact = Facts(
                        text: _textController.text.trim(),
                      );
                      factRepo.createFact(fact);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Fact Saved'),
                          content: const Text('Fact Submitted to all users.'),
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

                      _textController.clear();
                      setState(() {
                        _isSubmitting = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: 2.0), // Make the border bold
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
