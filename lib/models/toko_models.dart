import 'package:toko_online/services/url.dart' as url;

class TokoModel {
  int? id;
  String? namaBarang;
  String? deskripsi;
  int? stok;
  int? harga;
  String? image;

  TokoModel({
    this.id,
    this.namaBarang,
    this.deskripsi,
    this.stok,
    this.harga,
    this.image,
  });

  TokoModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    namaBarang = parsedJson["nama_barang"];
    deskripsi = parsedJson["deskripsi"];
    stok = parsedJson["stok"];
    harga = parsedJson["harga"];
    image = "${url.BaseUrlTanpaAPi}/${parsedJson["image"]}"; 
  }
}
