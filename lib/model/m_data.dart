import 'package:firebase_database/firebase_database.dart';

class Data {
  var arus;
  var arusAvg;
  var arusMax;
  var arusMin;

  var daya;
  var dayaAvg;
  var dayaMax;
  var dayaMin;

  var humidity;
  var intensitas;
  var statusControl;

  var tegangan;
  var teganganAvg;
  var teganganAvgMax;
  var teganganAvgMin;

  var tekanan;
  var temperatur;

  Data(
  this.arus,
  this.arusAvg,
  this.arusMax,
  this.arusMin,
  this.daya,
  this.dayaAvg,
  this.dayaMax,
  this.dayaMin,
  this.humidity,
  this.intensitas,
  this.statusControl,
  this.tegangan,
  this.teganganAvg,
  this.teganganAvgMax,
  this.teganganAvgMin,
  this.tekanan,
  this.temperatur);

  Data.fromSnapshot(DataSnapshot snapshot)
      :
        arus = snapshot.value["Arus"],
        arusAvg = snapshot.value["ArusAvg"],
        arusMax = snapshot.value["ArusMax"],
        arusMin = snapshot.value["ArusMin"],

        daya = snapshot.value["Daya"],
        dayaAvg = snapshot.value["DayaAvg"],
        dayaMax = snapshot.value["DayaMax"],
        dayaMin = snapshot.value["DayaMin"],

        humidity = snapshot.value["Humidity"],
        intensitas = snapshot.value["Intensitas"],
        statusControl = snapshot.value["StatusControl"],

        tegangan = snapshot.value["Tegangan"],
        teganganAvg = snapshot.value["TeganganAvg"],
        teganganAvgMax = snapshot.value["TeganganAvgMax"],
        teganganAvgMin = snapshot.value["TeganganAvgMin"],

        tekanan = snapshot.value["Tekanan"],
        temperatur = snapshot.value["Temperatur"];

  toJson() {
    /*return {
      "key": key,
      "firstName": firstName,
      "lastName": lastName,
    };*/
  }
}