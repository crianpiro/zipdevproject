
import 'package:zipdev/models/dto/payload_event.dart';

class Event<T> {
  String status;
  int statusCode;
  String message;
  dynamic extra;
  PayloadEvent<T> payload;
  Event.empty();
  Event(
    this.status,
    this.statusCode,
    this.message,
    this.extra,
    this.payload,
  );
  factory Event.fromJson(Map<String, dynamic> json) => Event(
        json['statusCode'] as String,
        int.parse(json['statusCode']),
        json['message'] as String,
        json['extra'] == null ? null : json['extra'],
        json['body'] == null ? null : PayloadEvent.fromJson(json['body']),
      );
}