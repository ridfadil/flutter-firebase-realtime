
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot/utils/colors.dart';
import 'package:iot/utils/text_styles.dart';
import 'package:iot/utils/ui_helpers.dart';
import 'package:iot/widgets/sexy_tile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_switch/material_switch.dart';

class MonitoringPage extends StatefulWidget {
  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  List<String> itemContent = [
    'Monitoring Solar',
    'Credits',
    'Credits',
    'This app would not have been possible without the Flutter framework, the open source projects that I\'ve used and the tireless efforts of developers and contributors in the Flutter community. \n\nPlease see the README.md file in the repository below for more details.',
  ]; //the text in the tile



  FirebaseDatabase database = new FirebaseDatabase();
  List<String> switchOptions = ["Otomatis", "Manual"];
  String selectedSwitchOption = "Otomatis";

  var arus="";
  var arusAvg="";
  var arusMax="";
  var arusMin="";


  var daya="";
  var dayaAvg="";
  var dayaMax="";
  var dayaMin="";

  var humidity="";
  var intensitas="";
  var statusControl="";

  var tegangan="";
  var teganganAvg="";
  var teganganAvgMax="";
  var teganganAvgMin="";

  var tekanan="";
  var temperatur="";
  var device="";
  var status="";

  bool isLoading=true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    await database.reference().child('Arus').once().then((DataSnapshot snapshot) {
      arus = snapshot.value.toString();
    });
    await database.reference().child('ArusAvg').once().then((DataSnapshot snapshot) {
      arusAvg = snapshot.value.toString();
    });
    await database.reference().child('ArusMax').once().then((DataSnapshot snapshot) {
      arusMax = snapshot.value.toString();
    });
    await database.reference().child('ArusMin').once().then((DataSnapshot snapshot) {
      arusMin = snapshot.value.toString();
    });
    await database.reference().child('Daya').once().then((DataSnapshot snapshot) {
      daya = snapshot.value.toString();
    });
    await database.reference().child('DayaAvg').once().then((DataSnapshot snapshot) {
      dayaAvg = snapshot.value.toString();
    });
    await database.reference().child('DayaMax').once().then((DataSnapshot snapshot) {
      dayaMax = snapshot.value.toString();
    });
    await database.reference().child('DayaMin').once().then((DataSnapshot snapshot) {
      dayaMin = snapshot.value.toString();
    });
    await database.reference().child('Humidity').once().then((DataSnapshot snapshot) {
      humidity = snapshot.value.toString();
    });
    await database.reference().child('Intensitas').once().then((DataSnapshot snapshot) {
      intensitas = snapshot.value.toString();
    });
    await database.reference().child('StatusControl').once().then((DataSnapshot snapshot) {
      statusControl = snapshot.value.toString();
      if(statusControl == "1"){
        selectedSwitchOption = "Otomatis";
      }else{
        selectedSwitchOption = "Manual";
      }
    });
    await database.reference().child('Tegangan').once().then((DataSnapshot snapshot) {
      tegangan = snapshot.value.toString();
    });
    await database.reference().child('TeganganAvg').once().then((DataSnapshot snapshot) {
      teganganAvg = snapshot.value.toString();
    });
    await database.reference().child('TeganganMax').once().then((DataSnapshot snapshot) {
      teganganAvgMax = snapshot.value.toString();
    });
    await database.reference().child('TeganganMin').once().then((DataSnapshot snapshot) {
      teganganAvgMin = snapshot.value.toString();
    });
    await database.reference().child('Tekanan').once().then((DataSnapshot snapshot) {
      tekanan = snapshot.value.toString();
    });
    await database.reference().child('Temperatur').once().then((DataSnapshot snapshot) {
      temperatur = snapshot.value.toString();
    });
    await database.reference().child('Devices').once().then((DataSnapshot snapshot) {
      device = snapshot.value.toString();
    });
    await database.reference().child('Status').once().then((DataSnapshot snapshot) {
      status = snapshot.value.toString();
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String tanggal = DateFormat('dd MMM yyyy').format(now);
    String pukul = DateFormat('kk:mm:ss').format(now);
    return Scaffold(
      backgroundColor: invertInvertColorsStrong(context),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                top: 50.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(EvaIcons.arrowIosBack),
                    tooltip: 'Kembali',
                    color: invertColorsStrong(context),
                    iconSize: 26.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    flex: 1,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Monitoring Solar',
                        style: isThemeCurrentlyDark(context)
                            ? TitleStylesDefault.white
                            : TitleStylesDefault.black,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(right: 20),
                      child: IconButton(
                          icon: Icon(Icons.refresh),
                        onPressed: (){
                            setState(() {
                              isLoading = true;
                            });
                            getData();
                        },
                      )
                  )
                ],
              ),
            ),isLoading ? Center(
              child: Container(
                  margin: EdgeInsets.only(top: 150,bottom: 30),
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Load Data, Silahkan tunggu..."))
                    ],
                  )),
            ) :
            Expanded(
              child: ListView(
                children: <Widget>[
                  Hero(
                    tag: 'tile2',
                    child: SexyTile(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('assets/credits/urmil.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Tyo Muhamad Nur',
                                  style: isThemeCurrentlyDark(context)
                                      ? BodyStylesDefault.white
                                      : BodyStylesDefault.black,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Tanggal : $tanggal",
                                        style: isThemeCurrentlyDark(context)
                                            ? BodyStylesDefault.white
                                            : BodyStylesDefault.black,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Pukul : $pukul',
                                        style: isThemeCurrentlyDark(context)
                                            ? BodyStylesDefault.white
                                            : BodyStylesDefault.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            /*Text(
                              'Urmil Shroff',
                              style: isThemeCurrentlyDark(context)
                                  ? LabelStyles.white
                                  : LabelStyles.black,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    EvaIcons.person,
                                    color: invertColorsMild(context),
                                    size: 24.0,
                                  ),
                                  onPressed: () =>
                                      launchURL('https://urmilshroff.tech/'),
                                ),
                                IconButton(
                                  icon: Icon(
                                    EvaIcons.twitter,
                                    color: MyColors.twitter,
                                    size: 26.0,
                                  ),
                                  onPressed: () => launchURL(
                                      'https://twitter.com/urmilshroff'),
                                ),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                      splashColor: MyColors.accent,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SexyTile(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Suhu\n(C)",
                                  style: HeadingStylesDefault.accent,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  temperatur??"-",
                                  style: isThemeCurrentlyDark(context)
                                      ? HeadingStylesDefault.white
                                      : HeadingStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          splashColor: MyColors.accent,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SexyTile(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Kelembaban\n(%)",
                                  style: HeadingStylesDefault.accent,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  humidity??"-",
                                  style: isThemeCurrentlyDark(context)
                                      ? HeadingStylesDefault.white
                                      : HeadingStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          splashColor: MyColors.accent,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SexyTile(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Tegangan\n(Volt)",
                                  style: HeadingStylesDefault.accent,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  tegangan??"-",
                                  style: isThemeCurrentlyDark(context)
                                      ? HeadingStylesDefault.white
                                      : HeadingStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "Avg : 1$teganganAvg\nMin : $teganganAvgMin\nMax : $teganganAvgMax",
                                  style: isThemeCurrentlyDark(context)
                                      ? BodyStylesDefault.white
                                      : BodyStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                          splashColor: MyColors.accent,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SexyTile(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Arus\n(Amps)",
                                  style: HeadingStylesDefault.accent,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  arus??"-",
                                  style: isThemeCurrentlyDark(context)
                                      ? HeadingStylesDefault.white
                                      : HeadingStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "Avg : $arusAvg\nMin : $arusMin\nMax : $arusMax",
                                  style: isThemeCurrentlyDark(context)
                                      ? BodyStylesDefault.white
                                      : BodyStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                          splashColor: MyColors.accent,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SexyTile(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Daya\n(Watt)",
                                  style: HeadingStylesDefault.accent,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  daya??"-",
                                  style: isThemeCurrentlyDark(context)
                                      ? HeadingStylesDefault.white
                                      : HeadingStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "Avg : $dayaAvg\nMin : $dayaMin\nMax : $dayaMax",
                                  style: isThemeCurrentlyDark(context)
                                      ? BodyStylesDefault.white
                                      : BodyStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                          splashColor: MyColors.accent,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SexyTile(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Intensitas\n(Lux)",
                                  style: HeadingStylesDefault.accent,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  intensitas??"-",
                                  style: isThemeCurrentlyDark(context)
                                      ? HeadingStylesDefault.white
                                      : HeadingStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          splashColor: MyColors.accent,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SexyTile(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Tekanan\n(Pa)",
                                  style: HeadingStylesDefault.accent,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Text(
                                  tekanan??"-",
                                  style: isThemeCurrentlyDark(context)
                                      ? HeadingStylesDefault.white
                                      : HeadingStylesDefault.black,
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          splashColor: MyColors.accent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  MaterialSwitch(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(5.0),
                    selectedOption: selectedSwitchOption,
                    options: switchOptions,
                    selectedBackgroundColor: Colors.indigo,
                    selectedTextColor: Colors.white,
                    onSelect: (String selectedOption) {
                      setState(() {
                        selectedSwitchOption = selectedOption;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: Icon(
          EvaIcons.github,
          size: 36.0,
        ),
        tooltip: 'View GitHub repo',
        foregroundColor: invertInvertColorsStrong(context),
        backgroundColor: invertColorsStrong(context),
        elevation: 5.0,
        onPressed: () =>
            launchURL('https://github.com/urmilshroff/dashboard_reborn'),
      ),*/
    );
  }
}
