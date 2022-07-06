import 'dart:async';
import 'dart:convert';
import 'package:find_hospital/pages/map/map_var.dart';
import 'package:http/http.dart' as http;

class RSModel {
  bool? status;
  List<Data>? data;
  String? message;

  RSModel({this.status, this.data, this.message});

  factory RSModel.fromJson(Map<String, dynamic> json) {
    List<Data> dataArray = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataArray.add(Data.fromJson(v));
      });
    }
    // ignore: avoid_print
    // print("Balikan Data : " + dataArray.toString());
    return RSModel(
        status: json['status'], data: dataArray, message: json['message']);
  }

  static Future<RSModel> getData() async {
    var endpoint = Uri.parse(MapVariable.baseURL + "/api");

    var apiResult = await http.get(endpoint);
    var jsonObject = json.decode(apiResult.body);
    return RSModel.fromJson(jsonObject);
  }

  static Future<RSModel> getDataById(String id) async {
    var endpoint = Uri.parse(MapVariable.baseURL + "/api/" + id);

    var apiResult = await http.get(endpoint);
    var jsonObject = json.decode(apiResult.body);
    return RSModel.fromJson(jsonObject);
  }
}

class Data {
  int? id;
  String? idKategori;
  String? nama;
  String? kota;
  String? alamat;
  String? lat;
  String? long;
  String? idRs;
  String? foto;

  Data({
    this.id,
    this.idKategori,
    this.nama,
    this.kota,
    this.alamat,
    this.lat,
    this.long,
    this.idRs,
    this.foto,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idKategori = json['id_kategori'];
    nama = json['nama'];
    kota = json['kota'];
    alamat = json['alamat'];
    lat = json['lat'];
    long = json['long'];
    idRs = json['id_rs'];
    foto = json['foto'];
  }
}
