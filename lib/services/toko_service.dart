import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_online/models/response_data_list.dart';
import 'package:toko_online/models/response_data_map.dart';
import 'package:toko_online/models/toko_models.dart';
import 'package:toko_online/models/userlogin.dart';
import 'package:toko_online/services/url.dart' as url;

class TokoService {

  // ================= GET BARANG =================
  Future getbarang() async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();

    if (user.status == false) {
      return ResponseDataList(
        status: false,
        message: 'anda belum login / token invalid',
      );
    }

    var uri = Uri.parse(url.BaseUrl + "/admin/getbarang");

    var res = await http.get(uri, headers: {
      "Authorization": 'Bearer ${user.token}'
    });

    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      if (data["status"] == true) {
        List barang =
            data["data"].map((r) => TokoModel.fromJson(r)).toList();

        return ResponseDataList(
          status: true,
          message: 'success load data',
          data: barang,
        );
      }
    }

    return ResponseDataList(
      status: false,
      message: "gagal load barang",
    );
  }

  // ================= INSERT & UPDATE =================
  Future insertBarang(request, image, id) async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();

    if (user.status == false) {
      return ResponseDataMap(
        status: false,
        message: 'anda belum login / token invalid',
      );
    }

    var reponse;

    if (id == null) {
      reponse = http.MultipartRequest(
        'POST',
        Uri.parse("${url.BaseUrl}/admin/insertbarang"),
      );
    } else {
      reponse = http.MultipartRequest(
        'POST',
        Uri.parse("${url.BaseUrl}/admin/updatebarang/$id"),
      );
    }

    // ✅ HEADER (FIX: tanpa content-type)
    reponse.headers.addAll({
      "Authorization": 'Bearer ${user.token}',
    });

    // ✅ FIELD (FIX: biar tidak null)
    reponse.fields['nama_barang'] = request["nama_barang"] ?? "";
    reponse.fields['stok'] = request["stok"].toString();
    reponse.fields['harga'] = request["harga"].toString();
    reponse.fields['deskripsi'] = request["deskripsi"] ?? "";

    // ✅ IMAGE (logika tetap sama)
    if (image != null) {
      reponse.files.add(
        http.MultipartFile(
          'image',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: image.path.split('/').last,
        ),
      );
    }

    var res = await reponse.send();
    var result = await http.Response.fromStream(res);

    print("STATUS CODE: ${res.statusCode}");
    print("BODY: ${result.body}");

    if (res.statusCode == 200) {
      var data = json.decode(result.body);

      if (data["status"] == true) {
        return ResponseDataMap(
          status: true,
          message: 'success insert / update data',
        );
      } else {
        return ResponseDataMap(
          status: false,
          message: data["message"] ?? 'Failed insert / update data',
        );
      }
    }

    return ResponseDataMap(
      status: false,
      message: "error ${res.statusCode}",
    );
  }

  // ================= HAPUS =================
  Future hapusbarang(context, id) async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();

    if (user.status == false) {
      return ResponseDataList(
        status: false,
        message: 'anda belum login / token invalid',
      );
    }

    var uri = Uri.parse("${url.BaseUrl}/admin/hapusbarang/$id");

    var res = await http.delete(uri, headers: {
      "Authorization": 'Bearer ${user.token}',
    });

    print("HAPUS STATUS: ${res.statusCode}");
    print("HAPUS BODY: ${res.body}");

    if (res.statusCode == 200) {
      var data = json.decode(res.body);

      if (data["status"] == true) {
        return ResponseDataList(
          status: true,
          message: 'success hapus data',
        );
      } else {
        return ResponseDataList(
          status: false,
          message: data["message"] ?? 'Failed hapus data',
        );
      }
    }

    return ResponseDataList(
      status: false,
      message: "error ${res.statusCode}",
    );
  }
}