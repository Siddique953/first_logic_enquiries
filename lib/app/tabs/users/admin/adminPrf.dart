import 'package:flutter/material.dart';

class AdminPrf extends StatefulWidget {
  const AdminPrf({Key key}) : super(key: key);

  @override
  _AdminPrfState createState() => _AdminPrfState();
}

class _AdminPrfState extends State<AdminPrf> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  var _currencies = [
    "MCA",
    "Msc COMPUTER SCIENCE",
    "DATA SCIENCE",
    "CYBER SECURITY",
    "AI",
    "ML",
    "CLOUD COMPUTING"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 30,),
              Container(

                child: Text("ADD admin ",style: TextStyle(fontSize:20,color: Colors.black),),),
            ],
          ),
          SizedBox(height: 40,),
          Center(
            child: Container(


              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width*0.60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(

                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.black54,
                          /*AppColours.appgradientfirstColour,
                    AppColours.appgradientsecondColour*/
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.5, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50.0,
                                        top: 10,
                                        right: 50.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      // controller: namesController,
                                      decoration: InputDecoration(
                                        hintText: "First Name",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.comment_bank_sharp,
                                            color: Colors.grey.shade700,
                                            size: 20,
                                          ), // icon is 48px widget.
                                        ),
                                        errorStyle: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        filled: true,
                                        fillColor: Colors.white,
                                        isDense: true,
                                        // Added this
                                        contentPadding: EdgeInsets.all(20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50.0,
                                        top: 10,
                                        right: 50.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      // controller: locationcontroller,
                                      autofocus: false,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: "Phone Number",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.phone,
                                            color: Colors.grey.shade700,
                                            size: 20,
                                          ), // icon is 48px widget.
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        isDense: true,
                                        // Added this
                                        contentPadding: EdgeInsets.all(20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                      ),
                                      onTap: () async {

                                      },

                                    ),
                                  ),
                                ),

                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50.0,
                                        top: 10,
                                        right: 50.0),
                                    child: DropdownButtonFormField(
                                      // // value:_currentSelectedValue,
                                      icon: Icon(Icons.arrow_drop_down_circle),
                                      decoration: InputDecoration(

                                        hintText: "Enquiry",
                                        filled: true,
                                        fillColor: Colors.white,
                                        isDense: true,
                                        // Added this
                                        contentPadding: EdgeInsets.all(20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white,width: 2),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                      ),
                                      // onChanged: ( newValue) {
                                      //   setState(() {
                                      //     _currentSelectedValue = newValue;
                                      //
                                      //   });
                                      // },
                                      items: _currencies.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),

                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please Select branch';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),),
                                Expanded(child:  Padding(
                                  padding: EdgeInsets.only(left: 50.0,
                                      top: 10,
                                      right: 50.0),
                                  child: TextFormField(
                                    // value:_currentSelectedValue,
                                    // icon: Icon(Icons.arrow_drop_down_circle),
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.grey.shade700,
                                          size: 20,
                                        ), // icon is 48px widget.
                                      ),
                                      hintText: "Role",
                                      filled: true,
                                      fillColor: Colors.white,
                                      isDense: true,
                                      // Added this
                                      contentPadding: EdgeInsets.all(20),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white,width: 2),
                                        borderRadius: BorderRadius.circular(30.7),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30.7),
                                      ),
                                    ),
                                    // onChanged: ( newValue) {
                                    //   setState(() {
                                    //     _currentSelectedValue = newValue;
                                    //
                                    //   });
                                    // },
                                    // items: _currencies.map((String value) {
                                    //   return DropdownMenuItem<String>(
                                    //     value: value,
                                    //     child: Text(value),
                                    //   );
                                    // }).toList(),

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please Select branch';
                                      }
                                      return null;
                                    },
                                  ),
                                ),),

                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50.0,
                                        top: 10,
                                        right: 50.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      // controller: namesController,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.email,
                                            color: Colors.grey.shade700,
                                            size: 20,
                                          ), // icon is 48px widget.
                                        ),
                                        hintText: "Email",
                                        errorStyle: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        filled: true,
                                        fillColor: Colors.white,
                                        isDense: true,
                                        // Added this
                                        contentPadding: EdgeInsets.all(20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50.0,
                                        top: 10,
                                        right: 50.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      // controller: namesController,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.grey.shade700,
                                            size: 20,
                                          ), // icon is 48px widget.
                                        ),
                                        hintText: "Username",
                                        errorStyle: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        filled: true,
                                        fillColor: Colors.white,
                                        isDense: true,
                                        // Added this
                                        contentPadding: EdgeInsets.all(20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50.0,
                                        top: 10,
                                        right: 50.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      // controller: namesController,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.lock,
                                            color: Colors.grey.shade700,
                                            size: 20,
                                          ), // icon is 48px widget.
                                        ),
                                        hintText: "Password",
                                        errorStyle: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        filled: true,
                                        fillColor: Colors.white,
                                        isDense: true,
                                        // Added this
                                        contentPadding: EdgeInsets.all(20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 50.0,
                                        top: 10,
                                        right: 50.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      // controller: namesController,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.grey.shade700,
                                            size: 20,
                                          ), // icon is 48px widget.
                                        ),
                                        hintText: "Confirm Password",
                                        errorStyle: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        filled: true,
                                        fillColor: Colors.white,
                                        isDense: true,
                                        // Added this
                                        contentPadding: EdgeInsets.all(20),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(30.7),
                                        ),
                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                                padding: const EdgeInsets.only(left:60,top: 10),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.cloud_upload),
                                    label: Text("Upload Image",style: TextStyle(color: Colors.black),),
                                    onPressed: () => print("it's pressed"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32.0),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.add_circle),
                                      label: Text("save",style: TextStyle(color: Colors.black),),
                                      onPressed: () => print("it's pressed"),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width:5),
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.add_circle),
                                      label: Text("Clear",style: TextStyle(color: Colors.black),),
                                      onPressed: () => print("it's pressed"),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.yellow,
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ), SizedBox(width:5),
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.add_circle),
                                      label: Text("Delete",style: TextStyle(color: Colors.black),),
                                      onPressed: () => print("it's pressed"),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ]))),
                ),
              ),
            ),
          ),                              //formColumn

          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white38,
                ),
                child: Text("Users List"),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.search_off_outlined,
                        color: Colors.grey.shade700,
                        size: 20,
                      ), // icon is 48px widget.
                    ),
                    contentPadding: EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 2),
                      borderRadius: BorderRadius.circular(10.7),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.7),
                    ),
                  ),),
              )
            ],
          ))


        ],
      ),
    );
  }
}
