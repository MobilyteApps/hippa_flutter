import 'dart:async';
import 'dart:io';

import 'package:app/common/image_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  late ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener, this._controller);

  openCamera() async {
    imagePicker.dismissDialog();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 60);
    cropImage(File(image!.path));
  }

  openGallery() async {
    imagePicker.dismissDialog();
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 60);
    cropImage(File(image!.path));
  }

  openVideoCamera() async {
    imagePicker.dismissDialog();
    // ignore: invalid_use_of_visible_for_testing_member
    var video =
        await ImagePicker.platform.pickVideo(source: ImageSource.camera);
    _listener.userVideo(File(video!.path));
  }

  openVideoGallery() async {
    imagePicker.dismissDialog();
    // ignore: invalid_use_of_visible_for_testing_member
    var video =
        await ImagePicker.platform.pickVideo(source: ImageSource.gallery);
    _listener.userVideo(File(video!.path));
  }

  void init() {
    // imagePicker = new ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  Future cropImage(File image) async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      // cropStyle: CropStyle.rectangle,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(),
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //ratioX: 1.0,
      //ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        rectHeight: 512,
        rectWidth: 512,
      ),
    );
    _listener.userImage(croppedFile!);
  }

  showDialog(BuildContext context, {String? isVideo}) {
    imagePicker.getImage(context, isVideo: isVideo!);
  }
}

abstract class ImagePickerListener {
  userImage(File _image);

  userVideo(File _Video);
}
