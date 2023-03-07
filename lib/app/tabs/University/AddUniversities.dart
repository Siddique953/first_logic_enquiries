import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../../../backend/firebase_storage/storage.dart';
import '../../../backend/schema/index.dart';
import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';

class AddUniversity extends StatefulWidget {
  const AddUniversity({Key key}) : super(key: key);

  @override
  _AddUniversityState createState() => _AddUniversityState();
}

class _AddUniversityState extends State<AddUniversity> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController name;
  TextEditingController place;
  TextEditingController email;
  TextEditingController address;
  TextEditingController image;
  String logo = '';
  String banner = '';
  bool edit = false;
  String currentId = '';
  String dropDownValue;
  String currentName = '';
  String currentImage = '';

  List placesList = [];

  //while editing
  TextEditingController eName;
  TextEditingController eEmail;
  TextEditingController eImage;
  TextEditingController eAddress;
  String eUploadedFileUrl1 = '';
  List<String> countryList = [];
  Map<String, dynamic> countryNameById = {};
  Map<String, dynamic> countryIdByName = {};
  getCountry() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('country').get();
    if (snap.docs.isNotEmpty) {
      countryList = [];
      for (DocumentSnapshot doc in snap.docs) {
        countryList.add(doc.get('name'));
        countryNameById[doc.id] = doc['name'];
        countryIdByName[doc['name']] = doc.id;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  List data = [];

  @override
  void initState() {
    super.initState();
    getCountry();
    name = TextEditingController();
    place = TextEditingController();
    email = TextEditingController();
    address = TextEditingController();
    eName = TextEditingController(text: currentName);
    eEmail = TextEditingController(text: currentName);
    image = TextEditingController(text: logo);
    eImage = TextEditingController(text: eUploadedFileUrl1);
    eAddress = TextEditingController();
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = List<String>();
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }

  @override
  Widget build(BuildContext context) {
    return countryList.length == 0
        ? Container(
            color: Colors.white,
            child: Center(
              child: Image.asset('assets/images/loading.gif'),
            ))
        : Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'University',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: name,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Name',
                                                      labelStyle:
                                                          FlutterFlowTheme
                                                              .bodyText1
                                                              .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText:
                                                          'Please Enter University Name',
                                                      hintStyle:
                                                          FlutterFlowTheme
                                                              .bodyText1
                                                              .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: email,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Email',
                                                      labelStyle:
                                                          FlutterFlowTheme
                                                              .bodyText1
                                                              .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      hintText:
                                                          'Please Enter University Email',
                                                      hintStyle:
                                                          FlutterFlowTheme
                                                              .bodyText1
                                                              .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF252525),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  4.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  4.0),
                                                        ),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    style: FlutterFlowTheme
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: address,
                                              obscureText: false,
                                              maxLines: 2,
                                              decoration: InputDecoration(
                                                labelText: 'Address',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                ),
                                                hintText:
                                                    'Please Enter University Address',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText1
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF252525),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF252525),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: FlutterFlowDropDown(
                                                  initialOption:
                                                      dropDownValue ??
                                                          countryList.first,
                                                  options: countryList,
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          dropDownValue = val),
                                                  width: 220,
                                                  height: 50,
                                                  textStyle: FlutterFlowTheme
                                                      .bodyText1
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                  ),
                                                  hintText: 'Please select...',
                                                  icon: FaIcon(
                                                    FontAwesomeIcons
                                                        .globeAfrica,
                                                  ),
                                                  fillColor: Colors.white,
                                                  elevation: 2,
                                                  borderColor: Colors.black,
                                                  borderWidth: 0,
                                                  borderRadius: 0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(10, 4, 12, 4),
                                                  hidesUnderline: true,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 0, 20),
                                                child: Container(
                                                  width: 450,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 3,
                                                        color:
                                                            Color(0x39000000),
                                                        offset: Offset(0, 1),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                4, 4, 0, 4),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4,
                                                                        0,
                                                                        4,
                                                                        0),
                                                            child:
                                                                TextFormField(
                                                              controller: place,
                                                              onChanged:
                                                                  (text) {
                                                                setState(() {});
                                                              },
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Place Name',
                                                                hintText:
                                                                    'Please Enter Place Name',
                                                                labelStyle:
                                                                    FlutterFlowTheme
                                                                        .bodyText2
                                                                        .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Color(
                                                                      0xFF7C8791),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0x00000000),
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFF090F13),
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 8, 0),
                                                          child: FFButtonWidget(
                                                            onPressed: () {
                                                              if (place.text !=
                                                                  '') {
                                                                placesList.add(
                                                                    place.text);
                                                                setState(() {
                                                                  place.clear();
                                                                });
                                                              } else {
                                                                showUploadMessage(
                                                                    context,
                                                                    'Please Enter Place Name...');
                                                              }
                                                            },
                                                            text: 'Add',
                                                            options:
                                                                FFButtonOptions(
                                                              width: 100,
                                                              height: 40,
                                                              color: Color(
                                                                  0xFF4B39EF),
                                                              textStyle:
                                                                  FlutterFlowTheme
                                                                      .subtitle2
                                                                      .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                              elevation: 2,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1,
                                                              ),
                                                              borderRadius: 50,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          placesList.length == 0
                                              ? Text('No Places Added...')
                                              : SizedBox(
                                                  width: 700,
                                                  child: DataTable(
                                                    horizontalMargin: 12,
                                                    columns: [
                                                      DataColumn(
                                                        label: Text(
                                                          "Sl No",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text(
                                                          "Name",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      DataColumn(
                                                        label: Text("",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                    rows: List.generate(
                                                      placesList.length,
                                                      (index) {
                                                        final history =
                                                            placesList[index];

                                                        return DataRow(
                                                          color: index.isOdd
                                                              ? MaterialStateProperty
                                                                  .all(Colors
                                                                      .blueGrey
                                                                      .shade50
                                                                      .withOpacity(
                                                                          0.7))
                                                              : MaterialStateProperty
                                                                  .all(Colors
                                                                      .blueGrey
                                                                      .shade50),
                                                          cells: [
                                                            DataCell(Text(
                                                                (index + 1)
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12))),
                                                            DataCell(Text(
                                                                history,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12))),

                                                            DataCell(
                                                              Row(
                                                                children: [
                                                                  // Generated code for this Button Widget...
                                                                  FlutterFlowIconButton(
                                                                    borderColor:
                                                                        Colors
                                                                            .transparent,
                                                                    borderRadius:
                                                                        30,
                                                                    borderWidth:
                                                                        1,
                                                                    buttonSize:
                                                                        50,
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Color(
                                                                          0xFFEE0000),
                                                                      size: 25,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      bool pressed = await alert(
                                                                          context,
                                                                          'Do you want delete Place');

                                                                      if (pressed) {
                                                                        placesList
                                                                            .removeAt(index);

                                                                        showUploadMessage(
                                                                            context,
                                                                            'Place Deleted...');
                                                                        setState(
                                                                            () {});
                                                                      }
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // DataCell(Text(fileInfo.size)),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            banner == ''
                                                ? Text('Please Upload Banner')
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                        height: 100,
                                                        width: 100,
                                                        child:
                                                            CachedNetworkImage(
                                                                imageUrl:
                                                                    banner)),
                                                  ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                final selectedMedia =
                                                    await selectMedia(
                                                  maxWidth: 1080.00,
                                                  maxHeight: 1320.00,
                                                );
                                                if (selectedMedia != null &&
                                                    validateFileFormat(
                                                        selectedMedia
                                                            .storagePath,
                                                        context)) {
                                                  showUploadMessage(context,
                                                      'Uploading file...',
                                                      showLoading: true);
                                                  final downloadUrl =
                                                      await uploadData(
                                                          selectedMedia
                                                              .storagePath,
                                                          selectedMedia.bytes);
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  if (downloadUrl != null) {
                                                    setState(() {
                                                      banner = downloadUrl;
                                                    });
                                                    showUploadMessage(
                                                        context, 'Success!');
                                                  } else {
                                                    showUploadMessage(context,
                                                        'Failed to upload media');
                                                  }
                                                }
                                              },
                                              text: banner == ''
                                                  ? 'Upload Banner'
                                                  : 'Change Banner',
                                              options: FFButtonOptions(
                                                width: 130,
                                                height: 40,
                                                color: secondaryColor,
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            logo == ''
                                                ? Text('Please Upload Logo')
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                        height: 100,
                                                        width: 100,
                                                        child:
                                                            CachedNetworkImage(
                                                                imageUrl:
                                                                    logo)),
                                                  ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                final selectedMedia =
                                                    await selectMedia(
                                                  maxWidth: 1080.00,
                                                  maxHeight: 1320.00,
                                                );
                                                if (selectedMedia != null &&
                                                    validateFileFormat(
                                                        selectedMedia
                                                            .storagePath,
                                                        context)) {
                                                  showUploadMessage(context,
                                                      'Uploading file...',
                                                      showLoading: true);
                                                  final downloadUrl =
                                                      await uploadData(
                                                          selectedMedia
                                                              .storagePath,
                                                          selectedMedia.bytes);
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  if (downloadUrl != null) {
                                                    setState(() {
                                                      logo = downloadUrl;
                                                      image.text = logo;
                                                    });
                                                    showUploadMessage(
                                                        context, 'Success!');
                                                  } else {
                                                    showUploadMessage(context,
                                                        'Failed to upload media');
                                                  }
                                                }
                                              },
                                              text: logo == ''
                                                  ? 'Upload Logo'
                                                  : 'Change Logo',
                                              options: FFButtonOptions(
                                                width: 130,
                                                height: 40,
                                                color: secondaryColor,
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        print(countryIdByName[dropDownValue]);

                                        if (name.text != '' &&
                                            email.text != '' &&
                                            address.text != '' &&
                                            logo != '' &&
                                            dropDownValue != '') {
                                          bool proceed = await alert(context,
                                              'You want to Add this University?');

                                          if (proceed) {
                                            FirebaseFirestore.instance
                                                .collection('university')
                                                .add({
                                              'name': name.text,
                                              'email': email.text,
                                              'address': address.text,
                                              'logo': logo,
                                              'banner': banner,
                                              'country': countryIdByName[
                                                  dropDownValue],
                                              'search':
                                                  setSearchParam(name.text),
                                              'courses': [],
                                              'form': [],
                                              'places': placesList,
                                            });
                                            showUploadMessage(context,
                                                'New University Added...!');
                                            setState(() {
                                              logo = '';
                                              name.text = '';
                                              image.text = '';
                                              banner = '';
                                              address.text = '';
                                              email.text = '';
                                              placesList = [];
                                            });
                                          }
                                        } else {
                                          name.text == ''
                                              ? showUploadMessage(context,
                                                  "Please Enter University name")
                                              : email.text == ''
                                                  ? showUploadMessage(context,
                                                      "Please Enter University Email")
                                                  : address.text == ''
                                                      ? showUploadMessage(
                                                          context,
                                                          "Please Enter University Address")
                                                      : dropDownValue == ''
                                                          ? showUploadMessage(
                                                              context,
                                                              "Please Choose Country")
                                                          : showUploadMessage(
                                                              context,
                                                              'Please Upload Logo');
                                        }
                                      },
                                      text: 'Add University',
                                      options: FFButtonOptions(
                                        width: 180,
                                        height: 50,
                                        color: secondaryColor,
                                        textStyle:
                                            FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
