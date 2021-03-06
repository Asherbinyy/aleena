class Order {
  int? id;
  String? deliveryPhone;
  String? orderNumber;
  String? clientName;
  String? phone;
  String? price;
  String? paymentMethod;
  int? status;
  String? address;
  String? deliveryName;
  String? deliveryImage;
  String? qrCode;
  String? duration;

  Order({
    this.id,
    this.deliveryPhone,
    this.orderNumber,
    this.clientName,
    this.phone,
    this.price,
    this.paymentMethod,
    this.status,
    this.address,
    this.deliveryImage,
    this.deliveryName,
    this.qrCode,
    this.duration,

  });

  Order.fromJson(Map<String, dynamic> map) {
    this.id = map['id'] ?? 0;
    this.deliveryPhone = map['deliveryPhone'] ?? 0;
    this.orderNumber = map['order_number'] ?? '';
    this.clientName = map['client_name'] ?? '';
    this.phone = map['phone'] ?? '';
    this.price = map['price'] ?? '';
    this.paymentMethod = map['order_type'] ?? '';
    this.status = map['status'] ?? 0;
    this.address = map['address'] ?? '';
    this.deliveryName = map['deliveryName'] ?? '';
    this.deliveryImage = map['deliveryImage'] ?? '';
    this.qrCode = map['qrCode'] ?? '';
    this.duration = map['duration'] ?? '';
  }
}