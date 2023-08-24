import 'package:user_core2/model/auth.dart';
import 'package:user_core2/model/cart.dart';
import 'package:user_core2/model/product.dart';
import 'package:user_core2/model/store.dart';

/* 주문 생성 */
class OrderRequestBody {
  OrderRequestBodyData data;
  dynamic addressId;
  dynamic shippingFeeSettingId;
  Customer customer;
  dynamic tenantId;
  List<OrderRequestItem> items;
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
    body['items'] = items.map((e) => e.toJson()).toList();
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

class OrderRequestItem {
  dynamic productId;
  int quantity;
  List<CartOption>? options;

  OrderRequestItem(
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
/* ------- 주문 생성 ------- */

/* 주문내역 */
class OrderResponse {
  bool status;
  String message;
  OrderResponseData data;
  OrderResponse(
      {required this.status, required this.message, required this.data});
  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
      status: json['status'],
      message: json['message'],
      data: OrderResponseData.fromJson(json['data']));
}

class OrderResponseData {
  List<Order> data;
  int total;
  OrderResponseData({required this.data, required this.total});
  factory OrderResponseData.fromJson(Map<String, dynamic> json) =>
      OrderResponseData(
          data: json['data'] != null
              ? List<Order>.from(json['data'].map((x) => Order.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class Order {
  dynamic id;
  String orderNo;
  String orderType;
  String orderStatus;
  Map<dynamic, dynamic> orderRequest;
  int orderPriceAmount;
  int orderShippingFee;
  int orderPaymentAmount;
  int orderPaidAmount;
  int orderPaidShippingFee;
  int orderDiscountAmount;
  int orderCouponDiscountAmount;
  int orderAdditionalPaymentAmount;
  int orderRemainAmount;
  bool isPaid;
  bool isOnline;
  bool isReviewed;
  bool isUseDiscountCoupon;
  List<dynamic> payments;
  Customer customer;
  List<OrderItem> items;
  DateTime createdAt;
  OrderShippingDetail? shippingDetail;
  Order(
      {this.id,
      required this.orderNo,
      required this.orderType,
      required this.orderStatus,
      required this.orderRequest,
      required this.orderPriceAmount,
      required this.orderShippingFee,
      required this.orderPaymentAmount,
      required this.orderPaidAmount,
      required this.orderPaidShippingFee,
      required this.orderDiscountAmount,
      required this.orderCouponDiscountAmount,
      required this.orderAdditionalPaymentAmount,
      required this.orderRemainAmount,
      required this.isPaid,
      required this.isOnline,
      required this.isReviewed,
      required this.isUseDiscountCoupon,
      required this.payments,
      required this.customer,
      required this.items,
      required this.createdAt,
      required this.shippingDetail});
  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json['id'],
      orderNo: json['order_no'],
      orderType: json['order_type'],
      orderStatus: json['order_status'],
      orderRequest: json['order_request'],
      orderPriceAmount: json['order_price_amount'],
      orderShippingFee: json['order_shipping_fee'],
      orderPaymentAmount: json['order_payment_amount'],
      orderPaidAmount: json['order_paid_amount'],
      orderPaidShippingFee: json['order_paid_shipping_fee'],
      orderDiscountAmount: json['order_discount_amount'],
      orderCouponDiscountAmount: json['order_coupon_discount_amount'],
      orderAdditionalPaymentAmount: json['order_additional_payment_amount'],
      orderRemainAmount: json['order_remain_amount'],
      isPaid: json['is_paid'],
      isOnline: json['is_online'],
      isReviewed: json['is_reviewed'],
      isUseDiscountCoupon: json['is_use_discount_coupon'],
      payments: json['payments'],
      customer: Customer.fromJson(json['customer']),
      items: json['items'] != null
          ? List<OrderItem>.from(
              json['items'].map((e) => OrderItem.fromJson(e)))
          : [],
      createdAt: DateTime.parse(
        json['created_at'],
      ),
      shippingDetail: json['shipping_detail'] != null
          ? OrderShippingDetail.fromJson(json['shipping_detail'])
          : null);
}

class OrderShippingDetail {
  Map<dynamic, dynamic>?
      receiver; // {'name':'', 'contact': '', 'zipcode': '', 'address1': '', 'address2': ''}
  dynamic trackingNo;
  String shoppingStatus;
  dynamic deliveredAt;
  OrderShippingDetail(
      {required this.receiver,
      required this.trackingNo,
      required this.shoppingStatus,
      required this.deliveredAt});
  factory OrderShippingDetail.fromJson(Map<String, dynamic> json) =>
      OrderShippingDetail(
          receiver: json['receiver'],
          trackingNo: json['tracking_no'],
          shoppingStatus: json['shopping_status'] ?? '',
          deliveredAt: json['delivered_at']);
}

class OrderItem {
  dynamic id;
  String itemNo;
  String orderNo;
  String orderStatus;
  String orderType;
  bool isCanceled;
  bool isConfirmedPurchase;
  bool isPassed;
  bool isPurchasable;
  int itemAdditionalPaymentAmount;
  int itemCouponDiscountAmount;
  int itemCustomDiscountAmount;
  int itemCustomDiscountPercentage;
  int itemPaymentAmount;
  int itemPriceAmount;
  DateTime? confirmedPurchaseAt;
  List<CartOption> options;
  DateTime createdAt;
  int productQuantity;
  int productPrice;
  int optionsPrice;
  bool isReviewed;
  Product? product;
  Store? store;
  OrderItem(
      {required this.id,
      required this.itemNo,
      required this.orderNo,
      required this.orderStatus,
      required this.orderType,
      required this.isCanceled,
      required this.isConfirmedPurchase,
      required this.isPassed,
      required this.isPurchasable,
      required this.itemAdditionalPaymentAmount,
      required this.itemCouponDiscountAmount,
      required this.itemCustomDiscountAmount,
      required this.itemCustomDiscountPercentage,
      required this.itemPaymentAmount,
      required this.itemPriceAmount,
      required this.confirmedPurchaseAt,
      required this.options,
      required this.createdAt,
      required this.productQuantity,
      required this.productPrice,
      required this.optionsPrice,
      required this.isReviewed,
      required this.product,
      required this.store});
  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'],
      itemNo: json['item_no'],
      orderNo: json['order_no'],
      orderStatus: json['order_status'],
      orderType: json['order_type'],
      isCanceled: json['is_canceled'],
      isConfirmedPurchase: json['is_confirmed_purchase'],
      isPassed: json['is_passed'],
      isPurchasable: json['is_purchasable'],
      itemAdditionalPaymentAmount: json['item_additional_payment_amount'],
      itemCouponDiscountAmount: json['item_coupon_discount_amount'],
      itemCustomDiscountAmount: json['item_custom_discount_amount'],
      itemCustomDiscountPercentage: json['item_custom_discount_percentage'],
      itemPaymentAmount: json['item_payment_amount'],
      itemPriceAmount: json['item_price_amount'],
      confirmedPurchaseAt: json['confirmed_purchase_at'] != null
          ? DateTime.parse(json['confirmed_purchase_at'])
          : null,
      options: json['options'] != null
          ? List<CartOption>.from(
              json['options'].map((e) => CartOption.fromJson(e)))
          : [],
      createdAt: DateTime.parse(json['created_at']),
      productQuantity: json['product_quantity'],
      productPrice: json['product_price'],
      optionsPrice: json['options_price'],
      isReviewed: json['is_reviewed'],
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
      store: json['store'] != null ? Store.fromJson(json['store']) : null);
}
