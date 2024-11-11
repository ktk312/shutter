class ShutterDeviceModel {
  final String? deviceId;
  final String? deviceMac;
  final String? deviceName;
  final String? devicePanelOperationPercentage;
  final String? wifiPercentage;
  final String? batteryPercentage;
  final bool? deviceStatus;
  final bool? fCrep;
  final bool? fAuto;
  final bool? aParz;
  final bool? calenderStatus;
  final String? userName;
  final String? userEmail;
  final String? userId;
  final DateTime? timestamp;
  final String? shutterType;
  final String? priority;
  final int? numberOfMotors;
  final bool? hasDeviceSchedule;
  final bool? shutterIconStatus;
  final String? autoPlayTime;
  final bool? autoPlay;
  final int? sleepTime;
  final int? openingEffort1;
  final int? openingEffort2;
  final int? openingEffort3;
  final int? closingEffort1;
  final int? closingEffort2;
  final int? closingEffort3;
  final int? alarmResetButton;

  ShutterDeviceModel({
    this.deviceId,
    this.deviceMac,
    this.deviceName,
    this.devicePanelOperationPercentage,
    this.wifiPercentage,
    this.batteryPercentage,
    this.deviceStatus,
    this.fCrep,
    this.fAuto,
    this.aParz,
    this.calenderStatus,
    this.userName,
    this.userEmail,
    this.userId,
    this.timestamp,
    this.shutterType,
    this.priority,
    this.numberOfMotors,
    this.hasDeviceSchedule,
    this.shutterIconStatus,
    this.autoPlayTime,
    this.autoPlay,
    this.sleepTime,
    this.openingEffort1,
    this.openingEffort2,
    this.openingEffort3,
    this.closingEffort1,
    this.closingEffort2,
    this.closingEffort3,
    this.alarmResetButton,
  });

  factory ShutterDeviceModel.fromJson(Map<dynamic, dynamic> json) {
    return ShutterDeviceModel(
      deviceId: json['deviceId'] as String?,
      deviceMac: json['deviceMac'] as String?,
      deviceName: json['deviceName'] as String?,
      devicePanelOperationPercentage:
          json['devicePanelOperationPercentage'] as String?,
      wifiPercentage: json['wifiPercentage'] as String?,
      batteryPercentage: json['batteryPercentage'] as String?,
      deviceStatus: json['deviceStatus'] as bool?,
      fCrep: json['fCrep'] as bool?,
      fAuto: json['fAuto'] as bool?,
      aParz: json['aParz'] as bool?,
      calenderStatus: json['calenderStatus'] as bool?,
      userName: json['userName'] as String?,
      userEmail: json['userEmail'] as String?,
      userId: json['userId'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
      shutterType: json['shutterType'] as String?,
      priority: json['priority'] as String?,
      numberOfMotors: json['numberOfMotors'] as int?,
      hasDeviceSchedule: json['hasDeviceSchedule'] as bool?,
      shutterIconStatus: json['shutterIconStatus'] as bool?,
      autoPlayTime: json['autoPlayTime'] as String?,
      autoPlay: json['autoPlay'] as bool?,
      sleepTime: json['sleepTime'] as int?,
      openingEffort1: json['openingEffort1'] as int?,
      openingEffort2: json['openingEffort2'] as int?,
      openingEffort3: json['openingEffort3'] as int?,
      closingEffort1: json['closingEffort1'] as int?,
      closingEffort2: json['closingEffort2'] as int?,
      closingEffort3: json['closingEffort3'] as int?,
      alarmResetButton: json['alarmResetButton'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId ?? '',
      'deviceMac': deviceMac ?? '',
      'deviceName': deviceName ?? '',
      'devicePanelOperationPercentage': devicePanelOperationPercentage ?? '',
      'wifiPercentage': wifiPercentage ?? false,
      'batteryPercentage': batteryPercentage ?? 0,
      'deviceStatus': deviceStatus ?? false,
      'fCrep': fCrep ?? false,
      'fAuto': fAuto ?? false,
      'aParz': aParz ?? false,
      'calenderStatus': calenderStatus ?? false,
      'userName': userName ?? '',
      'userEmail': userEmail ?? '',
      'userId': userId ?? '',
      'timestamp': timestamp?.toIso8601String() ?? '',
      'shutterType': shutterType ?? '',
      'priority': priority ?? '',
      'numberOfMotors': numberOfMotors ?? 1,
      'hasDeviceSchedule': hasDeviceSchedule ?? false,
      'shutterIconStatus': shutterIconStatus ?? false,
      'autoPlayTime': autoPlayTime ?? '',
      'autoPlay': autoPlay ?? false,
      'sleepTime': sleepTime ?? 0,
      'openingEffort1': openingEffort1 ?? 0,
      'openingEffort2': openingEffort2 ?? 0,
      'openingEffort3': openingEffort3 ?? 0,
      'closingEffort1': closingEffort1 ?? 0,
      'closingEffort2': closingEffort2 ?? 0,
      'closingEffort3': closingEffort3 ?? 0,
      'alarmResetButton': alarmResetButton ?? 0,
    };
  }
}
