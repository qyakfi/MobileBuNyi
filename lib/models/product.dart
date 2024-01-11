import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bunyicake/constant/constant.dart';

class Product {
  final String id_kue;
  final String nama;
  final String harga;
  final String tersedia;
  final String keterangan;
  final String gambar;

  const Product({required this.id_kue, required this.nama, required this.harga, required this.tersedia, required this.keterangan, required this.gambar});

  Map<String, String> toJson() {
    return {
      FirestoreConstants.id_kue: id_kue,
      FirestoreConstants.nama: nama,
      FirestoreConstants.harga: harga,
      FirestoreConstants.tersedia: tersedia,
      FirestoreConstants.keterangan: keterangan,
      FirestoreConstants.gambar: gambar,
    };
  }

  factory Product.fromDocument(DocumentSnapshot doc) {
    String nama = "";
    String harga = "";
    String tersedia = "";
    String keterangan = "";
    String gambar = "";
    try {
      nama = doc.get(FirestoreConstants.nama);
    } catch (e) {}
    try {
      harga = doc.get(FirestoreConstants.harga);
    } catch (e) {}
    try {
      tersedia = doc.get(FirestoreConstants.tersedia);
    } catch (e) {}
    try {
      keterangan = doc.get(FirestoreConstants.keterangan);
    } catch (e) {}
    try {
      keterangan = doc.get(FirestoreConstants.gambar);
    } catch (e) {}
    return Product(
      id_kue: doc.id,
      nama: nama,
      harga: harga,
      tersedia: tersedia,
      keterangan: keterangan,
      gambar: gambar,
    );
  }
}