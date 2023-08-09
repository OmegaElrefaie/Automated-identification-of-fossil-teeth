import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/repositories/map_repo.dart';
import '../../../domain/map_model.dart';

MapRepository mapRepo = MapRepository.instance;

class FoosilMapInputScreen extends StatefulWidget {
  const FoosilMapInputScreen({Key? key}) : super(key: key);

  @override
  _FoosilMapInputScreenState createState() => _FoosilMapInputScreenState();
}

class _FoosilMapInputScreenState extends State<FoosilMapInputScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _description;
  late double _lat;
  late double _long;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new fossil location'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              _buildStyledTextField(
                label: 'Title',
                hintText: '',
                onSaved: (value) {
                  _title = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              _buildStyledTextField(
                label: 'Description',
                hintText: '',
                onSaved: (value) {
                  _description = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: _buildStyledTextField(
                      label: 'Latitude',
                      hintText: '',
                      onSaved: (value) {
                        _lat = double.parse(value!);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a latitude';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: _buildStyledTextField(
                      label: 'Longitude',
                      hintText: '',
                      onSaved: (value) {
                        _long = double.parse(value!);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a longitude';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final map = MapModel(
                        title: _title.trim(),
                        description: _description.trim(),
                        lat: _lat,
                        long: _long,
                        imageUrl: '', // Empty imageUrl
                      );
                      print(_title);
                      print(_description);
                      print(_lat);
                      print(_long);

                      await mapRepo.addMap(map);

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
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

  Widget _buildStyledTextField({
    required String label,
    required String hintText,
    void Function(String)? onSaved,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12.0),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      // onSaved: onSaved,
      validator: validator,
    );
  }
}
