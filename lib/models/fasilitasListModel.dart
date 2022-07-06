import 'dart:async';
import 'dart:convert';
import 'package:find_hospital/pages/map/map_var.dart';
import 'package:http/http.dart' as http;

class FasilitasListModel {
  bool? status;
  List<Data>? data;
  String? message;

  FasilitasListModel({this.status, this.data, this.message});

  factory FasilitasListModel.fromJson(Map<String, dynamic> json) {
    List<Data> dataArray = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataArray.add(Data.fromJson(v));
      });
    }
    // ignore: avoid_print
    // print("Balikan Data : " + dataArray.toString());
    return FasilitasListModel(
        status: json['status'], data: dataArray, message: json['message']);
  }

  // pastikan kirim id
  static Future<FasilitasListModel> getDataById(String id) async {
    var endpoint = Uri.parse(MapVariable.baseURL + "/api/fasilitasList/" + id);

    var apiResult = await http.get(endpoint);
    var jsonObject = json.decode(apiResult.body);
    return FasilitasListModel.fromJson(jsonObject);
  }
}

class Data {
  int? id;
  String? idRsApotek;
  String? idFasilitas;
  String? keterangan;
  String? nama;
  String? foto;

  Data({
    this.id,
    this.idRsApotek,
    this.idFasilitas,
    this.keterangan,
    this.nama,
    this.foto,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRsApotek = json['id_rs_apotek'];
    idFasilitas = json['id_fasilitas'];
    keterangan = json['keterangan'];
    nama = json['nama'];
    foto = json['foto'];
  }
}
