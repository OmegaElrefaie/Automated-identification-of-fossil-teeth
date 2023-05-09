import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/repositories/map_repo.dart';
import '../../../domain/map_model.dart';

MapRepository MapRepo = MapRepository.instance;

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
  late String _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Foosil Map'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/startpage'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Latitude',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude';
                  }
                  try {
                    _lat = double.parse(value);
                  } catch (e) {
                    return 'Please enter a valid latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Longitude',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude';
                  }
                  try {
                    _long = double.parse(value);
                  } catch (e) {
                    return 'Please enter a valid longitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageUrl = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final map = MapModel(
                      title: _title.trim(),
                      description: _description.trim(),
                      lat: _lat,
                      long: _long,
                      imageUrl: _imageUrl,
                    );
                    print(_title);
                    print(_description);
                    print(_lat);
                    print(_long);
                    print(_imageUrl);

                    await MapRepo.addMap(map);

                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
