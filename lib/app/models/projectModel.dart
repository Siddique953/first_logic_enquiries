class ProjectModel {
  String branch;
  String branchId;
  String companyName;
  String companyAddress;
  String currentStatus;
  String customerId;
  DateTime date;
  String description;
  String nextStatus;
  List<PaymentDetails> paymentDetails;
  double projectCost;
  String projectId;
  String projectName;
  String projectTopic;
  String projectType;
  int status;
  String userId;
  List<ProjectDetails> projectDetails;

  ProjectModel(
      {this.branch,
      this.branchId,
      this.companyName,
      this.companyAddress,
      this.currentStatus,
      this.customerId,
      this.date,
      this.description,
      this.nextStatus,
      this.paymentDetails,
      this.projectCost,
      this.projectId,
      this.projectName,
      this.projectTopic,
      this.projectType,
      this.status,
      this.userId,
      this.projectDetails});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    branch = json['branch'];
    branchId = json['branchId'];
    companyName = json['companyName'];
    companyAddress = json['companyAddress'];
    currentStatus = json['currentStatus'];
    customerId = json['customerId'];
    date = json['date'].toDate();
    description = json['description'];
    nextStatus = json['nextStatus'];
    projectCost = json['projectCost'].toDouble();
    projectId = json['projectId'];
    projectName = json['projectName'];
    projectTopic = json['projectTopic'];
    projectType = json['projectType'];
    status = json['status'];
    userId = json['userId'];
    if (json['projectDetails'] != null) {
      projectDetails = <ProjectDetails>[];
      json['projectDetails'].forEach((v) {
        projectDetails.add(new ProjectDetails.fromJson(v));
      });
    }
    if (json['paymentDetails'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['paymentDetails'].forEach((v) {
        paymentDetails.add(new PaymentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch'] = this.branch;
    data['branchId'] = this.branchId;
    data['companyName'] = this.companyName;
    data['companyAddress'] = this.companyAddress;
    data['currentStatus'] = this.currentStatus;
    data['customerId'] = this.customerId;
    data['date'] = this.date;
    data['description'] = this.description;
    data['nextStatus'] = this.nextStatus;
    data['projectCost'] = this.projectCost;
    data['projectId'] = this.projectId;
    data['projectName'] = this.projectName;
    data['projectTopic'] = this.projectTopic;
    data['projectType'] = this.projectType;
    data['status'] = this.status;
    data['userId'] = this.userId;
    if (this.projectDetails != null) {
      data['projectDetails'] =
          this.projectDetails.map((v) => v.toJson()).toList();
    }
    if (this.paymentDetails != null) {
      data['paymentDetails'] =
          this.paymentDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectDetails {
  String domain;
  String deliverable;
  String platform;

  ProjectDetails({this.domain, this.deliverable, this.platform});

  ProjectDetails.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    deliverable = json['deliverable'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['deliverable'] = this.deliverable;
    data['platform'] = this.platform;
    return data;
  }
}

class PaymentDetails {
  int amount;
  String billCode;
  String datePaid;
  String description;
  String paymentMethode;
  String staffName;
  String projectName;

  PaymentDetails(
      {this.amount,
      this.billCode,
      this.datePaid,
      this.description,
      this.paymentMethode,
      this.staffName,
      this.projectName});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    billCode = json['billCode'];
    datePaid = json['datePaid'];
    description = json['description'];
    paymentMethode = json['paymentMethode'];
    staffName = json['staffName'];
    projectName = json['projectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['billCode'] = this.billCode;
    data['datePaid'] = this.datePaid;
    data['description'] = this.description;
    data['paymentMethode'] = this.paymentMethode;
    data['staffName'] = this.staffName;
    data['projectName'] = this.projectName;
    return data;
  }
}
