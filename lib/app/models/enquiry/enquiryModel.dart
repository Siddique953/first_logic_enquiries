class EnquiryModel {
  String? additionalInfo;
  String? branch;
  String? careOf;
  String? careOfEmpNo;
  String? customerId;
  DateTime? date;
  String? email;
  String? enquiryId;
  String? mobile;
  String? name;
  String? place;
  String? projectTopic;
  String? projectType;
  String? status;
  String? userEmail;
  String? userId;
  List<ProjectDetails>? projectDetails;

  EnquiryModel(
      {this.additionalInfo,
      this.branch,
      this.careOf,
      this.careOfEmpNo,
      this.customerId,
      this.date,
      this.email,
      this.enquiryId,
      this.mobile,
      this.name,
      this.place,
      this.projectTopic,
      this.projectType,
      this.status,
      this.userEmail,
      this.userId,
      this.projectDetails});

  EnquiryModel.fromJson(Map<String, dynamic> json) {
    additionalInfo = json['additionalInfo'];
    branch = json['branch'];
    careOf = json['careOf'];
    careOfEmpNo = json['careOfEmpNo'];
    customerId = json['customerId'];
    date = json['date'];
    email = json['email'];
    enquiryId = json['enquiryId'];
    mobile = json['mobile'];
    name = json['name'];
    place = json['place'];
    projectTopic = json['projectTopic'];
    projectType = json['projectType'];
    status = json['status'];
    userEmail = json['userEmail'];
    userId = json['userId'];
    if (json['projectDetails'] != null) {
      projectDetails = <ProjectDetails>[];
      json['projectDetails'].forEach((v) {
        projectDetails!.add(new ProjectDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['additionalInfo'] = this.additionalInfo;
    data['branch'] = this.branch;
    data['careOf'] = this.careOf;
    data['careOfEmpNo'] = this.careOfEmpNo;
    data['customerId'] = this.customerId;
    data['date'] = this.date;
    data['email'] = this.email;
    data['enquiryId'] = this.enquiryId;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['place'] = this.place;
    data['projectTopic'] = this.projectTopic;
    data['projectType'] = this.projectType;
    data['status'] = this.status;
    data['userEmail'] = this.userEmail;
    data['userId'] = this.userId;
    data['projectDetails'] =
        this.projectDetails!.map((v) => v.toJson()).toList();

    return data;
  }
}

class ProjectDetails {
  String? name;
  String? requirements;
  String? platform;

  ProjectDetails({this.name, this.requirements, this.platform});

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    requirements = json['requirements'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['requirements'] = this.requirements;
    data['platform'] = this.platform;
    return data;
  }
}
