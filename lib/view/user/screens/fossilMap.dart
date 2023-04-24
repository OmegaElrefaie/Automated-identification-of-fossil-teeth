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

            myMarkers.add(Marker(
              markerId: MarkerId('2'),
              position: LatLng(29.2692, 30.0397),
              infoWindow: InfoWindow(
                title: 'Ariid catfish',
                snippet: 'See more',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Ariid catfish'),
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
                                  'assets/images/Ariid_catfish.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('\n'),
                              Text(
                                  'Qarmoutus hitanensis is an extinct ariid catfish whose fossils were first discovered in Wadi Al-Hitan, Egypt. It lived during the Eocene period around 37 million years ago, and its body length is estimated to be about 6.5 feet long.'),
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

            myMarkers.add(Marker(
              markerId: MarkerId('3'),
              position: LatLng(25.456188, 30.546968),
              infoWindow: InfoWindow(
                title: 'Qatranimys safroutus',
                snippet: 'See more',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Qatranimys safroutus'),
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
                                  'assets/images/Qatranimys_safroutus.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('\n'),
                              Text(
                                  'Wahasuchus is a genus of extinct mesoeucrocodylian of the Middle Campanian age found in the Quseir Formation, Egypt.'),
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

            myMarkers.add(Marker(
              markerId: MarkerId('4'),
              position: LatLng(29.414, 30.852),
              infoWindow: InfoWindow(
                title: 'Wahasuchus egyptensis',
                snippet: 'See more',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Wahasuchus egyptensis'),
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
                                  'assets/images/Wahasuchus_egyptensis.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('\n'),
                              Text(
                                  'According to the new study, published in PeerJ on October 19, the new mouse was named Qatranimys safroutus. The mouse took this name in relation to the Qatranimys region, as well as because of its very small size, as it was a fingertip (safroutus) with a weight of only about 40 grams, and “safrout” in Egyptian colloquial means small or dwarf.'),
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

            myMarkers.add(Marker(
              markerId: MarkerId('5'),
              position: LatLng(27.000092, 28.000068),
              infoWindow: InfoWindow(
                title: 'Mansourasaurus shahinae ',
                snippet: 'See more',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Mansourasaurus shahinae'),
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
                                  'assets/images/Mansourasaurus.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('\n'),
                              Text(
                                  'Mansourasaurus represents the best-known continental African (i.e. excluding Madagascar) titanosaur of the Upper Cretaceous from the time period after the Cenomanian. Its existence would show that the continent was far less isolated from the various Eurasian landmasses than had been assumed.'),
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
