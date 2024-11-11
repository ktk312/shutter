import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Dashboard/Controller/device_controller.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class EditDevice extends StatefulWidget {
  final String deviceId;
  final String roomName;
  final bool initialStatus;
  final bool initialFCrep;
  final bool initialFAuto;
  final bool initialAParz;
  final bool initialCalender;

  const EditDevice({
    super.key,
    required this.deviceId,
    required this.roomName,
    required this.initialStatus,
    required this.initialFCrep,
    required this.initialFAuto,
    required this.initialAParz,
    required this.initialCalender,
  });

  @override
  _EditDeviceState createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {
  late bool status;
  late bool fCrep;
  late bool fAuto;
  late bool aParz;
  late bool calender;

  @override
  void initState() {
    super.initState();
    status = widget.initialStatus;
    fCrep = widget.initialFCrep;
    fAuto = widget.initialFAuto;
    aParz = widget.initialAParz;
    calender = widget.initialCalender;
  }

  final deviceController = Get.put(DeviceController());

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController = Get.find();
    return Obx(
      () => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(
          localizationController.localizedValues['edit_device']!,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, fontFamily: 'Poppins'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.roomName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                fontSize: 18,
              ),
            ),
            _buildToggleRow(localizationController.localizedValues['status']!,
                status ? 'Open' : 'Stop', status, (value) {
              setState(() {
                status = value;
              });
            }),
            _buildToggleRow(localizationController.localizedValues['f_crep']!,
                fCrep ? 'ON' : 'OFF', fCrep, (value) {
              setState(() {
                fCrep = value;
              });
            }),
            _buildToggleRow(localizationController.localizedValues['f_auto']!,
                fAuto ? 'ON' : 'OFF', fAuto, (value) {
              setState(() {
                fAuto = value;
              });
            }),
            _buildToggleRow(localizationController.localizedValues['a_parz']!,
                aParz ? 'ON' : 'OFF', aParz, (value) {
              setState(() {
                aParz = value;
              });
            }),
            _buildToggleRow(localizationController.localizedValues['calendar']!,
                calender ? 'ON' : 'OFF', calender, (value) {
              setState(() {
                calender = value;
              });
            }),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(localizationController.localizedValues['cancel']!),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await deviceController.updateDevice(
                  widget.deviceId, status, fCrep, fAuto, aParz, calender);

              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(localizationController.localizedValues['update']!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow(
      String label, String value, bool toggleValue, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Switch(
            value: toggleValue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
