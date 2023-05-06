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
        elevation: 0,
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
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(children: [
            const Center(
              child: const Text(
                "Add Fact",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.5,
                    fontFamily: 'Inter',
                    fontSize: 30.0,
                    color: kTextColor),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            TextField(
              controller: _textController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Text...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 40,
              width: 120,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: getColor(kPrimaryColor, kTextColor)),
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 20),
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
          ]),
        ),
      ),
    );
  }
}
