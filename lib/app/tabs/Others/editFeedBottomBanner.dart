
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constant/Constant.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/upload_media.dart';


class EditFeedBannerWidget extends StatefulWidget {
  const EditFeedBannerWidget({Key key}) : super(key: key);

  @override
  _EditFeedBannerWidgetState createState() => _EditFeedBannerWidgetState();
}

class _EditFeedBannerWidgetState   extends State<EditFeedBannerWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Banner',
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
              var data=snapshot.data.docs;
              List categoryBanner=data[0]['bottomFeed'];
              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: categoryBanner.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 15),
                    child: InkWell(
                      onLongPress: () async {
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
                                    DocumentSnapshot delete=data[0];
                                    delete.reference.update({
                                      'bottomFeed':FieldValue.arrayRemove([categoryBanner[index]]),

                                    });
                                    showUploadMessage(context, 'Banner Deleted');
                                    Navigator.pop(alertDialogContext);
                                    Navigator.pop(context);

                                  },
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: categoryBanner[index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },

              );
            }
        ),
      ),
    );
  }
}
