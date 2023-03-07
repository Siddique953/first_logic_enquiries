
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:searchfield/searchfield.dart';

import '../../../backend/firebase_storage/storage.dart';
import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/upload_media.dart';

class EditCategoryBannerWidget extends StatefulWidget {
  const EditCategoryBannerWidget({Key key}) : super(key: key);

  @override
  _EditCategoryBannerWidgetState createState() =>
      _EditCategoryBannerWidgetState();
}

class _EditCategoryBannerWidgetState extends State<EditCategoryBannerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Universities Banner',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('banner').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            var data= snapshot.data.docs;
            List banner=data[0]['brandList'];

            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: banner.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context,int index) {



                return Banner(
                  banner:banner,
                  index:index,
                  imageUrl:banner[index]['imageUrl'],
                  name:  banner[index]['name']
                );
              },

            );
          }
        ),
      ),
    );
  }
}
class Banner extends StatefulWidget {
  final List banner;
  final String imageUrl;
  final String name;
  final int index;
  const Banner({Key key, this.banner, this.imageUrl, this.name, this.index}) : super(key: key);

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  String selectedCategory='';
  String uploadedFileUrl2='';
  Map<String,dynamic> category={};
  Map<String,dynamic> categoryList={};
  List<String> names=[];
  final List<DropdownMenuItem> fetchedCategories = <DropdownMenuItem>[];
  Future getCategories() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("category").get();
    for (var doc in data1.docs) {

      category[doc.get('name')]=doc.id;
      names.add(doc.get('name'));
      categoryList[doc.id]=doc.get('name');
      fetchedCategories.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('name').toString(),
      ));
      
      selectedCategory=categoryList[widget.name];
    }
    if(mounted){
      setState(() {


      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (fetchedCategories.isEmpty) {
      getCategories().then((value) {

        setState(() {});
      });
    }
    

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
      child: Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                  return AlertDialog(
                    title: Text('Change Banner'),
                    content: Text('Do you want to change banner ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: Text('Cancel'),
                      ),
                      TextButton(
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
                            Navigator.pop(alertDialogContext);

                            final downloadUrl = await uploadData(
                                selectedMedia.storagePath,
                                selectedMedia.bytes);
                            ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar();
                            if (downloadUrl != null) {
                              setState(
                                      () {
                                    uploadedFileUrl2 = downloadUrl;
                                  } );
                              showUploadMessage(context, 'Success!');

                            } else {
                              showUploadMessage(
                                  context, 'Failed to upload media');
                            }
                          }

                        },
                        child: Text('Confirm'),
                      ),
                    ],
                  );
                },
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: uploadedFileUrl2==''?widget.imageUrl:uploadedFileUrl2,
                  width: 400,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 330,
                  // height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xFFE6E6E6),
                    ),
                  ),
                  child: SearchField(
                    initialValue: selectedCategory??'',
                    

                    suggestions: names,

                    hint: 'Search Categories',
                    searchStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    searchInputDecoration:
                    InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    onTap: (x) {
                      selectedCategory=x;
                      setState(() {
                        print(selectedCategory);
                        print(category[selectedCategory]);

                      });
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    if(selectedCategory!=''){
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: Text('Update Banner'),
                            content: Text('Do you want to Update Banner ?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(alertDialogContext),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {

                                  List<Map<String,dynamic>> banner=[];
                                  List<Map<String,dynamic>> newBanner=[];


                                  banner.add({
                                    'imageUrl':widget.imageUrl,
                                    'name':widget.name,
                                  });
                                  newBanner.add({
                                    'imageUrl':uploadedFileUrl2==''?widget.imageUrl:uploadedFileUrl2,
                                    'name':category[selectedCategory],
                                  });
                                  FirebaseFirestore.instance.collection('banner').doc('banner').update({
                                    'brandList':FieldValue.arrayRemove(banner),
                                  });
                                  FirebaseFirestore.instance.collection('banner').doc('banner').update({
                                    'brandList':FieldValue.arrayUnion(newBanner),
                                  });

                                  Navigator.pop(alertDialogContext);

                                },
                                child: Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      );
                    }else{
                      showUploadMessage(context, 'Please Choose Universities');
                    }


                  },
                  text: 'Save',
                  icon: Icon(
                    Icons.save,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: secondaryColor,
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('Delete Banner'),
                          content: Text('Do you want to Delete Banner ?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(alertDialogContext),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {

                                List<Map<String,dynamic>> banner=[];

                                banner.add({
                                  'imageUrl':widget.imageUrl,
                                  'name':widget.name,
                                });

                                FirebaseFirestore.instance.collection('banner').doc('banner').update({
                                  'brandList':FieldValue.arrayRemove(banner),
                                });

                                Navigator.pop(alertDialogContext);

                              },
                              child: Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  text: 'Delete',
                  icon: Icon(
                    Icons.delete,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: Color(0xFFF10202),
                    textStyle: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}

