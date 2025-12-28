class PaymentDetailsModel {
  final String apartmentId;
  final String apartmentTitle;
  final int amount;
  final int serviceFee;
  final String paymentMethod;
  final String? cardNumber;
  final String? cardHolderName;
  final String? expiryDate;
  final DateTime timestamp;
  final String transactionId;
  final PaymentStatus status;

  PaymentDetailsModel({
    required this.apartmentId,
    required this.apartmentTitle,
    required this.amount,
    this.serviceFee = 10,
    required this.paymentMethod,
    this.cardNumber,
    this.cardHolderName,
    this.expiryDate,
    required this.timestamp,
    required this.transactionId,
    this.status = PaymentStatus.pending,
  });

  int get totalAmount => amount + serviceFee;

  Map<String, dynamic> toJson() {
    return {
      'apartmentId': apartmentId,
      'apartmentTitle': apartmentTitle,
      'amount': amount,
      'serviceFee': serviceFee,
      'paymentMethod': paymentMethod,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'timestamp': timestamp.toIso8601String(),
      'transactionId': transactionId,
      'status': status.name,
    };
  }

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    return PaymentDetailsModel(
      apartmentId: json['apartmentId'],
      apartmentTitle: json['apartmentTitle'],
      amount: json['amount'],
      serviceFee: json['serviceFee'] ?? 10,
      paymentMethod: json['paymentMethod'],
      cardNumber: json['cardNumber'],
      cardHolderName: json['cardHolderName'],
      expiryDate: json['expiryDate'],
      timestamp: DateTime.parse(json['timestamp']),
      transactionId: json['transactionId'],
      status: PaymentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => PaymentStatus.pending,
      ),
    );
  }

  PaymentDetailsModel copyWith({
    String? apartmentId,
    String? apartmentTitle,
    int? amount,
    int? serviceFee,
    String? paymentMethod,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    DateTime? timestamp,
    String? transactionId,
    PaymentStatus? status,
  }) {
    return PaymentDetailsModel(
      apartmentId: apartmentId ?? this.apartmentId,
      apartmentTitle: apartmentTitle ?? this.apartmentTitle,
      amount: amount ?? this.amount,
      serviceFee: serviceFee ?? this.serviceFee,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      timestamp: timestamp ?? this.timestamp,
      transactionId: transactionId ?? this.transactionId,
      status: status ?? this.status,
    );
  }
}

enum PaymentStatus { pending, processing, success, failed, cancelled }

enum PaymentMethodType { card, fawry, vodafoneCash, instapay, cash }
