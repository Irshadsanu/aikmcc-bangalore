class RequestMemberModel{

  bool ind;
  String id;
  String name;
  String phone;
  String address;
  String age;
  String area;
  String areaDistrict;
  String assembly;
  String bloodGroup;
  String dob;
  String district;
  String occupation;
  String panchayath;
  String image;
  String status;
  String type;
  String ward;
  String wardName;
  String wardNumber;
  String time;
  String fullAddress;
  String aadhaar;
  String gender;
  String seconderyNumber;
  String coApprovedName;
  String coApprovedPhone;
  String adminApprovedName;
  String adminApprovedPhone;
  String coRejectedName;
  String coRejectedPhone;
  String adminRejectedName;
  String adminRejectedPhone;
  DateTime regDateTime;
  String proofName;
  String proofNumber;
  String fetchProofImage;


  RequestMemberModel(this.ind,this.id,this.name,this.phone,this.address,this.age,
      this.area,this.assembly,this.bloodGroup,this.dob,this.district,this.occupation,
      this.panchayath,this.image,this.status,this.type,this.ward,this.wardName,this.wardNumber,
      this.time
      ,this.aadhaar,
      this.fullAddress,
      this.gender,
      this.seconderyNumber,
      this.coApprovedName,
      this.coApprovedPhone,
      this.adminApprovedName,
      this.adminApprovedPhone,
      this.coRejectedName,
      this.coRejectedPhone,
      this.adminRejectedName,
      this.adminRejectedPhone,
      this.regDateTime,
      this.areaDistrict,
      this.proofNumber,
      this.proofName,
      this.fetchProofImage
      );

}


class MemberModelClass{

  MemberModelClass(
      this.id,
      this.name,
      this.phone,
      this.address,
      this.area,
      this.status,
      this.coApprovedName,
      this.adminApprovedName,
      this.adminRejectedName,
      this.coRejectedName,
      this.image,
      this.time,
      this.regDateTime,

      );
  String id;
  String name;
  String phone;
  String address;
  String area;
  String status;
  String coApprovedName;
  String adminApprovedName;
  String adminRejectedName;
  String coRejectedName;
  String image;
  String time;
  DateTime regDateTime;

}