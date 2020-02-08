class User {
    String regImei;
    String regSerial;
    String mpesaSmsData;
    String callData;

    User({
        this.regImei,
        this.regSerial,
        this.mpesaSmsData,
        this.callData
    });

    // factory User.fromJson(Map<String, dynamic> json) => User(
    //     regImei: json["reg_imei"],
    //     regSerial: json["reg_serial"],
    //     mpesaSmsData: json["mpesa_sms_data"],
    //     callData: json["call_data"]
    // );

    Map<String, dynamic> toJson() => {
        "reg_imei": regImei,
        "reg_serial": regSerial,
        "mpesa_sms_data": mpesaSmsData,
        "call_data": callData
    };
}