// To parse this JSON data, do
//
//     final subScribePlanModel = subScribePlanModelFromJson(jsonString);

import 'dart:convert';

SubScribePlanModel subScribePlanModelFromJson(String str) =>
    SubScribePlanModel.fromJson(json.decode(str));

String subScribePlanModelToJson(SubScribePlanModel data) =>
    json.encode(data.toJson());

class SubScribePlanModel {
  bool? status;
  String? text;
  Subscription? subscription;

  SubScribePlanModel({
    this.status,
    this.text,
    this.subscription,
  });

  factory SubScribePlanModel.fromJson(Map<String, dynamic> json) =>
      SubScribePlanModel(
        status: json["status"],
        text: json["text"],
        subscription: json["subscription"] == null
            ? null
            : Subscription.fromJson(json["subscription"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "subscription": subscription?.toJson(),
      };
}

class Subscription {
  String? id;
  String? object;
  dynamic afterExpiration;
  dynamic allowPromotionCodes;
  int? amountSubtotal;
  int? amountTotal;
  AutomaticTax? automaticTax;
  dynamic billingAddressCollection;
  String? cancelUrl;
  String? clientReferenceId;
  dynamic clientSecret;
  dynamic consent;
  dynamic consentCollection;
  int? created;
  String? currency;
  dynamic currencyConversion;
  List<dynamic>? customFields;
  CustomText? customText;
  String? customer;
  dynamic customerCreation;
  CustomerDetails? customerDetails;
  dynamic customerEmail;
  int? expiresAt;
  dynamic invoice;
  dynamic invoiceCreation;
  bool? livemode;
  dynamic locale;
  List<dynamic>? metadata;
  String? mode;
  dynamic paymentIntent;
  dynamic paymentLink;
  String? paymentMethodCollection;
  dynamic paymentMethodConfigurationDetails;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  String? paymentStatus;
  PhoneNumberCollection? phoneNumberCollection;
  dynamic recoveredFrom;
  dynamic setupIntent;
  dynamic shipping;
  dynamic shippingAddressCollection;
  List<dynamic>? shippingOptions;
  dynamic shippingRate;
  String? status;
  dynamic submitType;
  dynamic subscription;
  String? successUrl;
  TotalDetails? totalDetails;
  String? uiMode;
  String? url;

  Subscription({
    this.id,
    this.object,
    this.afterExpiration,
    this.allowPromotionCodes,
    this.amountSubtotal,
    this.amountTotal,
    this.automaticTax,
    this.billingAddressCollection,
    this.cancelUrl,
    this.clientReferenceId,
    this.clientSecret,
    this.consent,
    this.consentCollection,
    this.created,
    this.currency,
    this.currencyConversion,
    this.customFields,
    this.customText,
    this.customer,
    this.customerCreation,
    this.customerDetails,
    this.customerEmail,
    this.expiresAt,
    this.invoice,
    this.invoiceCreation,
    this.livemode,
    this.locale,
    this.metadata,
    this.mode,
    this.paymentIntent,
    this.paymentLink,
    this.paymentMethodCollection,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.paymentStatus,
    this.phoneNumberCollection,
    this.recoveredFrom,
    this.setupIntent,
    this.shipping,
    this.shippingAddressCollection,
    this.shippingOptions,
    this.shippingRate,
    this.status,
    this.submitType,
    this.subscription,
    this.successUrl,
    this.totalDetails,
    this.uiMode,
    this.url,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        object: json["object"],
        afterExpiration: json["after_expiration"],
        allowPromotionCodes: json["allow_promotion_codes"],
        amountSubtotal: json["amount_subtotal"],
        amountTotal: json["amount_total"],
        automaticTax: json["automatic_tax"] == null
            ? null
            : AutomaticTax.fromJson(json["automatic_tax"]),
        billingAddressCollection: json["billing_address_collection"],
        cancelUrl: json["cancel_url"],
        clientReferenceId: json["client_reference_id"],
        clientSecret: json["client_secret"],
        consent: json["consent"],
        consentCollection: json["consent_collection"],
        created: json["created"],
        currency: json["currency"],
        currencyConversion: json["currency_conversion"],
        customFields: json["custom_fields"] == null
            ? []
            : List<dynamic>.from(json["custom_fields"]!.map((x) => x)),
        customText: json["custom_text"] == null
            ? null
            : CustomText.fromJson(json["custom_text"]),
        customer: json["customer"],
        customerCreation: json["customer_creation"],
        customerDetails: json["customer_details"] == null
            ? null
            : CustomerDetails.fromJson(json["customer_details"]),
        customerEmail: json["customer_email"],
        expiresAt: json["expires_at"],
        invoice: json["invoice"],
        invoiceCreation: json["invoice_creation"],
        livemode: json["livemode"],
        locale: json["locale"],
        metadata: json["metadata"] == null
            ? []
            : List<dynamic>.from(json["metadata"]!.map((x) => x)),
        mode: json["mode"],
        paymentIntent: json["payment_intent"],
        paymentLink: json["payment_link"],
        paymentMethodCollection: json["payment_method_collection"],
        paymentMethodConfigurationDetails:
            json["payment_method_configuration_details"],
        paymentMethodOptions: json["payment_method_options"] == null
            ? null
            : PaymentMethodOptions.fromJson(json["payment_method_options"]),
        paymentMethodTypes: json["payment_method_types"] == null
            ? []
            : List<String>.from(json["payment_method_types"]!.map((x) => x)),
        paymentStatus: json["payment_status"],
        phoneNumberCollection: json["phone_number_collection"] == null
            ? null
            : PhoneNumberCollection.fromJson(json["phone_number_collection"]),
        recoveredFrom: json["recovered_from"],
        setupIntent: json["setup_intent"],
        shipping: json["shipping"],
        shippingAddressCollection: json["shipping_address_collection"],
        shippingOptions: json["shipping_options"] == null
            ? []
            : List<dynamic>.from(json["shipping_options"]!.map((x) => x)),
        shippingRate: json["shipping_rate"],
        status: json["status"],
        submitType: json["submit_type"],
        subscription: json["subscription"],
        successUrl: json["success_url"],
        totalDetails: json["total_details"] == null
            ? null
            : TotalDetails.fromJson(json["total_details"]),
        uiMode: json["ui_mode"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "after_expiration": afterExpiration,
        "allow_promotion_codes": allowPromotionCodes,
        "amount_subtotal": amountSubtotal,
        "amount_total": amountTotal,
        "automatic_tax": automaticTax?.toJson(),
        "billing_address_collection": billingAddressCollection,
        "cancel_url": cancelUrl,
        "client_reference_id": clientReferenceId,
        "client_secret": clientSecret,
        "consent": consent,
        "consent_collection": consentCollection,
        "created": created,
        "currency": currency,
        "currency_conversion": currencyConversion,
        "custom_fields": customFields == null
            ? []
            : List<dynamic>.from(customFields!.map((x) => x)),
        "custom_text": customText?.toJson(),
        "customer": customer,
        "customer_creation": customerCreation,
        "customer_details": customerDetails?.toJson(),
        "customer_email": customerEmail,
        "expires_at": expiresAt,
        "invoice": invoice,
        "invoice_creation": invoiceCreation,
        "livemode": livemode,
        "locale": locale,
        "metadata":
            metadata == null ? [] : List<dynamic>.from(metadata!.map((x) => x)),
        "mode": mode,
        "payment_intent": paymentIntent,
        "payment_link": paymentLink,
        "payment_method_collection": paymentMethodCollection,
        "payment_method_configuration_details":
            paymentMethodConfigurationDetails,
        "payment_method_options": paymentMethodOptions?.toJson(),
        "payment_method_types": paymentMethodTypes == null
            ? []
            : List<dynamic>.from(paymentMethodTypes!.map((x) => x)),
        "payment_status": paymentStatus,
        "phone_number_collection": phoneNumberCollection?.toJson(),
        "recovered_from": recoveredFrom,
        "setup_intent": setupIntent,
        "shipping": shipping,
        "shipping_address_collection": shippingAddressCollection,
        "shipping_options": shippingOptions == null
            ? []
            : List<dynamic>.from(shippingOptions!.map((x) => x)),
        "shipping_rate": shippingRate,
        "status": status,
        "submit_type": submitType,
        "subscription": subscription,
        "success_url": successUrl,
        "total_details": totalDetails?.toJson(),
        "ui_mode": uiMode,
        "url": url,
      };
}

class AutomaticTax {
  bool? enabled;
  dynamic liability;
  dynamic status;

  AutomaticTax({
    this.enabled,
    this.liability,
    this.status,
  });

  factory AutomaticTax.fromJson(Map<String, dynamic> json) => AutomaticTax(
        enabled: json["enabled"],
        liability: json["liability"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "liability": liability,
        "status": status,
      };
}

class CustomText {
  dynamic afterSubmit;
  dynamic shippingAddress;
  dynamic submit;
  dynamic termsOfServiceAcceptance;

  CustomText({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  factory CustomText.fromJson(Map<String, dynamic> json) => CustomText(
        afterSubmit: json["after_submit"],
        shippingAddress: json["shipping_address"],
        submit: json["submit"],
        termsOfServiceAcceptance: json["terms_of_service_acceptance"],
      );

  Map<String, dynamic> toJson() => {
        "after_submit": afterSubmit,
        "shipping_address": shippingAddress,
        "submit": submit,
        "terms_of_service_acceptance": termsOfServiceAcceptance,
      };
}

class CustomerDetails {
  dynamic address;
  String? email;
  dynamic name;
  dynamic phone;
  String? taxExempt;
  dynamic taxIds;

  CustomerDetails({
    this.address,
    this.email,
    this.name,
    this.phone,
    this.taxExempt,
    this.taxIds,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        address: json["address"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
        taxExempt: json["tax_exempt"],
        taxIds: json["tax_ids"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "email": email,
        "name": name,
        "phone": phone,
        "tax_exempt": taxExempt,
        "tax_ids": taxIds,
      };
}

class PaymentMethodOptions {
  Card? card;

  PaymentMethodOptions({
    this.card,
  });

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      PaymentMethodOptions(
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
      );

  Map<String, dynamic> toJson() => {
        "card": card?.toJson(),
      };
}

class Card {
  String? requestThreeDSecure;

  Card({
    this.requestThreeDSecure,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        requestThreeDSecure: json["request_three_d_secure"],
      );

  Map<String, dynamic> toJson() => {
        "request_three_d_secure": requestThreeDSecure,
      };
}

class PhoneNumberCollection {
  bool? enabled;

  PhoneNumberCollection({
    this.enabled,
  });

  factory PhoneNumberCollection.fromJson(Map<String, dynamic> json) =>
      PhoneNumberCollection(
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
      };
}

class TotalDetails {
  int? amountDiscount;
  int? amountShipping;
  int? amountTax;

  TotalDetails({
    this.amountDiscount,
    this.amountShipping,
    this.amountTax,
  });

  factory TotalDetails.fromJson(Map<String, dynamic> json) => TotalDetails(
        amountDiscount: json["amount_discount"],
        amountShipping: json["amount_shipping"],
        amountTax: json["amount_tax"],
      );

  Map<String, dynamic> toJson() => {
        "amount_discount": amountDiscount,
        "amount_shipping": amountShipping,
        "amount_tax": amountTax,
      };
}
