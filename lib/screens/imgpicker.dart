// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// // ignore_for_file: public_member_api_docs
//
// import 'dart:async';
// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
//
// class CameraExampleHome extends StatefulWidget {
//   @override
//   _CameraExampleHomeState createState() {
//     return _CameraExampleHomeState();
//   }
// }
//
// /// Returns a suitable camera icon for [direction].
// IconData getCameraLensIcon(CameraLensDirection direction) {
//   switch (direction) {
//     case CameraLensDirection.back:
//       return Icons.camera_rear;
//     case CameraLensDirection.front:
//       return Icons.camera_front;
//     case CameraLensDirection.external:
//       return Icons.camera;
//     default:
//       throw ArgumentError('Unknown lens direction');
//   }
// }
//
// void logError(String code, String? message) {
//   if (message != null) {
//     print('Error: $code\nError Message: $message');
//   } else {
//     print('Error: $code');
//   }
// }
//
// class _CameraExampleHomeState extends State<CameraExampleHome>
//     with WidgetsBindingObserver, TickerProviderStateMixin {
//   CameraController? controller;
//   XFile? imageFile;
//   XFile? videoFile;
//   // VideoPlayerController? videoController;
//   VoidCallback? videoPlayerListener;
//   bool enableAudio = true;
//   double _minAvailableExposureOffset = 0.0;
//   double _maxAvailableExposureOffset = 0.0;
//   double _currentExposureOffset = 0.0;
//   late AnimationController _flashModeControlRowAnimationController;
//   late Animation<double> _flashModeControlRowAnimation;
//   late AnimationController _exposureModeControlRowAnimationController;
//   late Animation<double> _exposureModeControlRowAnimation;
//   late AnimationController _focusModeControlRowAnimationController;
//   late Animation<double> _focusModeControlRowAnimation;
//   double _minAvailableZoom = 1.0;
//   double _maxAvailableZoom = 1.0;
//   double _currentScale = 1.0;
//   double _baseScale = 1.0;
//
//   // Counting pointers (number of user fingers on screen)
//   int _pointers = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _ambiguate(WidgetsBinding.instance)?.addObserver(this);
//
//     _flashModeControlRowAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _flashModeControlRowAnimation = CurvedAnimation(
//       parent: _flashModeControlRowAnimationController,
//       curve: Curves.easeInCubic,
//     );
//     _exposureModeControlRowAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _exposureModeControlRowAnimation = CurvedAnimation(
//       parent: _exposureModeControlRowAnimationController,
//       curve: Curves.easeInCubic,
//     );
//     _focusModeControlRowAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _focusModeControlRowAnimation = CurvedAnimation(
//       parent: _focusModeControlRowAnimationController,
//       curve: Curves.easeInCubic,
//     );
//   }
//
//   @override
//   void dispose() {
//     _ambiguate(WidgetsBinding.instance)?.removeObserver(this);
//     _flashModeControlRowAnimationController.dispose();
//     _exposureModeControlRowAnimationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final CameraController? cameraController = controller;
//
//     // App state changed before we got the chance to initialize.
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return;
//     }
//
//     if (state == AppLifecycleState.inactive) {
//       cameraController.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       onNewCameraSelected(cameraController.description);
//     }
//   }
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: const Text('Camera example'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: Center(
//                   child: _cameraPreviewWidget(),
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 border: Border.all(
//                   color:
//                   controller != null && controller!.value.isRecordingVideo
//                       ? Colors.redAccent
//                       : Colors.grey,
//                   width: 3.0,
//                 ),
//               ),
//             ),
//           ),
//           _captureControlRowWidget(),
//           _modeControlRowWidget(),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 _cameraTogglesRowWidget(),
//                 _thumbnailWidget(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Display the preview from the camera (or a message if the preview is not available).
//   Widget _cameraPreviewWidget() {
//     final CameraController? cameraController = controller;
//
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return const Text(
//         'Tap a camera',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 24.0,
//           fontWeight: FontWeight.w900,
//         ),
//       );
//     } else {
//       return Listener(
//         onPointerDown: (_) => _pointers++,
//         onPointerUp: (_) => _pointers--,
//         child: CameraPreview(
//           controller!,
//           child: LayoutBuilder(
//               builder: (BuildContext context, BoxConstraints constraints) {
//                 return GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onScaleStart: _handleScaleStart,
//                   onScaleUpdate: _handleScaleUpdate,
//                   onTapDown: (details) => onViewFinderTap(details, constraints),
//                 );
//               }),
//         ),
//       );
//     }
//   }
//
//   void _handleScaleStart(ScaleStartDetails details) {
//     _baseScale = _currentScale;
//   }
//
//   Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
//     // When there are not exactly two fingers on screen don't scale
//     if (controller == null || _pointers != 2) {
//       return;
//     }
//
//     _currentScale = (_baseScale * details.scale)
//         .clamp(_minAvailableZoom, _maxAvailableZoom);
//
//     await controller!.setZoomLevel(_currentScale);
//   }
//
//   /// Display the thumbnail of the captured image or video.
//   Widget _thumbnailWidget() {
//     // final VideoPlayerController? localVideoController = videoController;
//
//     return Expanded(
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//              imageFile == null
//                 ? Container()
//                 : SizedBox(
//               child: Image.file(File(imageFile!.path)),
//
//               width: 64.0,
//               height: 64.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Display a bar with buttons to change the flash and exposure modes
//   Widget _modeControlRowWidget() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.flash_on),
//               color: Colors.blue,
//               onPressed: controller != null ? onFlashModeButtonPressed : null,
//             ),
//             IconButton(
//               icon: Icon(Icons.exposure),
//               color: Colors.blue,
//               onPressed:
//               controller != null ? onExposureModeButtonPressed : null,
//             ),
//             IconButton(
//               icon: Icon(Icons.filter_center_focus),
//               color: Colors.blue,
//               onPressed: controller != null ? onFocusModeButtonPressed : null,
//             ),
//             IconButton(
//               icon: Icon(enableAudio ? Icons.volume_up : Icons.volume_mute),
//               color: Colors.blue,
//               onPressed: controller != null ? onAudioModeButtonPressed : null,
//             ),
//             IconButton(
//               icon: Icon(controller?.value.isCaptureOrientationLocked ?? false
//                   ? Icons.screen_lock_rotation
//                   : Icons.screen_rotation),
//               color: Colors.blue,
//               onPressed: controller != null
//                   ? onCaptureOrientationLockButtonPressed
//                   : null,
//             ),
//           ],
//         ),
//         _flashModeControlRowWidget(),
//         _exposureModeControlRowWidget(),
//         _focusModeControlRowWidget(),
//       ],
//     );
//   }
//
//   Widget _flashModeControlRowWidget() {
//     return SizeTransition(
//       sizeFactor: _flashModeControlRowAnimation,
//       child: ClipRect(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             IconButton(
//               icon: Icon(Icons.flash_off),
//               color: controller?.value.flashMode == FlashMode.off
//                   ? Colors.orange
//                   : Colors.blue,
//               onPressed: controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.off)
//                   : null,
//             ),
//             IconButton(
//               icon: Icon(Icons.flash_auto),
//               color: controller?.value.flashMode == FlashMode.auto
//                   ? Colors.orange
//                   : Colors.blue,
//               onPressed: controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.auto)
//                   : null,
//             ),
//             IconButton(
//               icon: Icon(Icons.flash_on),
//               color: controller?.value.flashMode == FlashMode.always
//                   ? Colors.orange
//                   : Colors.blue,
//               onPressed: controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.always)
//                   : null,
//             ),
//             IconButton(
//               icon: Icon(Icons.highlight),
//               color: controller?.value.flashMode == FlashMode.torch
//                   ? Colors.orange
//                   : Colors.blue,
//               onPressed: controller != null
//                   ? () => onSetFlashModeButtonPressed(FlashMode.torch)
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _exposureModeControlRowWidget() {
//     final ButtonStyle styleAuto = TextButton.styleFrom(
//       primary: controller?.value.exposureMode == ExposureMode.auto
//           ? Colors.orange
//           : Colors.blue,
//     );
//     final ButtonStyle styleLocked = TextButton.styleFrom(
//       primary: controller?.value.exposureMode == ExposureMode.locked
//           ? Colors.orange
//           : Colors.blue,
//     );
//
//     return SizeTransition(
//       sizeFactor: _exposureModeControlRowAnimation,
//       child: ClipRect(
//         child: Container(
//           color: Colors.grey.shade50,
//           child: Column(
//             children: [
//               Center(
//                 child: Text("Exposure Mode"),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   TextButton(
//                     child: Text('AUTO'),
//                     style: styleAuto,
//                     onPressed: controller != null
//                         ? () =>
//                         onSetExposureModeButtonPressed(ExposureMode.auto)
//                         : null,
//                     onLongPress: () {
//                       if (controller != null) {
//                         controller!.setExposurePoint(null);
//                         showInSnackBar('Resetting exposure point');
//                       }
//                     },
//                   ),
//                   TextButton(
//                     child: Text('LOCKED'),
//                     style: styleLocked,
//                     onPressed: controller != null
//                         ? () =>
//                         onSetExposureModeButtonPressed(ExposureMode.locked)
//                         : null,
//                   ),
//                 ],
//               ),
//               Center(
//                 child: Text("Exposure Offset"),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Text(_minAvailableExposureOffset.toString()),
//                   Slider(
//                     value: _currentExposureOffset,
//                     min: _minAvailableExposureOffset,
//                     max: _maxAvailableExposureOffset,
//                     label: _currentExposureOffset.toString(),
//                     onChanged: _minAvailableExposureOffset ==
//                         _maxAvailableExposureOffset
//                         ? null
//                         : setExposureOffset,
//                   ),
//                   Text(_maxAvailableExposureOffset.toString()),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _focusModeControlRowWidget() {
//     final ButtonStyle styleAuto = TextButton.styleFrom(
//       primary: controller?.value.focusMode == FocusMode.auto
//           ? Colors.orange
//           : Colors.blue,
//     );
//     final ButtonStyle styleLocked = TextButton.styleFrom(
//       primary: controller?.value.focusMode == FocusMode.locked
//           ? Colors.orange
//           : Colors.blue,
//     );
//
//     return SizeTransition(
//       sizeFactor: _focusModeControlRowAnimation,
//       child: ClipRect(
//         child: Container(
//           color: Colors.grey.shade50,
//           child: Column(
//             children: [
//               Center(
//                 child: Text("Focus Mode"),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   TextButton(
//                     child: Text('AUTO'),
//                     style: styleAuto,
//                     onPressed: controller != null
//                         ? () => onSetFocusModeButtonPressed(FocusMode.auto)
//                         : null,
//                     onLongPress: () {
//                       if (controller != null) controller!.setFocusPoint(null);
//                       showInSnackBar('Resetting focus point');
//                     },
//                   ),
//                   TextButton(
//                     child: Text('LOCKED'),
//                     style: styleLocked,
//                     onPressed: controller != null
//                         ? () => onSetFocusModeButtonPressed(FocusMode.locked)
//                         : null,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// Display the control bar with buttons to take pictures and record videos.
//   Widget _captureControlRowWidget() {
//     final CameraController? cameraController = controller;
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       mainAxisSize: MainAxisSize.max,
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.camera_alt),
//           color: Colors.blue,
//           onPressed: cameraController != null &&
//               cameraController.value.isInitialized &&
//               !cameraController.value.isRecordingVideo
//               ? onTakePictureButtonPressed
//               : null,
//         ),
//         IconButton(
//           icon: const Icon(Icons.videocam),
//           color: Colors.blue,
//           onPressed: cameraController != null &&
//               cameraController.value.isInitialized &&
//               !cameraController.value.isRecordingVideo
//               ? onVideoRecordButtonPressed
//               : null,
//         ),
//         IconButton(
//           icon: cameraController != null &&
//               cameraController.value.isRecordingPaused
//               ? Icon(Icons.play_arrow)
//               : Icon(Icons.pause),
//           color: Colors.blue,
//           onPressed: cameraController != null &&
//               cameraController.value.isInitialized &&
//               cameraController.value.isRecordingVideo
//               ? (cameraController.value.isRecordingPaused)
//               ? onResumeButtonPressed
//               : onPauseButtonPressed
//               : null,
//         ),
//         IconButton(
//           icon: const Icon(Icons.stop),
//           color: Colors.red,
//           onPressed: cameraController != null &&
//               cameraController.value.isInitialized &&
//               cameraController.value.isRecordingVideo
//               ? onStopButtonPressed
//               : null,
//         )
//       ],
//     );
//   }
//
//   /// Display a row of toggle to select the camera (or a message if no camera is available).
//   Widget _cameraTogglesRowWidget() {
//     final List<Widget> toggles = <Widget>[];
//
//     final onChanged = (CameraDescription? description) {
//       if (description == null) {
//         return;
//       }
//
//       onNewCameraSelected(description);
//     };
//
//     if (cameras.isEmpty) {
//       return const Text('No camera found');
//     } else {
//       for (CameraDescription cameraDescription in cameras) {
//         toggles.add(
//           SizedBox(
//             width: 90.0,
//             child: RadioListTile<CameraDescription>(
//               title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
//               groupValue: controller?.description,
//               value: cameraDescription,
//               onChanged:
//               controller != null && controller!.value.isRecordingVideo
//                   ? null
//                   : onChanged,
//             ),
//           ),
//         );
//       }
//     }
//
//     return Row(children: toggles);
//   }
//
//   String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
//
//   void showInSnackBar(String message) {
//     // ignore: deprecated_member_use
//     _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
//     if (controller == null) {
//       return;
//     }
//
//     final CameraController cameraController = controller!;
//
//     final offset = Offset(
//       details.localPosition.dx / constraints.maxWidth,
//       details.localPosition.dy / constraints.maxHeight,
//     );
//     cameraController.setExposurePoint(offset);
//     cameraController.setFocusPoint(offset);
//   }
//
//   void onNewCameraSelected(CameraDescription cameraDescription) async {
//     if (controller != null) {
//       await controller!.dispose();
//     }
//     final CameraController cameraController = CameraController(
//       cameraDescription,
//       ResolutionPreset.medium,
//       enableAudio: enableAudio,
//       imageFormatGroup: ImageFormatGroup.jpeg,
//     );
//     controller = cameraController;
//
//     // If the controller is updated then update the UI.
//     cameraController.addListener(() {
//       if (mounted) setState(() {});
//       if (cameraController.value.hasError) {
//         showInSnackBar(
//             'Camera error ${cameraController.value.errorDescription}');
//       }
//     });
//
//     try {
//       await cameraController.initialize();
//       await Future.wait([
//         cameraController
//             .getMinExposureOffset()
//             .then((value) => _minAvailableExposureOffset = value),
//         cameraController
//             .getMaxExposureOffset()
//             .then((value) => _maxAvailableExposureOffset = value),
//         cameraController
//             .getMaxZoomLevel()
//             .then((value) => _maxAvailableZoom = value),
//         cameraController
//             .getMinZoomLevel()
//             .then((value) => _minAvailableZoom = value),
//       ]);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//     }
//
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   void onTakePictureButtonPressed() {
//     takePicture().then((XFile? file) {
//       if (mounted) {
//         setState(() {
//           imageFile = file;
//           // videoController?.dispose();
//           // videoController = null;
//         });
//         if (file != null) showInSnackBar('Picture saved to ${file.path}');
//       }
//     });
//   }
//
//   void onFlashModeButtonPressed() {
//     if (_flashModeControlRowAnimationController.value == 1) {
//       _flashModeControlRowAnimationController.reverse();
//     } else {
//       _flashModeControlRowAnimationController.forward();
//       _exposureModeControlRowAnimationController.reverse();
//       _focusModeControlRowAnimationController.reverse();
//     }
//   }
//
//   void onExposureModeButtonPressed() {
//     if (_exposureModeControlRowAnimationController.value == 1) {
//       _exposureModeControlRowAnimationController.reverse();
//     } else {
//       _exposureModeControlRowAnimationController.forward();
//       _flashModeControlRowAnimationController.reverse();
//       _focusModeControlRowAnimationController.reverse();
//     }
//   }
//
//   void onFocusModeButtonPressed() {
//     if (_focusModeControlRowAnimationController.value == 1) {
//       _focusModeControlRowAnimationController.reverse();
//     } else {
//       _focusModeControlRowAnimationController.forward();
//       _flashModeControlRowAnimationController.reverse();
//       _exposureModeControlRowAnimationController.reverse();
//     }
//   }
//
//   void onAudioModeButtonPressed() {
//     enableAudio = !enableAudio;
//     if (controller != null) {
//       onNewCameraSelected(controller!.description);
//     }
//   }
//
//   void onCaptureOrientationLockButtonPressed() async {
//     if (controller != null) {
//       final CameraController cameraController = controller!;
//       if (cameraController.value.isCaptureOrientationLocked) {
//         await cameraController.unlockCaptureOrientation();
//         showInSnackBar('Capture orientation unlocked');
//       } else {
//         await cameraController.lockCaptureOrientation();
//         showInSnackBar(
//             'Capture orientation locked to ${cameraController.value.lockedCaptureOrientation.toString().split('.').last}');
//       }
//     }
//   }
//
//   void onSetFlashModeButtonPressed(FlashMode mode) {
//     setFlashMode(mode).then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Flash mode set to ${mode.toString().split('.').last}');
//     });
//   }
//
//   void onSetExposureModeButtonPressed(ExposureMode mode) {
//     setExposureMode(mode).then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Exposure mode set to ${mode.toString().split('.').last}');
//     });
//   }
//
//   void onSetFocusModeButtonPressed(FocusMode mode) {
//     setFocusMode(mode).then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Focus mode set to ${mode.toString().split('.').last}');
//     });
//   }
//
//   void onVideoRecordButtonPressed() {
//     startVideoRecording().then((_) {
//       if (mounted) setState(() {});
//     });
//   }
//
//   void onStopButtonPressed() {
//     stopVideoRecording().then((file) {
//       if (mounted) setState(() {});
//       if (file != null) {
//         showInSnackBar('Video recorded to ${file.path}');
//         videoFile = file;
//         // _startVideoPlayer();
//       }
//     });
//   }
//
//   void onPauseButtonPressed() {
//     pauseVideoRecording().then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Video recording paused');
//     });
//   }
//
//   void onResumeButtonPressed() {
//     resumeVideoRecording().then((_) {
//       if (mounted) setState(() {});
//       showInSnackBar('Video recording resumed');
//     });
//   }
//
//   Future<void> startVideoRecording() async {
//     final CameraController? cameraController = controller;
//
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       showInSnackBar('Error: select a camera first.');
//       return;
//     }
//
//     if (cameraController.value.isRecordingVideo) {
//       // A recording is already started, do nothing.
//       return;
//     }
//
//     try {
//       await cameraController.startVideoRecording();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return;
//     }
//   }
//
//   Future<XFile?> stopVideoRecording() async {
//     final CameraController? cameraController = controller;
//
//     if (cameraController == null || !cameraController.value.isRecordingVideo) {
//       return null;
//     }
//
//     try {
//       return cameraController.stopVideoRecording();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//   }
//
//   Future<void> pauseVideoRecording() async {
//     final CameraController? cameraController = controller;
//
//     if (cameraController == null || !cameraController.value.isRecordingVideo) {
//       return null;
//     }
//
//     try {
//       await cameraController.pauseVideoRecording();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }
//
//   Future<void> resumeVideoRecording() async {
//     final CameraController? cameraController = controller;
//
//     if (cameraController == null || !cameraController.value.isRecordingVideo) {
//       return null;
//     }
//
//     try {
//       await cameraController.resumeVideoRecording();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }
//
//   Future<void> setFlashMode(FlashMode mode) async {
//     if (controller == null) {
//       return;
//     }
//
//     try {
//       await controller!.setFlashMode(mode);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }
//
//   Future<void> setExposureMode(ExposureMode mode) async {
//     if (controller == null) {
//       return;
//     }
//
//     try {
//       await controller!.setExposureMode(mode);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }
//
//   Future<void> setExposureOffset(double offset) async {
//     if (controller == null) {
//       return;
//     }
//
//     setState(() {
//       _currentExposureOffset = offset;
//     });
//     try {
//       offset = await controller!.setExposureOffset(offset);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }
//
//   Future<void> setFocusMode(FocusMode mode) async {
//     if (controller == null) {
//       return;
//     }
//
//     try {
//       await controller!.setFocusMode(mode);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       rethrow;
//     }
//   }
//
//   // Future<void> _startVideoPlayer() async {
//   //   if (videoFile == null) {
//   //     return;
//   //   }
//   //
//   //   final VideoPlayerController vController =
//   //   VideoPlayerController.file(File(videoFile!.path));
//   //   videoPlayerListener = () {
//   //     if (videoController != null && videoController!.value.size != null) {
//   //       // Refreshing the state to update video player with the correct ratio.
//   //       if (mounted) setState(() {});
//   //       videoController!.removeListener(videoPlayerListener!);
//   //     }
//   //   };
//   //   vController.addListener(videoPlayerListener!);
//   //   await vController.setLooping(true);
//   //   await vController.initialize();
//   //   await videoController?.dispose();
//   //   if (mounted) {
//   //     setState(() {
//   //       imageFile = null;
//   //       videoController = vController;
//   //     });
//   //   }
//   //   await vController.play();
//   // }
//
//   Future<XFile?> takePicture() async {
//     final CameraController? cameraController = controller;
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       showInSnackBar('Error: select a camera first.');
//       return null;
//     }
//
//     if (cameraController.value.isTakingPicture) {
//       // A capture is already pending, do nothing.
//       return null;
//     }
//
//     try {
//       XFile file = await cameraController.takePicture();
//       return file;
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//   }
//
//   void _showCameraException(CameraException e) {
//     logError(e.code, e.description);
//     showInSnackBar('Error: ${e.code}\n${e.description}');
//   }
// }
//
// class CameraApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CameraExampleHome(),
//     );
//   }
// }
//
// List<CameraDescription> cameras = [];
//
// Future<void> main() async {
//   // Fetch the available cameras before initializing the app.
//   try {
//     WidgetsFlutterBinding.ensureInitialized();
//     cameras = await availableCameras();
//   } on CameraException catch (e) {
//     logError(e.code, e.description);
//   }
//   runApp(CameraApp());
// }
//
// /// This allows a value of type T or T? to be treated as a value of type T?.
// ///
// /// We use this so that APIs that have become non-nullable can still be used
// /// with `!` and `?` on the stable branch.
// // TODO(ianh): Remove this once we roll stable in late 2021.
// T? _ambiguate<T>(T? value) => value;

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CameraTest extends StatefulWidget {
  @override
  _CameraTestState createState() => _CameraTestState();
}

class _CameraTestState extends State<CameraTest> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      final double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      final XFile? file = await _picker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      // await

      // _displayPickImageDialog(context!,
      //         (double? maxWidth, double? maxHeight, int? quality) async {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
          // maxWidth: maxWidth,
          // maxHeight: maxHeight,
          // imageQuality: quality,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
      // });
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Widget _previewVideo() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: ListView.builder(
            key: UniqueKey(),
            itemBuilder: (context, index) {
              // Why network for web?
              // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
              return Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_imageFileList![index].path)
                    : Image.file(File(_imageFileList![index].path)),
              );
            },
            itemCount: _imageFileList!.length,
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    if (isVideo) {
      return _previewVideo();
    } else {
      return _previewImages();
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          _imageFile = response.file;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  String img = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                _imageFileList!.clear();
              });
              // Navigator.pop(context, _imageFileList![0].path);
            },
            child: Text('Cancel'),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context, _imageFileList![0].path);
            },
            child: Text('Done'),
          )
        ],
      ),
      body: Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text(
                        'You have not yet picked an image.',
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return _handlePreview();
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image/video error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'You have not yet picked an image.',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              )
            : _handlePreview(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'image0',
              tooltip: 'Pick Image from gallery',
              child: const Icon(Icons.photo),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0),
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       isVideo = false;
          //       _onImageButtonPressed(
          //         ImageSource.gallery,
          //         context: context,
          //         isMultiImage: true,
          //       );
          //     },
          //     heroTag: 'image1',
          //     tooltip: 'Pick Multiple Image from gallery',
          //     child: const Icon(Icons.photo_library),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                isVideo = false;
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0),
          //   child: FloatingActionButton(
          //     backgroundColor: Colors.red,
          //     onPressed: () {
          //       isVideo = true;
          //       _onImageButtonPressed(ImageSource.gallery);
          //     },
          //     heroTag: 'video0',
          //     tooltip: 'Pick Video from gallery',
          //     child: const Icon(Icons.video_library),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0),
          //   child: FloatingActionButton(
          //     backgroundColor: Colors.red,
          //     onPressed: () {
          //       isVideo = true;
          //       _onImageButtonPressed(ImageSource.camera);
          //     },
          //     heroTag: 'video1',
          //     tooltip: 'Take a Video',
          //     child: const Icon(Icons.videocam),
          //   ),
          // ),
        ],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      InputDecoration(hintText: "Enter maxWidth if desired"),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration:
                      InputDecoration(hintText: "Enter maxHeight if desired"),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(hintText: "Enter quality if desired"),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  AspectRatioVideo(this.controller);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}
