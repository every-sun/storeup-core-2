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
  int quantity;
  Map<String, String>? pickup;
  Map<String, String>? reShippingData;

  ClaimRequestBody(
      {required this.orderId,
      required this.isCancelAll,
      required this.itemId,
      required this.claimType,
      required this.claimReasonType,
      required this.claimSubject,
      required this.quantity,
      required this.pickup});
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
    body['re_shipping_data'] = reShippingData;
    return body;
  }
}
