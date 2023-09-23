import 'package:user_core2/model/order.dart';

class RefundResponse {
  bool status;
  String message;
  RefundResponseData? data;
  RefundResponse(
      {required this.status, required this.message, required this.data});
  factory RefundResponse.fromJson(Map<String, dynamic> json) => RefundResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? RefundResponseData.fromJson(json['data'])
          : null);
}

class RefundResponseData {
  int refundAmount;
  int refundItemAmount;
  int refundPointAmount;
  int refundShippingFee;
  int chargingShippingFee;
  RefundResponseData(
      {required this.refundAmount,
      required this.refundItemAmount,
      required this.refundPointAmount,
      required this.refundShippingFee,
      required this.chargingShippingFee});
  factory RefundResponseData.fromJson(Map<String, dynamic> json) =>
      RefundResponseData(
          refundAmount: json['refund_amount'],
          refundItemAmount: json['refund_item_amount'],
          refundPointAmount: json['refund_point_amount'],
          refundShippingFee: json['refund_shipping_fee'],
          chargingShippingFee: json['charging_shipping_fee']);
}

class ClaimRequestBody {
  dynamic orderId;
  bool isCancelAll;
  dynamic itemId;
  String claimType;
  String claimReasonType;
  String claimSubject;
  int? quantity;
  Map<String, dynamic>? pickup;
  String claimReason;

  ClaimRequestBody(
      {required this.orderId,
      required this.isCancelAll,
      required this.itemId,
      required this.claimType,
      required this.claimReasonType,
      required this.claimSubject,
      required this.quantity,
      required this.pickup,
      required this.claimReason});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = Map<String, dynamic>();
    body['order_id'] = orderId;
    body['is_cancel_all'] = isCancelAll;
    body['item_id'] = itemId;
    body['claim_type'] = claimType;
    body['claim_reason_type'] = claimReasonType;
    body['claim_subject'] = claimSubject;
    body['quantity'] = quantity;
    body['pickup'] = pickup;
    body['claim_reason'] = claimReason;
    return body;
  }
}

class ClaimResponse {
  bool status;
  String message;
  List<Claim>? data;
  ClaimResponse(
      {required this.status, required this.message, required this.data});
  factory ClaimResponse.fromJson(Map<String, dynamic> json) => ClaimResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] != null && json['data']['data'] != null)
          ? List<Claim>.from(json['data']['data'].map((x) => Claim.fromJson(x)))
          : null);
}

class Claim {
  dynamic id;
  String claimReasonType;
  String claimSubject;
  String claimType;
  String claimReason;
  String itemNo;
  bool isAccepted;
  bool isCancelAll;
  bool isChecked;
  bool isRejected;
  bool isClosed;
  bool isUndone;
  String orderNo;
  String pastStatus;
  int quantity;
  String rejectReason;
  RefundResponseData? refundData;
  DateTime createdAt;
  dynamic refundAccount;
  OrderItem? item;
  Map? data;
  Map? pickup;
  Map? reShipping;
  Claim(
      {required this.id,
      required this.claimReasonType,
      required this.claimSubject,
      required this.claimType,
      required this.claimReason,
      required this.itemNo,
      required this.isAccepted,
      required this.isCancelAll,
      required this.isChecked,
      required this.isRejected,
      required this.isClosed,
      required this.isUndone,
      required this.orderNo,
      required this.pastStatus,
      required this.quantity,
      required this.rejectReason,
      required this.refundData,
      required this.createdAt,
      required this.refundAccount,
      required this.item,
      required this.data,
      required this.pickup,
      required this.reShipping});
  factory Claim.fromJson(Map<String, dynamic> json) => Claim(
      id: json['id'],
      claimReasonType: json['claim_reason_type'],
      claimSubject: json['claim_subject'],
      claimType: json['claim_type'],
      claimReason: json['claim_reason'] ?? '',
      itemNo: json['item_no'],
      isAccepted: json['is_accepted'],
      isCancelAll: json['is_cancel_all'],
      isChecked: json['is_checked'],
      isRejected: json['is_rejected'],
      isClosed: json['is_closed'],
      isUndone: json['is_undone'],
      orderNo: json['order_no'] ?? '',
      pastStatus: json['past_status'] ?? '',
      quantity: json['quantity'],
      rejectReason: json['reject_reason'] ?? '',
      refundData: json['refund_data'] != null
          ? RefundResponseData.fromJson(json['refund_data'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      refundAccount: json['refund_account'] ?? '',
      item: json['item'] != null ? OrderItem.fromJson(json['item']) : null,
      data: json['data'],
      pickup: json['pickup'],
      reShipping: json['re_shipping']);
}
