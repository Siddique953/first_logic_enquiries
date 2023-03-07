class EnquiryStatus {
  String dId;
  String status;
  String eId;
  DateTime date;
  DateTime next;
  String branch;

  EnquiryStatus(
      {this.dId, this.status, this.eId, this.date, this.next, this.branch});

  EnquiryStatus.fromJson(Map<String, dynamic> json) {
    dId = json['dId'];
    status = json['status'];
    eId = json['eId'];
    date = json['date'];
    next = json['next'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dId'] = this.dId;
    data['status'] = this.status;
    data['eId'] = this.eId;
    data['date'] = this.date;
    data['next'] = this.next;
    data['branch'] = this.branch;
    return data;
  }
}
