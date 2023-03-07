import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../app/tabs/Settings/Course/orderDetailPage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'OrderDetails.dart';


class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('orders').orderBy('placedDate',descending: true).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        var data=snapshot.data.docs;

        return Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recent Orders",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  horizontalMargin: 0,
                  columns: [
                    DataColumn(
                      label: Text("#ID",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    DataColumn(
                      label: Text("Name",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text("Type",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text("Total",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text("Status",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text("Date",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text(""),
                    ),
                    DataColumn(
                      label: Text("Action",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: List.generate(
                    data.length,
                        (index) {

                          Map shippingAddress=data[index]['shippingAddress'];
                          String name=shippingAddress['name'];
                          String address=shippingAddress['address'];
                          String area=shippingAddress['area'];
                          String city=shippingAddress['city'];
                          String landmark=shippingAddress['landmark'];
                          String state=shippingAddress['state'];
                          String phone=shippingAddress['mobileNumber'];
                          double total = data[index]['price'];
                          String lat = shippingAddress['latitude'].toString();
                          String long = shippingAddress['longitude'].toString();
                          String pincode = shippingAddress['pinCode'].toString();



                      return DataRow(
                        cells: [
                          DataCell(Text(data[index].id)),
                          DataCell(Text(name)),
                          DataCell(Text(data[index]['shippingMethod'])),
                          DataCell(Text('₹ ${total.toStringAsFixed(2)}')),
                          DataCell(Text(data[index]['orderStatus']==0?'Pending':
                          data[index]['orderStatus']==1?'Accepeted':
                          data[index]['orderStatus']==2?'Cancelled':
                          data[index]['orderStatus']==3?'Shipped':
                          data[index]['orderStatus']==4?'Delivered':
                          'Rejected',),),
                          DataCell(Text(data[index]['placedDate'].toDate().toString().substring(0,16))),
                          DataCell(  Row(
                            children: [

                            ],
                          ),),
                          DataCell(   Row(
                            children: [
                              FFButtonWidget(
                                onPressed: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsWidget(
                                  //   orderId:data[index].id,
                                  //   status:data[index]['orderStatus'],
                                  //   name:name,
                                  //   phone:phone,
                                  //   address:address,
                                  //   area:area,
                                  // )));
                                  // widget._tabController.animateTo((6));

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsPageWidget(
                                      orderId:data[index].id,
                                      status:data[index]['orderStatus'],
                                      name:name,
                                      city:city,
                                      landmark:landmark,
                                    state:state,
                                      lat:lat,
                                      long:long,
                                    pincode:pincode,
                                      phone:phone,
                                      address:address,
                                      area:area,
                                  )));
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '...',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ),
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
            ],
          ),
        );
      }
    );
  }
}


