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
