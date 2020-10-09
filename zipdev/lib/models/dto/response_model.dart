import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
    ResponseModel({
        this.statusCode,
        this.message,
        this.body,
    });

    String statusCode;
    String message;
    dynamic body;

    factory ResponseModel.fromJson(Map<String, dynamic> json) {
      return ResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        body: json["body"],
    );
    } 

    Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "Message": message,
        "Body": body,
    };
}
