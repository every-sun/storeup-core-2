import 'package:user_core2/model/auth.dart';
import 'package:user_core2/model/cart.dart';

/* 주문 생성 */
class OrderRequestBody {
  OrderRequestBodyData data;
  dynamic addressId;
  dynamic shippingFeeSettingId;
  Customer customer;
  dynamic tenantId;
  List<OrderItem> items;
  OrderRequestBody(
      {required this.data,
      required this.addressId,
      required this.shippingFeeSettingId,
      required this.customer,
      required this.tenantId,
      required this.items});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = Map<String, dynamic>();
    body['data'] = data.toJson();
    body['address_id'] = addressId;
    body['shipping_fee_setting_id'] = shippingFeeSettingId;
    body['customer'] = customer.toJson();
    body['tenant_id'] = tenantId;
    body['items'] = items.map((e) => e.toJson());
    return body;
  }
}

class OrderRequestBodyData {
  dynamic brandId;
  String orderType;
  String orderMethod;
  int orderShippingFee;
  int orderPriceAmount;
  bool isUseDiscountCoupon;
  int orderDiscountAmount;
  int orderCouponDiscountAmount;
  int orderCustomDiscountAmount;
  int orderAdditionalPaymentAmount;
  int orderPaymentAmount;
  bool isOnline;
  Map<dynamic, dynamic> orderRequest;

  OrderRequestBodyData(
      {required this.brandId,
      required this.orderType,
      required this.orderMethod,
      required this.orderShippingFee,
      required this.orderPriceAmount,
      required this.isUseDiscountCoupon,
      required this.orderDiscountAmount,
      required this.orderCouponDiscountAmount,
      required this.orderCustomDiscountAmount,
      required this.orderAdditionalPaymentAmount,
      required this.orderPaymentAmount,
      required this.isOnline,
      required this.orderRequest});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = Map<String, dynamic>();
    body['brand_id'] = brandId;
    body['order_type'] = orderType;
    body['order_method'] = orderMethod;
    body['order_shipping_fee'] = orderShippingFee;
    body['order_price_amount'] = orderPriceAmount;
    body['is_use_discount_coupon'] = isUseDiscountCoupon;
    body['order_discount_amount'] = orderDiscountAmount;
    body['order_coupon_discount_amount'] = orderCouponDiscountAmount;
    body['order_custom_discount_amount'] = orderCustomDiscountAmount;
    body['order_additional_payment_amount'] = orderAdditionalPaymentAmount;
    body['order_payment_amount'] = orderPaymentAmount;
    body['is_online'] = isOnline;
    body['order_request'] = orderRequest;
    return body;
  }
}

class OrderItem {
  dynamic productId;
  int quantity;
  List<CartOption>? options;

  OrderItem(
      {required this.productId, required this.quantity, required this.options});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = Map<String, dynamic>();
    body['product_id'] = productId;
    body['quantity'] = quantity;
    body['options'] =
        options != null ? options!.map((v) => v.toJson()).toList() : null;
    return body;
  }
}
