import 'package:find_hospital/models/fasilitasListModel.dart';
import 'package:find_hospital/models/imagesCarouselModel.dart';
import 'package:find_hospital/pages/map/map_app.dart';
import 'package:find_hospital/theme.dart';
import 'package:find_hospital/widget/facility_item.dart';
import 'package:flutter/material.dart';

import 'map/map_var.dart';

class DetailPage extends StatelessWidget {
  String idRS = "";
  String imageRS = "";
  String namaRS = "";
  int jarakRS = 0;
  String alamatRS = "";
  double latStart = 0;
  double latEnd = 0;
  double longStart = 0;
  double longEnd = 0;
  DetailPage(
      {Key? key,
      required this.imageRS,
      required this.idRS,
      required this.namaRS,
      required this.jarakRS,
      required this.alamatRS,
      required this.latStart,
      required this.latEnd,
      required this.longEnd,
      required this.longStart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            (imageRS == 'null')
                ? Image.asset(
                    'assets/city1.png',
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    fit: BoxFit.cover,
                  )
                : Image.network(MapVariable.images + imageRS),
            ListView(
              children: [
                const SizedBox(
                  height: 328,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge,
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 50,
                                  child: Text(
                                    namaRS,
                                    style: blackTextStyle.copyWith(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text.rich(
                                  TextSpan(
                                    text: jarakRS.toString(),
                                    style: purpleTextStyle.copyWith(
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' Meter',
                                        style: greyTextStyle.copyWith(
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Information',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 120,
                        child: FutureBuilder<FasilitasListModel>(
                            future: FasilitasListModel.getDataById(idRS),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  print('Waiting...');
                                  return const Center(
                                      child: CircularProgressIndicator());
                                default:
                                  if (snapshot.hasError) {
                                    print("Error, Data not Found :" +
                                        snapshot.hasError.toString());
                                    return const Center(
                                        child: Text("Error, Data not Found"));
                                  } else {
                                    print("Data Founded");
                                    if (snapshot.data!.data!.isEmpty) {
                                      return const Center(
                                        child: Text(
                                            "Informasi tambahan belum tersedia."),
                                      );
                                    }
                                    return GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 200,
                                                childAspectRatio: 3 / 2,
                                                crossAxisSpacing: 20,
                                                mainAxisSpacing: 20),
                                        itemCount: snapshot.data!.data!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (ctx, index) {
                                          return FacilityItem(
                                              imageUrl: snapshot
                                                  .data!.data![index].foto
                                                  .toString(),
                                              name: snapshot
                                                  .data!.data![index].nama
                                                  .toString());
                                        });
                                  }
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Photos',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                          height: 88,
                          child: FutureBuilder<ImagesCarouselModel>(
                              future: ImagesCarouselModel.getDataById(idRS),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    print('Waiting...');
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  default:
                                    if (snapshot.hasError) {
                                      print("Error, Data not Found :" +
                                          snapshot.hasError.toString());
                                      return const Center(
                                          child: Text("Error, Data not Found"));
                                    } else {
                                      print("Data Founded");
                                      if (snapshot.data!.data!.isEmpty) {
                                        return const Center(
                                          child: Text(
                                              "Fasilitas ini belum menambahkan foto."),
                                        );
                                      }

                                      return Padding(
                                          padding: EdgeInsets.only(
                                              top: 20, right: edge, left: edge),
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  snapshot.data!.data!.length,
                                              shrinkWrap: true,
                                              itemBuilder: (ctx, index) {
                                                return Image.network(
                                                  MapVariable.images +
                                                      snapshot.data!
                                                          .data![index].foto
                                                          .toString(),
                                                  width: 110,
                                                  height: 88,
                                                  fit: BoxFit.contain,
                                                );
                                              }));
                                    }
                                }
                              })),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: edge),
                        child: Text(
                          'Alamat',
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: edge,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(
                                alamatRS,
                                maxLines: 2,
                                style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(
                                "lat : " +
                                    latEnd.toString() +
                                    "\nLong : " +
                                    longEnd.toString(),
                                style: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: edge),
                        height: 50,
                        width: MediaQuery.of(context).size.width - (2 * edge),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapApp(
                                  latStart: latStart,
                                  latEnd: latEnd,
                                  longStart: longStart,
                                  longEnd: longEnd,
                                ),
                              ),
                            );
                          },
                          color: purpleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Text(
                            'Navigate',
                            style: whiteTextStyle.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
