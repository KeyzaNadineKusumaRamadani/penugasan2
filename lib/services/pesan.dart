import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_online/models/response_data_list.dart';
import 'package:toko_online/models/response_data_map.dart';
import 'package:toko_online/models/userlogin.dart';
import 'package:toko_online/services/url.dart' as url;



class Pesan {
  UserLogin userLogin = UserLogin();
  Future saveToDB(dataRequest) async {
    var uri = Uri.parse(url.BaseUrl + "/user/transaksi");
    var user = await userLogin.getUserLogin();
    if (user.status == false) {
      ResponseDataMap response = ResponseDataMap(
        status: false,
        message: 'anda belum login / token invalid',
      );
      return response;
    }
    Map<String, String> headers = {
      "Authorization": 'Bearer ${user.token}',
      'Content-Type': "application/json",
    };
    try {
      var simpanPesan = await http.post(
        uri,
        body: json.encode(dataRequest),
        headers: headers,
      );
      var data = json.decode(simpanPesan.body);
      print(data["message"]);

      if (simpanPesan.statusCode == 200) {
        if (data["status"] == true) {
          ResponseDataMap response = ResponseDataMap(
            status: true,
            message: "Sukses melakukan pemesanan",
          );
          return response;
        } else {
          ResponseDataMap response = ResponseDataMap(
            status: false,
            message: data["message"],
          );
          return response;
        }
      } else {
        print("${simpanPesan.statusCode}");
        ResponseDataMap response = ResponseDataMap(
          status: false,
          message:
              "gagal melakukan pemesanan dengan code error ${simpanPesan.statusCode}",
        );
        return response;
      }
    } catch (e) {
      print(e);
      ResponseDataMap response = ResponseDataMap(
        status: false,
        message: "fatal error ${e}",
      );
      return response;
    }

  }
  Future getHistory() async {
    var uri = Uri.parse(url.BaseUrl + "/user/history_trans");
    var user = await userLogin.getUserLogin();
    if (user.status == false) {
      ResponseDataMap response = ResponseDataMap(
        status: false,
        message: 'anda belum login / token invalid',
      );
      return response;
    }
    Map<String, String> headers = {"Authorization": 'Bearer ${user.token}'};
    try {
      var getHistory = await http.get(uri, headers: headers);
      var data = json.decode(getHistory.body);
      print(data["status"]);

      if (getHistory.statusCode == 200) {
        if (data["status"] == true) {
          if (data.containsKey('data') && data['data'] is List) {
           var filteredData = (data['data'] as List).where((item) => item['nama_user'] == user.nama_user).toList();
            data['data'] = filteredData;
          }
          ResponseDataList response = ResponseDataList(
            status: true,
            message: "Sukses mendapatkan history",
            data: data["data"],
          );
          return response;
        } else {
          ResponseDataList response = ResponseDataList(
            status: false,
            message: data["message"],
            data: [],
          );
          return response;
        }
      } else {
        print("${getHistory.statusCode}");
        ResponseDataList response = ResponseDataList(
          status: false,
          message:
              "gagal mendapatkan history dengan code error ${getHistory.statusCode}",
          data: [],
        );
        return response;
      }
    } catch (e) {
      print(e);
      ResponseDataList response = ResponseDataList(
        status: false,
        message: "fatal error ${e}",
        data: [],
      );
      return response;
    }
  }
}
