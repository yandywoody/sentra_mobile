import 'dart:convert';

class EmployeeModel {
  EmployeeModel({
    this.id,
    this.recruitmentId,
    this.nik,
    this.name,
    this.foto,
    this.phone,
    this.mobile,
    this.email,
    this.identityTypeId,
    this.identityNumber,
    this.birthPlace,
    this.birthDate,
    this.gender,
    this.maritalId,
    this.bloodTypeId,
    this.religionId,
    this.address,
    this.provinceId,
    this.regencyId,
    this.postalCode,
    this.residentialStatus,
    this.residentialAddress,
    this.residentialProvinceId,
    this.residentialRegencyId,
    this.residentialPostalCode,
    this.companyId,
    this.branchId,
    this.departmentId,
    this.jobPositionId,
    this.employeeStatusId,
    this.joinDate,
    this.endContractDate,
    this.officeHourType,
    this.officeHourId,
    this.groupId,
    this.approvalsLine,
    this.pin,
    this.leaveAt,
    this.npwp,
    this.ptkpCode,
    this.bankId,
    this.bankAccount,
    this.bankAccountHolder,
    this.bpjsTk,
    this.bpjsKs,
    this.bpjsKsFamily,
    this.salaryPeriod,
    this.salaryType,
    this.overtimeStatus,
    this.overtimeAuto,
    this.isActive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? id;
  int? recruitmentId;
  String? nik;
  String? name;
  String? foto;
  String? phone;
  String? mobile;
  String? email;
  int? identityTypeId;
  String? identityNumber;
  String? birthPlace;
  String? birthDate;
  int? gender;
  int? maritalId;
  int? bloodTypeId;
  int? religionId;
  String? address;
  String? provinceId;
  String? regencyId;
  String? postalCode;
  int? residentialStatus;
  String? residentialAddress;
  String? residentialProvinceId;
  String? residentialRegencyId;
  String? residentialPostalCode;
  int? companyId;
  int? branchId;
  int? departmentId;
  int? jobPositionId;
  int? employeeStatusId;
  String? joinDate;
  String? endContractDate;
  int? officeHourType;
  int? officeHourId;
  int? groupId;
  String? approvalsLine;
  String? pin;
  String? leaveAt;
  String? npwp;
  String? ptkpCode;
  int? bankId;
  String? bankAccount;
  String? bankAccountHolder;
  String? bpjsTk;
  String? bpjsKs;
  int? bpjsKsFamily;
  int? salaryPeriod;
  int? salaryType;
  int? overtimeStatus;
  double? overtimeAuto;
  int? isActive;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory EmployeeModel.fromJson(String str) =>
      EmployeeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromMap(Map<dynamic, dynamic> json) => EmployeeModel(
        id: json["id"] == null ? null : json["id"],
        recruitmentId: json["recruitment_id"],
        nik: json["nik"] == null ? null : json["nik"],
        name: json["name"] == null ? null : json["name"],
        foto: json["foto"] == null ? null : json["foto"],
        phone: json["phone"] == null ? null : json["phone"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        email: json["email"] == null ? null : json["email"],
        identityTypeId:
            json["identity_type_id"] == null ? null : json["identity_type_id"],
        identityNumber:
            json["identity_number"] == null ? null : json["identity_number"],
        birthPlace: json["birth_place"] == null ? null : json["birth_place"],
        birthDate: json["birth_date"] == null ? null : json["birth_date"],
        gender: json["gender"] == null ? null : json["gender"],
        maritalId: json["marital_id"] == null ? null : json["marital_id"],
        bloodTypeId:
            json["blood_type_id"] == null ? null : json["blood_type_id"],
        religionId: json["religion_id"] == null ? null : json["religion_id"],
        address: json["address"] == null ? null : json["address"],
        provinceId: json["province_id"] == null ? null : json["province_id"],
        regencyId: json["regency_id"] == null ? null : json["regency_id"],
        postalCode: json["postal_code"] == null ? null : json["postal_code"],
        residentialStatus: json["residential_status"] == null
            ? null
            : json["residential_status"],
        residentialAddress: json["residential_address"] == null
            ? null
            : json["residential_address"],
        residentialProvinceId: json["residential_province_id"] == null
            ? null
            : json["residential_province_id"],
        residentialRegencyId: json["residential_regency_id"] == null
            ? null
            : json["residential_regency_id"],
        residentialPostalCode: json["residential_postal_code"] == null
            ? null
            : json["residential_postal_code"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        jobPositionId:
            json["job_position_id"] == null ? null : json["job_position_id"],
        employeeStatusId: json["employee_status_id"] == null
            ? null
            : json["employee_status_id"],
        joinDate: json["join_date"] == null ? null : json["join_date"],
        endContractDate: json["end_contract_date"] == null
            ? null
            : json["end_contract_date"],
        officeHourType:
            json["office_hour_type"] == null ? null : json["office_hour_type"],
        officeHourId:
            json["office_hour_id"] == null ? null : json["office_hour_id"],
        groupId: json["group_id"] == null ? null : json["group_id"],
        approvalsLine:
            json["approvals_line"] == null ? null : json["approvals_line"],
        pin: json["pin"] == null ? null : json["pin"],
        leaveAt: json["leave_at"] == null ? null : json["leave_at"],
        npwp: json["npwp"] == null ? null : json["npwp"],
        ptkpCode: json["ptkp_code"] == null ? null : json["ptkp_code"],
        bankId: json["bank_id"] == null ? null : json["bank_id"],
        bankAccount: json["bank_account"],
        bankAccountHolder: json["bank_account_holder"],
        bpjsTk: json["bpjs_tk"],
        bpjsKs: json["bpjs_ks"],
        bpjsKsFamily: json["bpjs_ks_family"],
        salaryPeriod: json["salary_period"],
        salaryType: json["salary_type"] == null ? null : json["salary_type"],
        overtimeStatus: json["overtime_status"],
        overtimeAuto: json["overtime_auto"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "recruitment_id": recruitmentId,
        "nik": nik == null ? null : nik,
        "name": name == null ? null : name,
        "foto": foto,
        "phone": phone == null ? null : phone,
        "mobile": mobile,
        "email": email == null ? null : email,
        "identity_type_id": identityTypeId,
        "identity_number": identityNumber == null ? null : identityNumber,
        "birth_place": birthPlace == null ? null : birthPlace,
        "birth_date": birthDate == null ? null : birthDate,
        "gender": gender == null ? null : gender,
        "marital_id": maritalId,
        "blood_type_id": bloodTypeId == null ? null : bloodTypeId,
        "religion_id": religionId,
        "address": address == null ? null : address,
        "province_id": provinceId,
        "regency_id": regencyId,
        "postal_code": postalCode,
        "residential_status": residentialStatus,
        "residential_address":
            residentialAddress == null ? null : residentialAddress,
        "residential_province_id": residentialProvinceId,
        "residential_regency_id": residentialRegencyId,
        "residential_postal_code": residentialPostalCode,
        "company_id": companyId,
        "branch_id": branchId,
        "department_id": departmentId == null ? null : departmentId,
        "job_position_id": jobPositionId,
        "employee_status_id": employeeStatusId,
        "join_date": joinDate,
        "end_contract_date": endContractDate,
        "office_hour_type": officeHourType,
        "office_hour_id": officeHourId,
        "group_id": groupId,
        "approvals_line": approvalsLine,
        "pin": pin == null ? null : pin,
        "leave_at": leaveAt,
        "npwp": npwp == null ? null : npwp,
        "ptkp_code": ptkpCode,
        "bank_id": bankId,
        "bank_account": bankAccount,
        "bank_account_holder": bankAccountHolder,
        "bpjs_tk": bpjsTk,
        "bpjs_ks": bpjsKs,
        "bpjs_ks_family": bpjsKsFamily,
        "salary_period": salaryPeriod,
        "salary_type": salaryType == null ? null : salaryType,
        "overtime_status": overtimeStatus,
        "overtime_auto": overtimeAuto,
        "is_active": isActive == null ? null : isActive,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy == null ? null : updatedBy,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "deleted_at": deletedAt,
      };
}
