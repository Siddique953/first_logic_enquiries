
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../backend/firebase_storage/storage.dart';
import '../../../backend/schema/index.dart';
import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';

class AddCountryWidget extends StatefulWidget {
  const AddCountryWidget({Key key}) : super(key: key);

  @override
  _AddCountryWidgetState createState() => _AddCountryWidgetState();
}

class _AddCountryWidgetState extends State<AddCountryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool edit=false;
  TextEditingController name;
  TextEditingController code;
  TextEditingController eName;
  TextEditingController eCode;
  String currentId='';
  String uploadFileUrl='';

  @override
  void initState() {
    super.initState();
    eName = TextEditingController();
    eCode = TextEditingController();
    name = TextEditingController();
    code = TextEditingController();
  }
  setSearchParam(String caseNumber) {
    ListBuilder<String> caseSearchList = ListBuilder<String>();
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Add Country',
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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: edit==true? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FFButtonWidget(
                            onPressed: ()  {
                              edit=false;
                              setState(() {

                              });
                            },
                            text: 'Clear ',
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: secondaryColor,
                              textStyle: FlutterFlowTheme.subtitle2.override(
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
                        ),
                        uploadFileUrl==''?Text('Please Upload Banner'):
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: 100,
                              width: 100,
                              child: CachedNetworkImage(imageUrl: uploadFileUrl)),
                        ),
                        SizedBox(height: 20,),

                        FFButtonWidget(
                          onPressed: () async {
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
                                      uploadFileUrl = downloadUrl;
                                    } );
                                showUploadMessage(context, 'Success!');
                              } else {
                                showUploadMessage(
                                    context, 'Failed to upload media');
                              }
                            }
                          },
                          text: uploadFileUrl==''?'Upload Logo':'Change Logo',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: secondaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
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
                        SizedBox(height: 20,),

                        TextFormField(
                          controller: eCode,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Country Code',
                            labelStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            hintText: 'Please Enter Country Code',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF252525),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF252525),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10,),

                        TextFormField(
                          controller: eName,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Country Name',
                            labelStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            hintText: 'Please Enter Country Name',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF252525),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF252525),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            
                              vertical: 10.0, horizontal: 0.0),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(

                              vertical: 10.0, horizontal: 0.0),
                        ),

                        FFButtonWidget(
                          onPressed: () async {

                            if(eName.text!=''&&uploadFileUrl!=''&&eCode.text!=''){

                              bool proceed = await alert(context,
                                  'You want to Update This Country?');
                              if(proceed){
                                FirebaseFirestore.instance.collection('country')
                                .doc(currentId)
                                    .update({
                                  'name':eName.text,
                                  'logo':uploadFileUrl,
                                  'code':'+'+eCode.text,
                                });
                                showUploadMessage(context, 'Country Updated...');
                                setState(() {
                                  edit=false;
                                  eName.text='';
                                  eCode.text='';
                                  uploadFileUrl='';

                                });
                              }

                            }else{
                              eName.text==''? showUploadMessage(context, 'Please Enter Name'):
                              eCode.text==''? showUploadMessage(context, 'Please Enter Code'):
                              showUploadMessage(context, 'Please Upload Logo');                            }
                          },
                          text: 'Update Country',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50,
                            color: secondaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
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
                      ],
                    ),
                  ):
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        uploadFileUrl==''?Text('Please Upload Logo'):
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: 100,
                              width: 100,
                              child: CachedNetworkImage(imageUrl: uploadFileUrl)),
                        ),
                        SizedBox(height: 20,),
                        FFButtonWidget(
                          onPressed: () async {
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
                                      uploadFileUrl = downloadUrl;
                                    } );
                                showUploadMessage(context, 'Success!');
                              } else {
                                showUploadMessage(
                                    context, 'Failed to upload media');
                              }
                            }
                          },
                          text: uploadFileUrl==''?'Upload Logo':'Change Logo',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: secondaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
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
                        SizedBox(height: 20,),

                        TextFormField(
                          controller: code,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Country Code',
                            labelStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            hintText: 'Please Enter Country Code',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF252525),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF252525),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10,),

                        TextFormField(
                          controller: name,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Country Name',
                            labelStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            hintText: 'Please Enter Country Name',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF252525),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF252525),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                        ),
                        
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 0.0),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(

                              vertical: 10.0, horizontal: 0.0),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            
                            if(name.text!=''&&uploadFileUrl!=''&&code.text!=''){

                              bool proceed = await alert(context,
                                        'You want to Add This Country?');
                              if(proceed){
                                FirebaseFirestore.instance.collection('country').add({
                                  'name':name.text,
                                  'logo':uploadFileUrl,
                                  'code':'+'+code.text,
                                });
                                showUploadMessage(context, 'New Country Added...');
                                setState(() {
                                  name.text='';
                                  code.text='';
                                  uploadFileUrl='';
                                  
                                  
                                });
                              }
                              
                            }else{
                              name.text==''? showUploadMessage(context, 'Please Enter Name'):
                              code.text==''? showUploadMessage(context, 'Please Enter Code'):
                                  showUploadMessage(context, 'Please Upload Logo');
                            }
                          
                          },
                          text: 'Create Country',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50,
                            color: secondaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
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
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 50,),
                Expanded(
                  flex: 2,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('country').snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Center(child: CircularProgressIndicator());
                        }
                        var data=snapshot.data.docs;
                        print(data.length);
                        return Container(
                          height: MediaQuery.of(context).size.height*0.8,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              horizontalMargin: 3,
                              columnSpacing: 5,
                              columns: [
                                DataColumn(
                                  label: Text("Logo",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                DataColumn(
                                  label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold)),
                                ),

                                DataColumn(
                                  label: Text("Code"),
                                ),
                                DataColumn(
                                  label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                DataColumn(
                                  label: Text("",style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                data.length,
                                    (index) {

                                  String name=data[index]['name'];

                                  return DataRow(

                                    cells: [
                                      DataCell(// Generated code for this CircleImage Widget...
                                          Container(
                                            width: 80,
                                            height: 80,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: data[index]['logo'],
                                            ),
                                          )
                                      ),
                                      DataCell(Text(name)),
                                      DataCell(Text(data[index]['code'])),
                                      DataCell(   Row(
                                        children: [
                                          FFButtonWidget(
                                            onPressed: ()  {

                                           
                                              
                                              setState(() {
                                                edit=true;
                                                currentId=data[index].id;
                                                eName.text=name;
                                                eCode.text=data[index]['code'];
                                                uploadFileUrl=data[index]['logo'];

                                              });
                                              
                                             
                                            },
                                            text: 'Details',
                                            options: FFButtonOptions(
                                              width: 90,
                                              height: 30,
                                              color: Colors.white,
                                              textStyle: FlutterFlowTheme.subtitle2.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius: 8,
                                            ),
                                          ),

                                        ],
                                      ),),
                                      DataCell(   Row(
                                        children: [
                                          FFButtonWidget(
                                            onPressed: ()  async {


                                                bool proceed = await alert(context,
                                                    'You want to Delete This Country?');
                                                if(proceed){
                                                  FirebaseFirestore.instance.collection('country').doc(data[index].id).delete();
                                                  showUploadMessage(context, 'Country Deleted...');
                                                  setState(() {
                                                    edit=false;
                                                    


                                                  });
                                                }

                                              
                                              
                                            
                                            },
                                            text: 'Delete',
                                            options: FFButtonOptions(
                                              width: 90,
                                              height: 30,
                                              color: Colors.white,
                                              textStyle: FlutterFlowTheme.subtitle2.override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius: 8,
                                            ),
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
                        );
                      }
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
