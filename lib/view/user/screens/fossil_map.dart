import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FossilMap extends StatefulWidget {
  const FossilMap({super.key});

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/startpage'),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(30.033333, 31.233334), zoom: 5),
        onMapCreated: (GoogleMapController googleMapController) {
          setState(() {
            myMarkers.add(Marker(
              markerId: const MarkerId('1'),
              position: const LatLng(31.042701965148268, 31.353450854621194),
              infoWindow: InfoWindow(
                title: 'MUVP',
                snippet: 'See more',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('MUVP'),
                      content: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
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
                              const Text('\n'),
                              const Text(
                                  'A research unit for vertebrate fossil \n preparation and training, was created in 2010. MUVP is dedicated to educating Egyptian vertebrate paleontologists, expanding awareness of Egypt vertebrate paleontological resources, and undertaking collection, preparation, study and curation of Egypt fossil vertebrates.'),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
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
