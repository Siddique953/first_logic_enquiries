import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../backend/firebase_storage/storage.dart';
import '../../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';
import '../../../pages/home_page/home.dart';





class EditUniversityDetails extends StatefulWidget {
  final String id;
  final String name;
  final String email;
  final String address;
  final String country;
  final String logo;
  final String banner;
  final List places;
  const EditUniversityDetails({Key key, this.id, this.name, this.email, this.address, this.country, this.logo, this.banner, this.places}) : super(key: key);

  @override
  State<EditUniversityDetails> createState() => _EditUniversityDetailsState();
}

class _EditUniversityDetailsState extends State<EditUniversityDetails> {


  TextEditingController name;
  TextEditingController place;
  TextEditingController address;
  TextEditingController email;
  TextEditingController country;

  String  selectedCountry;

  String logo='';
  String banner='';

List placesList=[];

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
  void initState() {
    // TODO: implement initState
    super.initState();
    placesList=widget.places;
    name=TextEditingController(text: widget.name);
    place=TextEditingController();
    address=TextEditingController(text: widget.address);
    email=TextEditingController(text: widget.email);
    country=TextEditingController(text: widget.country);
    print(placesList.length);
  }

  @override
  Widget build(BuildContext context) {
    return countryList.length==0?CircularProgressIndicator(): AlertDialog(
      title: Center(child: Text('Edit Details'),),
      content: Container(
        width: 1000,
        color: Colors.transparent,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: 330,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: name,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Please Enter First Name',
                                      hintStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder:
                                      UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
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
                                      UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
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
                                    ),
                                    style: FlutterFlowTheme.bodyText2
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            Expanded(
                              child: Container(
                                width: 330,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16, 0, 0, 0),
                                  child: TextFormField(
                                    controller: email,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Please Enter Email',
                                      hintStyle: FlutterFlowTheme
                                          .bodyText2
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      enabledBorder:
                                      UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
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
                                      UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
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
                                    ),
                                    style: FlutterFlowTheme.bodyText2
                                        .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                          child: Row(
                            children: [

                              Expanded(
                                child: Container(
                                  width: 330,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16, 0, 0, 0),
                                    child: TextFormField(
                                      controller: address,
                                      obscureText: false,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        labelText: 'Address',
                                        labelStyle: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'Please Enter Address',
                                        hintStyle: FlutterFlowTheme
                                            .bodyText2
                                            .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
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
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
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
                                      ),
                                      style: FlutterFlowTheme.bodyText2
                                          .override(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),

                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 330,
                                  height: 60,

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Color(0x4D101213),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                    child: CustomDropdown.search(
                                      hintText: 'Select Country',
                                      items: countryList,
                                      controller: country,
                                      excludeSelected: false,

                                      onChanged: (text){

                                        setState(() {


                                        });

                                      },

                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30,),




                            ],
                          ),

                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                          child: Container(
                            width: 450,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x39000000),
                                  offset: Offset(0, 1),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                      child: TextFormField(
                                        controller: place,
                                        onChanged: (text){
                                          setState(() {

                                          });
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Place Name',
                                          hintText: 'Please Enter Place Name',
                                          labelStyle: FlutterFlowTheme
                                              .bodyText2
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF7C8791),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: FlutterFlowTheme
                                            .bodyText1
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF090F13),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                    child: FFButtonWidget(
                                      onPressed: ()  {

                                        if(place.text!=''){
                                          placesList.add(place.text);
                                          setState(() {

                                            place.clear();

                                          });
                                        }else{
                                          showUploadMessage(context, 'Please Enter Place Name...');
                                        }



                                      },
                                      text: 'Add',
                                      options: FFButtonOptions(
                                        width: 100,
                                        height: 40,
                                        color: Color(0xFF4B39EF),
                                        textStyle: FlutterFlowTheme
                                            .subtitle2
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        elevation: 2,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
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
                        placesList.length==0?Text('No Places Added...'):
                        SizedBox(
                          width: 700,
                          child: DataTable(
                            horizontalMargin: 12,
                            columns: [
                              DataColumn(
                                label: Text("Sl No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                              ),

                              DataColumn(
                                label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                              ),




                              DataColumn(
                                label: Text("",style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                            rows: List.generate(
                              placesList.length,
                                  (index) {
                                final history=placesList[index];






                                return DataRow(
                                  color: index.isOdd?MaterialStateProperty.all(Colors.blueGrey.shade50.withOpacity(0.7)):MaterialStateProperty.all(Colors.blueGrey.shade50),

                                  cells: [
                                    DataCell(Text((index+1).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),
                                    DataCell(Text(history,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12))),

                                    DataCell(   Row(
                                      children: [
                                        // Generated code for this Button Widget...
                                        FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 30,
                                          borderWidth: 1,
                                          buttonSize: 50,
                                          icon: Icon(
                                            Icons.delete,
                                            color: Color(0xFFEE0000),
                                            size: 25,
                                          ),
                                          onPressed: () async {
                                            bool pressed=await alert(context, 'Do you want delete Place');

                                            if(pressed){
                                              placesList.removeAt(index);

                                              showUploadMessage(context, 'Place Deleted...');
                                              setState(() {

                                              });

                                            }
                                          },
                                        ),
                                      ],
                                    ),),
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
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 5, 30, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              widget.logo==''?Text('No Logo Uploaded'):
                              CachedNetworkImage(imageUrl: logo==''?widget.logo:logo,height: 80,width: 80,),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                                child: FFButtonWidget(
                                  onPressed: ()  async {
                                    final selectedMedia = await selectMedia(
                                      maxWidth: 1080.00,
                                      maxHeight: 1320.00,
                                    );
                                    if (selectedMedia != null &&
                                        validateFileFormat(
                                            selectedMedia.storagePath, context)) {
                                      showUploadMessage(context, 'Uploading file...',
                                          showLoading: true);
                                      final downloadUrl = await uploadData(
                                          selectedMedia.storagePath,
                                          selectedMedia.bytes);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      if (downloadUrl != null) {
                                        setState(
                                                () {
                                              logo = downloadUrl;
                                            } );
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        showUploadMessage(
                                            context, 'Failed to upload media');
                                      }
                                    }


                                  },
                                  text: 'Change',
                                  options: FFButtonOptions(
                                    width: 110,
                                    height: 30,
                                    color: Color(0xFF4B39EF),
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    elevation: 2,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 10,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(width: 30,),
                          (widget.banner==''&&banner=='')?Column(
                            children: [
                              Text('No Banner Uploaded'),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                                child: FFButtonWidget(
                                  onPressed: ()  async {
                                    final selectedMedia = await selectMedia(
                                      maxWidth: 1080.00,
                                      maxHeight: 1320.00,
                                    );
                                    if (selectedMedia != null &&
                                        validateFileFormat(
                                            selectedMedia.storagePath, context)) {
                                      showUploadMessage(context, 'Uploading file...',
                                          showLoading: true);
                                      final downloadUrl = await uploadData(
                                          selectedMedia.storagePath,
                                          selectedMedia.bytes);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      if (downloadUrl != null) {
                                        setState(
                                                () {
                                              banner = downloadUrl;
                                            } );
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        showUploadMessage(
                                            context, 'Failed to upload media');
                                      }
                                    }

                                  },
                                  text: 'Upload',
                                  options: FFButtonOptions(
                                    width: 110,
                                    height: 30,
                                    color: Color(0xFF4B39EF),
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    elevation: 2,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 10,
                                  ),
                                ),
                              ),
                            ],
                          ):
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              CachedNetworkImage(imageUrl: banner==''?widget.banner:banner,height: 80,width: 80,),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                                child: FFButtonWidget(
                                  onPressed: ()  async {
                                    final selectedMedia = await selectMedia(
                                      maxWidth: 1080.00,
                                      maxHeight: 1320.00,
                                    );
                                    if (selectedMedia != null &&
                                        validateFileFormat(
                                            selectedMedia.storagePath, context)) {
                                      showUploadMessage(context, 'Uploading file...',
                                          showLoading: true);
                                      final downloadUrl = await uploadData(
                                          selectedMedia.storagePath,
                                          selectedMedia.bytes);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      if (downloadUrl != null) {
                                        setState(
                                                () {
                                              banner = downloadUrl;
                                            } );
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        showUploadMessage(
                                            context, 'Failed to upload media');
                                      }
                                    }


                                  },
                                  text: 'Change',
                                  options: FFButtonOptions(
                                    width: 110,
                                    height: 30,
                                    color: Color(0xFF4B39EF),
                                    textStyle: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    elevation: 2,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: 10,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                child: FFButtonWidget(
                  onPressed: () async {
                    print(placesList);
                    if(name.text!=''&&address.text!=''&&email.text!=''
                        ) {
                      FirebaseFirestore.instance.collection('university').doc(widget.id).update({
                        'name':name.text,
                        'address':address.text,
                        'email':email.text,
                        'country':countryIdByName[country.text],
                        'logo':logo==''?widget.logo:logo,
                        'banner':banner==''?widget.banner:banner,
                        'search':setSearchParam(name.text),
                        'places':placesList,
                      });

                      Navigator.pop(context);
                      showUploadMessage(context, 'Details Updated...');

                    }

                  },
                  text: 'Update',
                  options: FFButtonOptions(
                    width: 180,
                    height: 40,
                    color: Color(0xFF4B39EF),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 10,
                  ),
                ),
              ),

            ],),
        ),),
    );
  }
}
