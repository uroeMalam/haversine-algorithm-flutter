import 'dart:async';
import 'dart:convert';
import 'package:find_hospital/pages/map/map_var.dart';
import 'package:http/http.dart' as http;

class ImagesCarouselModel {
  bool? status;
  List<Data>? data;
  String? message;

  ImagesCarouselModel({this.status, this.data, this.message});

  factory ImagesCarouselModel.fromJson(Map<String, dynamic> json) {
    List<Data> dataArray = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataArray.add(Data.fromJson(v));
      });
    }
    // ignore: avoid_print
    // print("Balikan Data : " + dataArray.toString());
    return ImagesCarouselModel(
        status: json['status'], data: dataArray, message: json['message']);
  }

  // pastikan kirim id
  static Future<ImagesCarouselModel> getDataById(String id) async {
    var endpoint = Uri.parse(MapVariable.baseURL + "/api/imagesCarousel/" + id);

    var apiResult = await http.get(endpoint);
    var jsonObject = json.decode(apiResult.body);
    return ImagesCarouselModel.fromJson(jsonObject);
  }
}

class Data {
  int? id;
  String? idRs;
  String? foto;

  Data({
    this.id,
    this.idRs,
    this.foto,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRs = json['id_rs'];
    foto = json['foto'];
  }
}
