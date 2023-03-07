import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constant/Constant.dart';
import '../../../../flutter_flow/flutter_flow_drop_down.dart';
import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../../flutter_flow/upload_media.dart';


class OrderDetailsPageWidget extends StatefulWidget {
  final String name;
  final String address;
  final String phone;
  final String area;
  final String orderId;
  final String city;
  final String landmark;
  final String state;
  final String pincode;
  final String lat;
  final String long;

  final int status;
  const OrderDetailsPageWidget({Key key, this.orderId, this.name, this.address, this.phone, this.area, this.status, this.city, this.landmark, this.state, this.pincode, this.lat, this.long}) : super(key: key);

  @override
  _OrderDetailsPageWidgetState createState() => _OrderDetailsPageWidgetState();
}

class _OrderDetailsPageWidgetState extends State<OrderDetailsPageWidget> {
  String dropDownValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var data;
  TextEditingController shippRocket;
  TextEditingController notes;
  TextEditingController address;
  TextEditingController area;
  TextEditingController city;
  TextEditingController landmark;
  TextEditingController mobileNumber;
  TextEditingController name;
  TextEditingController pincode;
  TextEditingController state;
  var items;
  String shippAddress='';
  String shippingMethod='';
  
  @override
  void initState() {
    super.initState();
    print(widget.orderId);
    notes=TextEditingController();
    
    shippRocket=TextEditingController();
    address=TextEditingController(text: widget.address);
    area=TextEditingController(text: widget.area);
    city=TextEditingController(text: widget.city);
    landmark=TextEditingController(text: widget.landmark);
    mobileNumber=TextEditingController(text: widget.phone);
    name=TextEditingController(text: widget.name);
    pincode=TextEditingController(text: widget.pincode);
    state=TextEditingController(text: widget.state);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Order Details',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF3F3F3),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('orders').where('orderId',isEqualTo:widget.orderId).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }


            data=snapshot.data.docs;
              items = data[0]['items'];
              shippingMethod=data[0]['shippingMethod'];
             var shippAddress=data[0]['shippingAddress'];
             
              
              if(dropDownValue==null) {
                dropDownValue = data[0]['orderStatus'] == 1 ? 'Confirmed' :
                data[0]['orderStatus'] == 0 ? 'Pending' :
                data[0]['orderStatus'] == 2 ? 'Canceled' :
                data[0]['orderStatus'] == 3 ? 'Shipped' :
                data[0]['orderStatus'] == 4 ? 'Delivered' : 'Rejected';
              }
          
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.date_range_outlined,
                          color: Colors.black,
                          size: 24,
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(-0.95, 0),
                            child: Column(
                              children: [
                                Text(
                                  data[0]['placedDate'].toDate().toString().substring(0,16),
                                  style: FlutterFlowTheme.bodyText1,
                                ),
                                Text(
                                'Order Id : ${widget.orderId}',
                                  style: FlutterFlowTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        FlutterFlowDropDown(
                          initialOption: dropDownValue??'Pending',
                          options: [
                            'Pending',
                            'Confirmed',
                            'Shipped',
                            'Delivered',
                            'Canceled',
                            'Rejected',
                          ].toList(),
                          onChanged: (val) => setState((){ dropDownValue = val;
                          print(dropDownValue);}),
                          width: 180,
                          height: 50,
                          textStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          elevation: 2,
                          borderColor: Colors.transparent,
                          borderWidth: 0,
                          borderRadius: 0,
                          margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Order Update'),
                                content: Text('Do You want to Update Order ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(alertDialogContext),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      print(dropDownValue);

                                      DocumentSnapshot order=data[0];
                                      await order.reference.update({

                                        'orderStatus': dropDownValue=='Pending'?0:
                                        dropDownValue=='Confirmed'?1:
                                        dropDownValue=='Shipped'?3:
                                        dropDownValue=='Delivered'?4:
                                        dropDownValue=='Canceled'?2:5,
                                      });


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
                          text: 'Save',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: Colors.white,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            elevation: 5,
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: '',
                          icon: Icon(
                            Icons.print,
                            color: Colors.white,
                            size: 20,
                          ),
                          options: FFButtonOptions(
                            width: 100,
                            height: 40,
                            color: Color(0xFF333333),
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
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:450,
                        height: 100,
                        decoration: BoxDecoration(),
                        child: TextFormField(
                          controller: shippRocket,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'shippRocket',
                            labelStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'shippRocket',
                            hintStyle: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Update',
                        options: FFButtonOptions(
                          width: 130,
                          height: 50,
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
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Container(
                              width: 290,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.payments,
                                      color: Color(0xFF1D15CA),
                                      size: 24,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Payment Info',
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Bank Details: ',
                                          style: FlutterFlowTheme.bodyText1,
                                        ),
                                        Text(
                                          '',
                                          style: FlutterFlowTheme.bodyText1,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Container(
                              width: 290,

                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Color(0xFF1D15CA),
                                      size: 24,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Customer',
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          widget.name,
                                          style: FlutterFlowTheme.bodyText1,
                                        ),
                                        Text(
                                          widget.phone,
                                          style: FlutterFlowTheme.bodyText1,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Container(
                              width: 290,

                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.truck,
                                      color: Color(0xFF1D15CA),
                                      size: 24,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Order Info',
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Shipping: Shiprocket',
                                          style: FlutterFlowTheme.bodyText1,
                                        ),
                                        Text(
                                          'Pay Method: $shippingMethod ',
                                          style: FlutterFlowTheme.bodyText1,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Container(
                              width: 290,

                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Color(0xFF1D15CA),
                                      size: 24,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Delivery to',
                                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                                              ), 
                                              InkWell(
                                                onTap: () async {

                                                 Map<String,dynamic> shippingAddress={};

                                                  await showDialog(
                                                      context: context,
                                                      builder: (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: Text('Edit Shipping Address'),
                                                      content: Container(
                                                        width: 500,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: TextFormField(
                                                                      controller: name,
                                                                      obscureText: false,
                                                                      onChanged: (text){

                                                                        setState(() {

                                                                        });
                                                                      },
                                                                      decoration: InputDecoration(
                                                                          labelText: 'Name',
                                                                        labelStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'Name',
                                                                        hintStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                      ),
                                                                      style: FlutterFlowTheme.bodyText1.override(
                                                                        fontFamily: 'Poppins',
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 20,),
                                                                  Expanded(
                                                                    child: TextFormField(
                                                                      controller: mobileNumber,
                                                                      obscureText: false,
                                                                      onChanged: (text){

                                                                        setState(() {

                                                                        });
                                                                      },
                                                                      decoration: InputDecoration(
                                                                        labelText: 'Mobile Number',
                                                                        labelStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'Mobile Number',
                                                                        hintStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                      ),
                                                                      style: FlutterFlowTheme.bodyText1.override(
                                                                        fontFamily: 'Poppins',
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: TextFormField(
                                                                      controller: city,
                                                                      obscureText: false,
                                                                      onChanged: (text){

                                                                        setState(() {

                                                                        });
                                                                      },
                                                                      decoration: InputDecoration(
                                                                          labelText: 'City',
                                                                        labelStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'City',
                                                                        hintStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                      ),
                                                                      style: FlutterFlowTheme.bodyText1.override(
                                                                        fontFamily: 'Poppins',
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 20,),
                                                                  Expanded(
                                                                    child: TextFormField(
                                                                      controller: landmark,
                                                                      obscureText: false,
                                                                      onChanged: (text){

                                                                        setState(() {

                                                                        });
                                                                      },
                                                                      decoration: InputDecoration(
                                                                        labelText: 'LandMark',
                                                                        labelStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'LandMark',
                                                                        hintStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                      ),
                                                                      style: FlutterFlowTheme.bodyText1.override(
                                                                        fontFamily: 'Poppins',
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: TextFormField(
                                                                      controller: address,
                                                                      obscureText: false,
                                                                      onChanged: (text){

                                                                        setState(() {

                                                                        });
                                                                      },
                                                                      decoration: InputDecoration(
                                                                          labelText: 'Address',
                                                                        labelStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'Address',
                                                                        hintStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                      ),
                                                                      style: FlutterFlowTheme.bodyText1.override(
                                                                        fontFamily: 'Poppins',
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 20,),
                                                                  Expanded(
                                                                    child: TextFormField(
                                                                      controller: area,
                                                                      obscureText: false,
                                                                      onChanged: (text){

                                                                        setState(() {

                                                                        });
                                                                      },
                                                                      decoration: InputDecoration(
                                                                        labelText: 'Area',
                                                                        labelStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'Area',
                                                                        hintStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                      ),
                                                                      style: FlutterFlowTheme.bodyText1.override(
                                                                        fontFamily: 'Poppins',
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: TextFormField(
                                                                      controller: pincode,
                                                                      obscureText: false,
                                                                      onChanged: (text){

                                                                        setState(() {

                                                                        });
                                                                      },
                                                                      decoration: InputDecoration(
                                                                          labelText: 'PinCode',
                                                                        labelStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'PinCode',
                                                                        hintStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                      ),
                                                                      style: FlutterFlowTheme.bodyText1.override(
                                                                        fontFamily: 'Poppins',
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 20,),
                                                                  Expanded(
                                                                    child: TextFormField(
                                                                      controller: state,
                                                                      obscureText: false,
                                                                      onChanged: (text){

                                                                        setState(() {

                                                                        });
                                                                      },
                                                                      decoration: InputDecoration(
                                                                        labelText: 'State',
                                                                        labelStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        hintText: 'State',
                                                                        hintStyle: FlutterFlowTheme.bodyText1.override(
                                                                          fontFamily: 'Poppins',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                            color: Colors.black,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        filled: true,
                                                                        fillColor: Colors.white,
                                                                      ),
                                                                      style: FlutterFlowTheme.bodyText1.override(
                                                                        fontFamily: 'Poppins',
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: TextButton(
                                                            onPressed: () => Navigator.pop(alertDialogContext),
                                                            child: Text('Cancel',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: TextButton(
                                                            onPressed: () async {

                                                              shippingAddress.addAll({
                                                                'address':address.text,
                                                                'area':area.text,
                                                                'city':city.text,
                                                                'landmark':landmark.text,
                                                                'latitude':widget.lat.toString(),
                                                                'longitude':widget.long.toString(),
                                                                'mobileNumber':mobileNumber.text,
                                                                'name':name.text,
                                                                'pinCode':pincode.text,
                                                                'state':state.text,
                                                              });

                                                              DocumentSnapshot aaa=data[0];
                                                              await aaa.reference.update({
                                                                'shippingAddress':shippingAddress,
                                                              });
                                                              showUploadMessage(context, 'Shipping Address Updated...');
                                                              Navigator.pop(alertDialogContext);

                                                              
                                                            },
                                                            child: Text('Confirm',style: TextStyle(color: secondaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  );
                                                },
                                                child:   Icon(
                                                  Icons.edit_sharp,
                                                  color: Colors.black,
                                                  size: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Name - '+shippAddress['name'],
                                            style: FlutterFlowTheme.bodyText1,
                                          ),
                                          Text(
                                            'Area - '+shippAddress['area'],
                                            style: FlutterFlowTheme.bodyText1,
                                          ),
                                          Text(
                                            'City - '+shippAddress['city'],
                                            style: FlutterFlowTheme.bodyText1,
                                          ),
                                          Text(
                                            'LandMark - '+shippAddress['landmark'],
                                            style: FlutterFlowTheme.bodyText1,
                                          ),
                                          Text(
                                            'Mobile - '+shippAddress['mobileNumber'],
                                            style: FlutterFlowTheme.bodyText1,
                                          ),
                                          Text(
                                           'Pincode - '+shippAddress['pinCode'],
                                            style: FlutterFlowTheme.bodyText1,
                                          ),
                                          Text(
                                            'State - '+shippAddress['state'],
                                            style: FlutterFlowTheme.bodyText1,
                                          ),


                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 800,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: DataTable(
                                showCheckboxColumn: true,
                                showBottomBorder: true,
                                horizontalMargin: 10,

                                columns: [


                                  DataColumn(
                                    label: Text("Product",style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  DataColumn(
                                    label: Text("Unit Price",style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  DataColumn(
                                    label: Text("Qty",style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  DataColumn(
                                    label: SizedBox(width: 100,),
                                  ),
                                  DataColumn(
                                    label: Expanded(

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text("Total",style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],
                                        )),
                                  ),

                                ],
                                rows: List.generate(
                                  items.length,
                                      (index) {

                                    String name=items[index]['name'];
                                    int qty=items[index]['quantity'];
                                    double price=items[index]['price'];
                                 

                                    print(name);


                                    return DataRow(
                                      cells: [
                                        DataCell(Row(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: items[index]['image'],
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(width: 10,),
                                            Text(name),
                                          ],
                                        )),
                                        DataCell(Text('₹ ${price.toStringAsFixed(2)}')),
                                        DataCell(Text(qty.toString())),
                                        DataCell(Text('')),
                                        DataCell(Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('₹${(price*qty).toStringAsFixed(2)}'),
                                          ],
                                        )),
                                       


                                        // DataCell(Text(fileInfo.size)),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Subtotal : ',
                                                style: FlutterFlowTheme.bodyText1,
                                              ),
                                              Text(
                                                '₹ 0.00',
                                                style: FlutterFlowTheme.bodyText1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Shipping Cost : ',
                                                style: FlutterFlowTheme.bodyText1,
                                              ),
                                              Text(
                                                '₹ 0.00',
                                                style: FlutterFlowTheme.bodyText1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Grand Total : ',
                                                style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                '₹ ${data[0]['price'].toStringAsFixed(2)}',
                                                style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Status : ',
                                                style: FlutterFlowTheme.bodyText1,
                                              ),
                                              FFButtonWidget(
                                                onPressed: () {
                                                },
                                                text: 'Payment Pending',
                                                options: FFButtonOptions(
                                                  width: 130,
                                                  height: 30,
                                                  color: Color(0xFFA8E1B3),
                                                  textStyle: FlutterFlowTheme.subtitle2.override(
                                                    fontFamily: 'Poppins',
                                                    color: Color(0xFF093018),
                                                    fontSize: 12,
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width:300,
                            height: 100,
                            decoration: BoxDecoration(),
                            child: TextFormField(
                              controller: notes,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Note',
                                labelStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: 'Type some note',
                                hintStyle: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () {
                              if(notes.text!=''){
                                FirebaseFirestore.instance.collection('notes').add({
                                  'note':[notes.text],
                                  'id':widget.orderId,
                                  'date':DateTime.now(),
                                });
                                notes.text='';
                              }
                              else{
                                showUploadMessage(context, 'Please Enter Notes');
                              }

                            },
                            text: 'Save note',
                            options: FFButtonOptions(
                              width: 130,
                              height: 50,
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
                          // StreamBuilder<DocumentSnapshot>(
                          //   stream: FirebaseFirestore.instance.collection('notes').doc(widget.orderId).snapshots(),
                          //   builder: (context, snapshot) {
                          //     if(!snapshot.hasData){
                          //       return Center(child: CircularProgressIndicator());
                          //     }
                          //     var data1=snapshot.data;
                          //
                          //     return data.length==0?
                          //     Center(child: Text('No Notes')):
                          //     Expanded(
                          //       child: ListView.builder(
                          //         itemCount: data.length,
                          //         itemBuilder: (context, index) {
                          //
                          //           return Container(child: Text(data[index]));
                          //         },
                          //            ),
                          //     );
                          //   }
                          // )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
