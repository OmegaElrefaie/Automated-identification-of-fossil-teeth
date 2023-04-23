import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FossilMap extends StatefulWidget {
  const FossilMap({Key? key});

  @override
  State<FossilMap> createState() => _FossilMapState();
}

class _FossilMapState extends State<FossilMap> {
  var myMarkers = HashSet<Marker>(); //array of type marker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fossils Map'),
      ),
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(30.033333, 31.233334), zoom: 5),
        onMapCreated: (GoogleMapController googleMapController) {
          setState(() {
            myMarkers.add(Marker(
              markerId: MarkerId('1'),
              position: LatLng(31.042701965148268, 31.353450854621194),
              infoWindow: InfoWindow(
                title: 'MUVP',
                snippet: 'See more',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('MUVP'),
                      content: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: 500, // adjust the height to fit your content
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    120, // adjust the dimensions of the image to fit your image
                                width:
                                    300, // adjust the dimensions of the image to fit your image
                                child: Image.asset(
                                  'assets/images/MUVP_logo.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('\n'),
                              Text(
                                  'A research unit for vertebrate fossil \n preparation and training, was created in 2010. MUVP is dedicated to educating Egyptian vertebrate paleontologists, expanding awareness of Egypt vertebrate paleontological resources, and undertaking collection, preparation, study and curation of Egypt fossil vertebrates.'),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ));
          });
        },
        markers: myMarkers,
      ),
    );
  }
}
