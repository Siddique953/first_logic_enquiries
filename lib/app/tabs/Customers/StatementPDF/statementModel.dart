//@dart=2.9

class StatementModel {
  final String customerName;
  // final String selectedProjectType;
  final String address;

  final String customerPhoneNo;

  const StatementModel({
    this.customerName,
    this.customerPhoneNo,
    this.address,
  });
}

//
// class ShippingAddress {
//   final String name;
//   final String address;
//   final String area;
//   final String gst;
//   final String mobileNumber;
//   final String state;
//   final String pincode;
//
//   const ShippingAddress({
//     this.name,
//     this.address,
//     this.area,
//     this.gst,
//     this.mobileNumber,
//     this.state,
//     this.pincode,
//
// });
//
// }
//
//
//
// class InvoiceItem {
//   final String description;
//   final int quantity;
//   final double unitPrice;
//   final double tax;
//   final double gst;
//   final double price;
//   final double total;
//
//   const InvoiceItem(
//    {
//      this.tax,
//      this.description,
//      this.quantity,
//      this.unitPrice,
//      this.gst,
//      this.price,
//     this.total,
//   });
// }
