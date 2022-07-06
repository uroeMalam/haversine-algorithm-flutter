import 'dart:math';

import 'package:find_hospital/models/rsapotek.dart';
import 'package:find_hospital/pages/detail_page.dart';
import 'package:find_hospital/theme.dart';
import 'package:find_hospital/widget/rsapotek_card.dart';
import 'package:flutter/material.dart';

import '../models/RSModel.dart';
import 'map/location_service.dart';

class CategoryData extends StatefulWidget {
  String id;
  CategoryData({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CategoryData> createState() => _CategoryDataState();
}

class _CategoryDataState extends State<CategoryData> {
  LocationService locationService = LocationService();
  double lat = 0;
  double long = 0;
  String address = '';
  late Future<RSModel> _rsModel;

  @override
  void initState() {
    super.initState();
    _rsModel = RSModel.getDataById(widget.id);
    locationService.locationStream.listen((event) {
      setState(() {
        lat = event.lat!;
        long = event.long!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("kategori"),
      ),
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<RSModel>(
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
                    return const Center(child: Text("Error, Data not Found"));
                  } else {
                    print("Data Founded");

                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: listViewharversine(snapshot, context),
                    );
                  }
              }
            }),
      ),
    );
  }

  ListView listViewharversine(
      AsyncSnapshot<RSModel> snapshot, BuildContext context) {
    return ListView.builder(
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
