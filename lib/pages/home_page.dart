// ignore_for_file: avoid_print

import 'dart:math';

import 'package:find_hospital/models/RSModel.dart';
import 'package:find_hospital/models/kategori.dart';
import 'package:find_hospital/models/rsapotek.dart';
import 'package:find_hospital/pages/category.dart';
import 'package:find_hospital/pages/detail_page.dart';
import 'package:find_hospital/pages/map/location_service.dart';
// import 'package:find_hospital/pages/map/user_location.dart';
import 'package:find_hospital/theme.dart';
import 'package:find_hospital/widget/kategori_card.dart';
import 'package:find_hospital/widget/rsapotek_card.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocationService locationService = LocationService();
  double lat = 0;
  double long = 0;
  String address = '';
  late Future<RSModel> _rsModel;

  @override
  void initState() {
    super.initState();
    _rsModel = RSModel.getData();
    locationService.locationStream.listen((event) {
      setState(() {
        lat = event.lat!;
        long = event.long!;
        address = GetAddressFromLatLong(lat, long).toString();
      });
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> GetAddressFromLatLong(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    print(placemarks);
    Placemark place = placemarks[0];
    address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    print(address);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    // locationService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // kalau pakai stream builder, pakai dispose
      // kalau pakai stream listener, pakai initstate
      // appBar: AppBar(
      //   title: StreamBuilder<UserLocation>(
      //       stream: locationService.locationStream,
      //       builder: (_, snapshot) => (snapshot.hasData)
      //           ? Center(
      //               child: Text(
      //                   '${snapshot.data!.lat} and ${snapshot.data!.long}'))
      //           : const Center(child: Text("waiting for location"))),
      // ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            SizedBox(
              height: edge,
            ),
            Padding(
                padding: EdgeInsets.only(left: edge),
                child: (address == '')
                    ? Text(
                        'lat : ' +
                            lat.toString() +
                            "\nLong : " +
                            long.toString(),
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      )
                    : Text(address)),
            // ElevatedButton(
            //     onPressed: () async {
            //       address = GetAddressFromLatLong(lat, long).toString();
            //     },
            //     child: const Text('Get Location')),
            SizedBox(
              height: edge,
            ),
            // NOTE: TITLE/HEADER
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Explore Now',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Temukan RS dan Apotek Terdekat',
                style: greyTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // NOTE: POPULAR CITIES
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'What\'s Here',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  KategoriCard(
                    Kategori(
                        id: 1,
                        imageUrl: 'assets/city1.png',
                        name: 'Rumah Sakit'),
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryData(
                                    id: 1.toString(),
                                  )));
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  KategoriCard(
                    Kategori(
                        id: 2, imageUrl: 'assets/city2.png', name: 'Apotek'),
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryData(
                                    id: 3.toString(),
                                  )));
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  KategoriCard(
                    Kategori(
                        id: 3, imageUrl: 'assets/city3.png', name: 'Klinik'),
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryData(
                                    id: 2.toString(),
                                  )));
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  KategoriCard(
                    Kategori(
                        id: 3, imageUrl: 'assets/city3.png', name: 'puskesmas'),
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryData(
                                    id: 4.toString(),
                                  )));
                    },
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // NOTE: Rekomendasi RS dan Apotek
            Padding(
              padding: EdgeInsets.only(left: edge),
              child: Text(
                'Recomended',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder<RSModel>(
                future: _rsModel,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      print('Waiting...');
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        print("Error, Data not Found :" +
                            snapshot.hasError.toString());
                        return const Center(
                            child: Text("Error, Data not Found"));
                      } else {
                        print("Data Founded");

                        return listViewharversine(snapshot, context);
                      }
                  }
                }),
          ],
        ),
      ),
    );
  }

  ListView listViewharversine(
      AsyncSnapshot<RSModel> snapshot, BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: snapshot.data!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          // harversine algorithm

          // convert degree to radian
          double lon1 = long * 3.14 / 180;
          double lat1 = lat * 3.14 / 180;
          double lon2 =
              double.parse(snapshot.data!.data![index].long.toString()) *
                  3.14 /
                  180;
          double lat2 =
              double.parse(snapshot.data!.data![index].lat.toString()) *
                  3.14 /
                  180;

          // calculate
          double dlon = lon2 - lon1;
          double dlat = lat2 - lat1;
          double a = pow(sin(dlat / 2), 2) +
              cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
          double r = 6371;
          double hasil = (r * 2) * (asin(sqrt(a))); // hasil dalam bentuk KM
          hasil = hasil * 1000; //ubah ke Meter
          print("my Lat : " +
              lat.toString() +
              " | my Long : " +
              long.toString() +
              " | Lat : " +
              snapshot.data!.data![index].lat.toString() +
              " | Long : " +
              snapshot.data!.data![index].long.toString() +
              " | harversine : " +
              hasil.toString());
          return Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - (2 * edge),
                child: RsapotekCard(
                  Rsapotek(
                      id: snapshot.data!.data![index].id,
                      city: snapshot.data!.data![index].kota.toString(),
                      // imageUrl: 'assets/space1.png',
                      imageUrl: snapshot.data!.data![index].foto.toString(),
                      name: snapshot.data!.data![index].nama.toString(),
                      distance: hasil.toInt()),
                  () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  imageRS: snapshot.data!.data![index].foto
                                      .toString(),
                                  idRS:
                                      snapshot.data!.data![index].id.toString(),
                                  namaRS: snapshot.data!.data![index].nama
                                      .toString(),
                                  alamatRS: snapshot.data!.data![index].alamat
                                          .toString() +
                                      ", " +
                                      snapshot.data!.data![index].kota
                                          .toString(),
                                  jarakRS: hasil.toInt(),
                                  latEnd: double.parse(snapshot
                                      .data!.data![index].lat
                                      .toString()),
                                  longEnd: double.parse(snapshot
                                      .data!.data![index].long
                                      .toString()),
                                  latStart: lat,
                                  longStart: long,
                                )));
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        });
  }
}
