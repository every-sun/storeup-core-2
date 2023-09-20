class CouponResponse {
  bool status;
  String message;
  CouponResponseData? data;
  CouponResponse(
      {required this.status, required this.message, required this.data});
  factory CouponResponse.fromJson(Map<String, dynamic> json) => CouponResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? CouponResponseData.fromJson(json['data'])
          : null);
}

class CouponResponseData {
  List<Coupon> data;
  int total;
  CouponResponseData({
    required this.data,
    required this.total,
  });
  factory CouponResponseData.fromJson(Map<String, dynamic> json) =>
      CouponResponseData(
        data: json['data'] != null
            ? List<Coupon>.from(json['data'].map((x) => Coupon.fromJson(x)))
            : [],
        total: json['total'],
      );
}

class Coupon {
  dynamic id;
  dynamic couponId;
  String couponNo;
  String couponName;
  String couponDescription;
  String conditionType;
  String type;
  int discountAmount;
  int discountPercentage;
  int availableAmountMin;
  int availableAmountMax;
  String availableFrom;
  String issuedAt;
  String expireAt;
  String? usedAt;
  bool isUsed;
  bool isExpired;
  String? restoredAt;
  dynamic orderId;
  Coupon(
      {required this.id,
      required this.couponId,
      required this.couponNo,
      required this.couponName,
      required this.couponDescription,
      required this.conditionType,
      required this.type,
      required this.discountAmount,
      required this.discountPercentage,
      required this.availableAmountMax,
      required this.availableAmountMin,
      required this.availableFrom,
      required this.isUsed,
      required this.isExpired,
      required this.issuedAt,
      required this.orderId,
      required this.expireAt,
      required this.restoredAt,
      required this.usedAt});
  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json['id'],
        couponId: json['coupon_id'],
        couponNo: json['coupon_no'],
        couponName: json['coupon_name'],
        couponDescription: json['coupon_description'],
        conditionType: json['condition_type'],
        type: json['type'],
        discountAmount: json['discount_amount'],
        discountPercentage: json['discount_percentage'],
        availableAmountMax: json['available_amount_max'],
        availableAmountMin: json['available_amount_min'],
        availableFrom: json['available_from'],
        isUsed: json['is_used'],
        isExpired: json['is_expired'],
        issuedAt: json['issued_at'],
        orderId: json['order_id'],
        expireAt: json['expire_at'],
        restoredAt: json['restored_at'],
        usedAt: json['used_at'],
      );
}

class PointResponse {
  bool status;
  String message;
  PointResponseData? data;
  PointResponse(
      {required this.status, required this.message, required this.data});
  factory PointResponse.fromJson(Map<String, dynamic> json) => PointResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? PointResponseData.fromJson(json['data'])
          : null);
}

class PointResponseData {
  List<Point> data;
  int total;
  PointResponseData({required this.data, required this.total});
  factory PointResponseData.fromJson(Map<String, dynamic> json) =>
      PointResponseData(
          total: json['total'],
          data: json['data'] != null
              ? List<Point>.from(json['data'].map((x) => Point.fromJson(x)))
              : []);
}

class Point {
  dynamic id;
  int amount;
  int availableAmount;
  bool isExpired;
  bool isIncrease;
  String reason;
  String? itemNo;
  String? orderNo;
  DateTime createdAt;
  Point(
      {required this.id,
      required this.amount,
      required this.availableAmount,
      required this.isExpired,
      required this.isIncrease,
      required this.reason,
      required this.itemNo,
      required this.orderNo,
      required this.createdAt});
  factory Point.fromJson(Map<String, dynamic> json) => Point(
      id: json['id'],
      amount: json['amount'],
      availableAmount: json['available_amount'],
      isExpired: json['is_expired'],
      isIncrease: json['is_increase'],
      reason: json['reason'] ?? '',
      itemNo: json['item_no'],
      orderNo: json['order_no'],
      createdAt: DateTime.parse(json['created_at']));
}
