// import 'package:dartx/dartx.dart';
import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///   created               : Aditya Pratama
///   originalFilename      : picker_widgets
///   date                  : 03 Jul 2021
///   modifier              : access only when controller inheritance [BaseController]

class PickerWidgets {
  // —————————————————————————————————————————————————————————————————————————
  // DATE PICKER (CUPERTINO) —————————————————————————————————————————————————
  // —————————————————————————————————————————————————————————————————————————
  void datePickerCupertino({
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    required Function(DateTime) picked,
  }) {
    var output = DateTime.now();
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (_) => Container(
        height: 320,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate ?? DateTime.now(),
                maximumDate: maxDate ?? DateTime(2050),
                onDateTimeChanged: (val) => output = val,
              ),
            ),
            // Close the modal
            ExButtonDefault(
                height: 52,
                width: 300,
                radius: 30,
                btnText: 'Pilih',
                onPress: () {
                  picked.call(output);
                  Navigator.of(Get.context!).pop();
                }),
          ],
        ),
      ),
    );
  }

  void timePickerCupertino({
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    required Function(DateTime) callback,
  }) {
    var output = DateTime.now();
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (_) => Container(
        height: 270,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: initialDate ?? DateTime.now(),
                maximumDate: maxDate ?? DateTime(2050),
                onDateTimeChanged: (val) => output = val,

                use24hFormat: true,
              ),
            ),
            // Close the modal
            CupertinoButton(
              child: const Text('OK'),
              onPressed: () {
                callback.call(output);
                Navigator.of(Get.context!).pop();
              },
            )
          ],
        ),
      ),
    );
  }

// —————————————————————————————————————————————————————————————————————————
// DATE PICKER (MATERIAL) ——————————————————————————————————————————————————
// —————————————————————————————————————————————————————————————————————————
  Future<void> datePickerMaterial({
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    required Function(DateTime) callback,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: minDate ?? DateTime(2020),
      lastDate: maxDate ?? DateTime(2050),
    );
    if (picked != null) {
      callback.call(picked);
    }
  }

  Future<void> timePickerMaterial({
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
    required Function(TimeOfDay) callback,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      callback.call(picked);
    }
  }

// onController : final dataFile = (files as List<File>)[0].path; // example single
// imagePicker(
//     Function1 files, {
//       bool isMultiple = false,
//       bool isCamera = false,
//     }) async {
//   if (isCamera) {
//     await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80).then((value) {
//       if (value != null) {
//         XFile _file = value;
//         files.call(_file);
//       }
//     });
//   } else {
//     if (Platform.isIOS) {
//       await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80).then((value) {
//         if (value != null) {
//           List<File> _file = [File(value.path)];
//           files.call(_file);
//         }
//       });
//     } else {
//       await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 6).then((value) {
//         if (value != null) {
//           List<File> _file = [File(value.path)];
//           files.call(_file);
//         }
//       });
//     }
//   }
// }
//
// // onController : final dataFile = (files as List<File>)[0].path; // example single
// documentPicker(
//     Function1 files, {
//       bool isMultiple = false,
//     }) async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     allowMultiple: isMultiple,
//     type: FileType.custom,
//     allowedExtensions: ["pdf", "doc", "xls", "ppt"],
//   );
//   if (result != null) {
//     List<File> _files = result.paths.map((path) => File(path!)).toList();
//     files.call(_files);
//   }
// }
}
