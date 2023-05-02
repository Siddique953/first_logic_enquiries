class EmployeeModel {
  String name;
  String email;
  String phone;
  DateTime joinedDate;
  DateTime dob;
  DateTime createdDate;
  String gender;
  String dept;
  String subDept;
  String designation;
  String reportingManager;
  String empType;
  int probation;
  String ctc;
  String accountHolderName;
  String bankName;
  String city;
  String ifsc;
  String branchName;
  String empId;
  String profile;
  bool delete;
  String accountNumber;
  String teamLead;
  String pan;

  EmployeeModel(
      {this.name,
      this.email,
      this.phone,
      this.joinedDate,
      this.dob,
      this.gender,
      this.dept,
      this.subDept,
      this.designation,
      this.reportingManager,
      this.empType,
      this.probation,
      this.ctc,
      this.accountHolderName,
      this.bankName,
      this.city,
      this.ifsc,
      this.branchName,
      this.delete,
      this.empId,
      this.profile,
      this.teamLead,
      this.accountNumber,
      this.pan,
      this.createdDate});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pan = json['pan'];
    email = json['email'];
    phone = json['phone'];
    empId = json['empId'];
    teamLead = json['teamLead'];
    delete = json['delete'];
    joinedDate = json['joinedDate'].toDate();
    createdDate = json['createdDate'].toDate();
    dob = json['dob'].toDate();
    gender = json['gender'];
    dept = json['dept'];
    subDept = json['subDept'];
    designation = json['designation'];
    reportingManager = json['reportingManager'];
    empType = json['empType'];
    probation = json['probation'];
    ctc = json['ctc'];
    accountHolderName = json['accountHolderName'];
    bankName = json['bankName'];
    city = json['city'];
    profile = json['profile'];
    ifsc = json['ifsc'];
    branchName = json['branchName'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['pan'] = this.pan;
    data['phone'] = this.phone;
    data['teamLead'] = this.teamLead;
    data['profile'] = this.profile;
    data['joinedDate'] = this.joinedDate;
    data['createdDate'] = this.createdDate;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['empId'] = this.empId;
    data['delete'] = this.delete;
    data['dept'] = this.dept;
    data['subDept'] = this.subDept;
    data['designation'] = this.designation;
    data['reportingManager'] = this.reportingManager;
    data['empType'] = this.empType;
    data['probation'] = this.probation;
    data['ctc'] = this.ctc;
    data['accountHolderName'] = this.accountHolderName;
    data['bankName'] = this.bankName;
    data['city'] = this.city;
    data['ifsc'] = this.ifsc;
    data['branchName'] = this.branchName;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}
