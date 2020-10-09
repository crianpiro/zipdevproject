class PayloadEvent<T> {
  dynamic body;
  T response;
  PayloadEvent(
    this.body,
  );
  factory PayloadEvent.fromJson(dynamic json) => PayloadEvent(
        json,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'body': body,
      };
}