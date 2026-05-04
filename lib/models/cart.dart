class Cart {
  late final int? id;
  final String? id_barang;
  final String? nama_barang;
  int? quantity = 0;
  final String? deskripsi;
  int? harga = 0;
  final String? image;


  Cart({
    required this.id,
    required this.id_barang,
    required this.nama_barang,
    required this.quantity,
    required this.deskripsi,
    required this.harga,
    required this.image,
  });


  factory Cart.fromMap(Map<dynamic, dynamic> data) {
    return Cart(
      id: data['id'],
      id_barang: data['id_barang'].toString(),
      nama_barang: data['nama_barang'],
      quantity: int.parse(data['quantity'].toString()),
      deskripsi: data['deskripsi'],
      harga: int.parse(data['harga'].toString()),
      image: data['image'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_barang': id_barang,
      'nama_barang': nama_barang,
      'quantity': quantity,
      'deskripsi': deskripsi,
      'harga': harga,
      'image': image,
    };
  }
}
