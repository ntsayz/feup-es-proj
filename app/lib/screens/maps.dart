// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import 'package:geocoding/geocoding.dart';


class MapPage extends StatefulWidget {
  final String uid;
  const MapPage({Key? key, required this.uid}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}


class _MapPageState extends State<MapPage> {
  late MapController _mapController;
  LatLng point = LatLng(41.177115, -8.595845);
  var location = [];




  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    point =  LatLng(41.177115, -8.595845);
  }

  void _zoomIn() {
    _mapController.move(_mapController.center, _mapController.zoom + 1);
  }

  void _zoomOut() {
    _mapController.move(_mapController.center, _mapController.zoom - 1);
  }

  String _searchQuery = '';


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController, // Add this line to pass the map controller to the FlutterMap widget
          options: MapOptions(
            onTap: (tap, p) {
              setState(() {
                point = p;
              });
            },
            center: LatLng(41.177115, -8.595845),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 100.0,
                  height: 100.0,
                  point: point,
                  builder: (ctx) => Icon(Icons.location_on, color: Colors.red,),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 16.0),
          child: Column(
            children: [
              Card(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on_outlined),
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        if (_searchQuery.isNotEmpty) {
                          // Perform search using query
                          List<Location> locations = await locationFromAddress(_searchQuery);
                          if (locations.isNotEmpty) {
                            // Update map center to first location
                            Location location = locations.first;
                            _mapController.move(LatLng(location.latitude, location.longitude), 13.0);
                            setState(() {
                              point = LatLng(location.latitude, location.longitude);
                            });
                          }
                        }
                      },
                      child: Icon(Icons.search),
                    ),
                    hintText: "Search for City",
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                  onSubmitted: (query) async {
                    if (_searchQuery.isNotEmpty) {
                      // Perform search using query
                      List<Location> locations = await locationFromAddress(_searchQuery);
                      if (locations.isNotEmpty) {
                        // Update map center to first location
                        Location location = locations.first;
                        _mapController.move(LatLng(location.latitude, location.longitude), 13.0);
                        setState(() {
                          point = LatLng(location.latitude, location.longitude);
                        });
                      }
                    }
                  },
                ),

              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 550,),
              FloatingActionButton(
                onPressed: _zoomIn,
                child: Icon(Icons.add),
              ),
              SizedBox(height: 10,),
              FloatingActionButton(
                onPressed: _zoomOut,
                child: Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
