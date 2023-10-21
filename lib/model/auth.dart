/* 회원가입 */
class RegisterRequestBody {
  RegisterRequestBodyData data;
  String flag;
  String? authUid;
  Map<dynamic, dynamic>? shippingData;

  RegisterRequestBody(
      {required this.data,
      required this.flag,
      required this.authUid,
      this.shippingData});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = {};
    body['data'] = data.toJson();
    body['flag'] = flag;
    body['auth_uid'] = authUid;
    body['shipping_data'] = shippingData;
    return body;
  }
}

class RegisterRequestBodyData {
  String email;
  String password;
  String? passwordConfirmation;
  String name;
  dynamic brandId;
  String contact;
  bool termsAndConditions;
  bool personalInformation;
  bool over14YearsOld;
  bool serviceNotification;
  bool nighttimeServiceNotification;
  bool marketingNotification;
  String gender;
  String residence1;
  String residence2;
  String birthDay;

  RegisterRequestBodyData({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.name,
    required this.brandId,
    required this.contact,
    required this.termsAndConditions,
    required this.personalInformation,
    required this.over14YearsOld,
    required this.serviceNotification,
    required this.nighttimeServiceNotification,
    required this.marketingNotification,
    required this.gender,
    required this.residence1,
    required this.residence2,
    required this.birthDay,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['name'] = name;
    data['brand_id'] = brandId;
    data['contact'] = contact;
    data['terms_and_conditions'] = termsAndConditions;
    data['personal_information'] = personalInformation;
    data['over_14_years_old'] = over14YearsOld;
    data['service_notification'] = serviceNotification;
    data['nighttime_service_notification'] = nighttimeServiceNotification;
    data['marketing_notification'] = marketingNotification;
    data['gender'] = gender;
    data['residence1'] = residence1;
    data['residence2'] = residence2;
    data['birthday'] = birthDay;
    return data;
  }
}

class RegisterResponse {
  bool status;
  String message;
  String? token;
  RegisterResponseError? errors;
  Customer? customer;

  RegisterResponse(
      {required this.status,
      required this.message,
      required this.token,
      this.errors,
      this.customer});
  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
          status: json['status'] ?? false,
          message: json['message'] ?? '',
          token: json['token'] ?? '',
          errors: json['errors'] != null
              ? RegisterResponseError.fromJson(json['errors'])
              : null,
          customer: json['customer'] != null
              ? Customer.fromJson(json['customer'])
              : null);
}

class CustomerResponse {
  bool status;
  String message;
  Customer? data;
  CustomerResponse({required this.status, required this.message, this.data});
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      CustomerResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null ? Customer.fromJson(json['data']) : null);
}

class Customer {
  Map? privacy;
  String email;
  String name;
  String contact;
  dynamic id;
  dynamic globalId;
  String? deviceToken;
  dynamic refundAccount;

  Customer(
      {this.privacy,
      required this.email,
      required this.name,
      required this.contact,
      required this.id,
      this.globalId,
      this.deviceToken,
      this.refundAccount});
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
      privacy: json['privacy'],
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      contact: json['contact'] ?? '',
      id: json['id'],
      globalId: json['global_id'],
      deviceToken: json['device_token'],
      refundAccount: json['refund_account'] // TODO 환불계좌정보
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['name'] = name;
    data['contact'] = contact;
    data['id'] = id;
    if (deviceToken != null) {
      data['device_token'] = deviceToken;
    }
    return data;
  }
}

class RegisterResponseError {
  List<String> userId;
  List<String> email;
  List<String> contact;
  List<String> password;
  RegisterResponseError(
      {required this.userId,
      required this.email,
      required this.contact,
      required this.password});
  factory RegisterResponseError.fromJson(Map<String, dynamic> json) =>
      RegisterResponseError(
        userId: json['user_id'] != null
            ? List<String>.from(json['user_id'].map((x) => x))
            : [],
        email: json['email'] != null
            ? List<String>.from(json['email'].map((x) => x))
            : [],
        contact: json['contact'] != null
            ? List<String>.from(json['contact'].map((x) => x))
            : [],
        password: json['password'] != null
            ? List<String>.from(json['password'].map((x) => x))
            : [],
      );
}

/*---- 회원가입 -----*/

/* 로그인 */
class LoginRequestBody {
  String email;
  String password;
  dynamic brandId;
  String? deviceToken;

  LoginRequestBody(
      {required this.email,
      required this.password,
      required this.brandId,
      required this.deviceToken});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    data['brand_id'] = brandId;
    data['device_token'] = deviceToken;
    data['method'] = 'app';
    return data;
  }
}

class LoginResponse {
  bool status;
  String message; // status==false 이면 null 이 아님
  String token;
  Map<dynamic, dynamic>? user;
  Customer? customer;
  LoginResponse(
      {required this.status,
      required this.message,
      required this.token,
      this.user,
      this.customer});
  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      status: json['status'],
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: json['user'],
      customer: json['customer'] != null
          ? Customer.fromJson(json['customer'])
          : null);
}
/* ------- 로그인 ------ */

/* 사용자 체크 */
class UserExistResponse {
  bool status;
  String flag;
  String message;
  String? email;
  Customer? customer;

  UserExistResponse(
      {required this.status,
      required this.flag,
      required this.message,
      this.email,
      this.customer});

  factory UserExistResponse.fromJson(Map<String, dynamic> json) =>
      UserExistResponse(
          status: json['status'],
          flag: json['flag'],
          message: json['message'] ?? '',
          email: json['email'],
          customer: json['customer'] != null
              ? Customer.fromJson(json['customer'])
              : null);
}
/* ---- 사용자 체크 ----- */

/* 아이디 찾기 */
class IdFindResponse {
  bool status;
  String message;
  String? email;
  IdFindResponse({required this.status, required this.message, this.email});

  factory IdFindResponse.fromJson(Map<String, dynamic> json) => IdFindResponse(
      status: json['status'],
      message: json['message'] ?? '',
      email: json['email']);
}
/* ----- 아이디 찾기 ----- */

/* 가비아 인증번호 전송 */

class SmsKeyResponse {
  bool status;
  String message;
  int? data;
  SmsKeyResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  factory SmsKeyResponse.fromJson(Map<String, dynamic> json) => SmsKeyResponse(
      status: json['status'],
      message: json['message'] ?? '',
      data: json['data']);
}
