import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/repositories/map_repo.dart';
import '../../../domain/map_model.dart';

class FossilMap extends StatefulWidget {
  const FossilMap({Key? key}) : super(key: key);

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
          onPressed: () => context.pop(),
        ),
      ),
      body: StreamBuilder<List<MapModel>>(
        stream: MapRepository().getMaps(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final maps = snapshot.data!.map((map) => map.toMap()).toList();
            myMarkers = HashSet<Marker>.from(maps.map(
              (map) => Marker(
                markerId: MarkerId('de7k'),
                position: LatLng(map['lat'] as double, map['long'] as double),
                infoWindow: InfoWindow(
                  title: map['name'],
                  snippet: 'See more',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(map['name']),
                        content: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                            height: 500,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 300,
                                  child: Image.asset(
                                    map['imageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text('\n'),
                                Text(map['description']),
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
              ),
            ));
            return GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(30.033333, 31.233334),
                zoom: 5,
              ),
              onMapCreated: (GoogleMapController googleMapController) {},
              markers: myMarkers,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
