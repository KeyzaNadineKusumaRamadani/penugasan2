import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_online/models/response_data_list.dart';
import 'package:toko_online/models/toko_models.dart';
import 'package:toko_online/models/userlogin.dart';
import 'package:toko_online/services/url.dart' as url;

class TokoService {
  Future getbarang() async {
    UserLogin userLogin = UserLogin();
    var user = await userLogin.getUserLogin();
    if (user.status == false) {
      ResponseDataList response = ResponseDataList(
        status: false,
        message: 'anda belum login / token invalid',
      );
      return response;
    }
    var uri = Uri.parse(url.BaseUrl + "/admin/getbarang");
    Map<String, String> headers = {"Authorization": 'Bearer ${user.token}'};
    var getbarang = await http.get(uri, headers: headers);

    if (getbarang.statusCode == 200) {
      var data = json.decode(getbarang.body);
      print(data);
      if (data["status"] == true) {
        List barang = data["data"].map((r) => TokoModel.fromJson(r)).toList();
        ResponseDataList response = ResponseDataList(
          status: true,
          message: 'success load data',
          data: barang,
        );
        return response;
      } else {
        ResponseDataList response = ResponseDataList(
          status: false,
          message: 'Failed load data',
        );
        return response;
      }
    } else {
      ResponseDataList response = ResponseDataList(
        status: false,
        message: "gagal load barang dengan code error ${getbarang.statusCode}",
      );
      return response;
    }
  }
}
