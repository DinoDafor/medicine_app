import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math.dart' as mathVector;



// Enums used to control camera
//------------------------------------------------------------------------------
enum CameraControlZoomLevel {
  x1, x2
}

enum CameraControlRecordingMode {
  photo, video
}

enum CameraControlCameraType {
  back, front
}
//------------------------------------------------------------------------------



// Shared buttons
//------------------------------------------------------------------------------
class _DesignButtonRecordingModePhoto extends StatelessWidget {
  final Color cameraButtonIcon = Colors.white;
  final Color cameraButtonIconBackground = const Color.fromARGB(130, 60, 60, 60);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 51, height: 51,
        decoration: ShapeDecoration(color: this.cameraButtonIconBackground, shape: CircleBorder()),
        child: Icon(Icons.photo_camera_rounded, color: this.cameraButtonIcon, size: 32)
    );
  }
}

class _DesignButtonRecordingModeVideo extends StatelessWidget {
  final Color cameraButtonIcon = Colors.white;
  final Color cameraButtonIconBackground = const Color.fromARGB(130, 60, 60, 60);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 51, height: 51,
        decoration: ShapeDecoration(color: this.cameraButtonIconBackground, shape: CircleBorder()),
        child: Icon(Icons.videocam_rounded, color: this.cameraButtonIcon, size: 32)
    );
  }
}

class _DesignButtonCameraTypeFront extends StatelessWidget {
  final Color cameraButtonIcon = Colors.white;
  final Color cameraButtonIconBackground = const Color.fromARGB(130, 60, 60, 60);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 51, height: 51,
        decoration: ShapeDecoration(color: this.cameraButtonIconBackground, shape: CircleBorder()),
        child: Transform.rotate(angle: mathVector.radians(45), child: Icon(Icons.flip_camera_android_outlined, color: this.cameraButtonIcon, size: 32))
    );
  }
}

class _DesignButtonCameraTypeBack extends StatelessWidget {
  final Color cameraButtonIcon = Colors.white;
  final Color cameraButtonIconBackground = const Color.fromARGB(130, 60, 60, 60);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 51, height: 51,
        decoration: ShapeDecoration(color: this.cameraButtonIconBackground, shape: CircleBorder()),
        child: Transform.rotate(angle: 0, child: Icon(Icons.flip_camera_android_outlined, color: this.cameraButtonIcon, size: 32))
    );
  }
}

class _DesignButtonRecordPhoto extends StatelessWidget {
  final Color cameraButtonRecordBorder = Colors.white;
  final Color cameraButtonRecordPhoto = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75, height: 75,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 3.5, color: this.cameraButtonRecordBorder)),
      child: Align(
          alignment: Alignment.center,
          child: Container(
              width: 63, height: 63,
              decoration: BoxDecoration(shape: BoxShape.circle, color: this.cameraButtonRecordPhoto)
          )
      ),
    );
  }
}

class _DesignButtonRecordVideoStart extends StatelessWidget {
  final Color cameraButtonRecordBorder = Colors.white;
  final Color cameraButtonRecordVideo = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75, height: 75,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 3.5, color: this.cameraButtonRecordBorder)),
      child: Align(
        alignment: Alignment.center,
        child: Container(
            width: 63, height: 63,
            decoration: BoxDecoration(shape: BoxShape.circle, color: this.cameraButtonRecordVideo)
        ),
      ),
    );
  }
}

class _DesignButtonRecordVideoStop extends StatelessWidget {
  final Color cameraButtonRecordBorder = Colors.white;
  final Color cameraButtonRecordVideo = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75, height: 75,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 3.5, color: this.cameraButtonRecordBorder)),
      child: Align(
        alignment: Alignment.center,
        child: Container(
            width: 43, height: 43,
            decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(4)), color: this.cameraButtonRecordVideo)
        ),
      ),
    );
  }
}

class _DesignProgressIndicatorCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator())
    );
  }
}

class _DesignErrorIndicatorCamera extends StatelessWidget {
  final Color cameraButtonText = Colors.white;
  final Color cameraButtonIconBackground = const Color.fromARGB(130, 60, 60, 60);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Center(
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(12)), color: this.cameraButtonIconBackground),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, size: 50, color: Colors.red),
                  SizedBox(height: 8),
                  Text("Failed to initialize camera!", style: TextStyle(color: this.cameraButtonText, fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
            )
        )
    );
  }
}
//------------------------------------------------------------------------------



class CameraScreen extends StatefulWidget {
  @override
  State<CameraScreen> createState() {
    return _CameraScreenState();
  }
}



class _CameraScreenState extends State<CameraScreen> {
  final Color splashScreenBackground = const Color.fromARGB(255, 31, 54, 219);
  final Color splashScreenProgressBar = const Color.fromARGB(255, 255, 255, 255);
  final Color cameraButtonText = Colors.white;
  final Color cameraButtonTextSelected = const Color.fromARGB(255, 254, 213, 10);
  final Color cameraButtonRecordBorder = Colors.white;
  final Color cameraButtonRecordPhoto = Colors.white;
  final Color cameraButtonRecordVideo = Colors.red;
  final Color cameraButtonIcon = Colors.white;
  final Color cameraButtonIconBackground = const Color.fromARGB(130, 60, 60, 60);

  // Screen & camera sizes
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _cameraWidth = 0;
  double _cameraHeight = 0;
  double _cameraAspectRatio = 0;

  // Main controls
  bool _cameraControlIsInitializing = true;
  CameraControlZoomLevel _cameraControlZoomLevel = CameraControlZoomLevel.x1;
  CameraControlCameraType _cameraControlCameraType = CameraControlCameraType.back;
  CameraControlRecordingMode _cameraControlRecordingMode = CameraControlRecordingMode.photo;
  bool _cameraControlIsPreparing = false;
  bool _cameraControlIsRecording = false;
  bool _cameraControlFailedToInitialize = false;

  // Controller
  late CameraDescription _cameraDescriptionBack;
  late CameraDescription _cameraDescriptionFront;
  late CameraController _cameraController;

  _CameraScreenState();

  @override
  void dispose() {
    // Dispose of controller only if it didn't fail
    if (!_cameraControlFailedToInitialize)
      _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    try {
      await _initCamerasInner();
    } catch (error, stackTrace) {
      print('CameraScreen._initCameras(): Error! Failed to initialize cameras');
      print(stackTrace);
      setState(() {
        _cameraControlFailedToInitialize = true;
      });
    }
  }

  Future<void> _initCamerasInner() async {
    final cameras = await availableCameras();
    for (CameraDescription c in cameras) {
      print("CameraScreen._initCameras(): Has camera name=${c.name}, lensDirection=${c.lensDirection}, sensorOrientation=${c.sensorOrientation}");
    }
    _cameraDescriptionBack = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    _cameraDescriptionFront = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    await _switchCameraTo(_cameraDescriptionBack);
  }

  Future<void> _switchCameraTo(CameraDescription cameraDescription, {ResolutionPreset resolutionPreset = ResolutionPreset.veryHigh}) async {
    setState(() {
      _cameraControlIsInitializing = true;
    });
    _cameraController = CameraController(cameraDescription, resolutionPreset, enableAudio: true);
    await _cameraController.initialize();
    _cameraController.lockCaptureOrientation(DeviceOrientation.portraitUp);
    setState(() {
      _cameraControlIsInitializing = false;
    });
  }

  // Button listeners
  //----------------------------------------------------------------------------
  void _onButtonPressZoomX1() {
    // Skip if camera isn't available
    if (_cameraControlFailedToInitialize)
      return;

    _cameraController.setZoomLevel(1);
    setState(() {
      _cameraControlZoomLevel = CameraControlZoomLevel.x1;
    });
  }

  void _onButtonPressZoomX2() {
    // Skip if camera isn't available
    if (_cameraControlFailedToInitialize)
      return;

    _cameraController.setZoomLevel(2);
    setState(() {
      _cameraControlZoomLevel = CameraControlZoomLevel.x2;
    });
  }

  void _onButtonPressRecordingMode() {
    // Skip if camera isn't available
    if (_cameraControlFailedToInitialize)
      return;

    setState(() {
      // If video mode was enabled
      if (_cameraControlRecordingMode == CameraControlRecordingMode.photo) {
        _cameraControlRecordingMode = CameraControlRecordingMode.video;

        if (_cameraControlCameraType == CameraControlCameraType.front) {
          _switchCameraTo(_cameraDescriptionFront, resolutionPreset: ResolutionPreset.high);
        } else {
          _switchCameraTo(_cameraDescriptionBack, resolutionPreset: ResolutionPreset.high);
        }
      }

      // If photo mode was enabled
      else {
        _cameraControlRecordingMode = CameraControlRecordingMode.photo;

        if (_cameraControlCameraType == CameraControlCameraType.front) {
          _switchCameraTo(_cameraDescriptionFront, resolutionPreset: ResolutionPreset.veryHigh);
        } else {
          _switchCameraTo(_cameraDescriptionBack, resolutionPreset: ResolutionPreset.veryHigh);
        }
      }

      print("CameraScreen._onButtonPressRecordingMode(): Switched to recording mode ${_cameraControlRecordingMode}");
    });
  }

  void _onButtonPressCameraType() {
    // Skip if camera isn't available
    if (_cameraControlFailedToInitialize)
      return;

    setState(() {
      if (_cameraControlCameraType == CameraControlCameraType.back) {
        _cameraControlCameraType = CameraControlCameraType.front;
        _switchCameraTo(_cameraDescriptionFront);
      } else {
        _cameraControlCameraType = CameraControlCameraType.back;
        _switchCameraTo(_cameraDescriptionBack);
      }

      print("CameraScreen._onButtonPressFlip(): Switched to camera type ${_cameraControlCameraType}");
    });

    setState(() {
      _cameraControlZoomLevel = CameraControlZoomLevel.x1;
    });
  }

  Future<XFile> _afterRecordPhotoCropIfNecessary(XFile photoFile) async {
    return photoFile;
  }

  Future<XFile> _afterRecordVideoCropIfNecessary(XFile videoFile) async {
    return videoFile;
  }

  void _onButtonPressRecord() {
    // Skip if camera isn't available
    if (_cameraControlFailedToInitialize)
      return;

    // Do not do anything
    if (_cameraControlIsPreparing) {
      print("CameraScreen._onButtonPressRecord(): Skipping action as camera is preparing");
      return;
    }

    // Take a photo
    if (_cameraControlRecordingMode == CameraControlRecordingMode.photo) {
      setState(() {
        _cameraControlIsPreparing = true;
      });

      // Capture photo
      _cameraController.takePicture().then((XFile photoFile) {
        print("CameraScreen._onButtonPressRecord(): Saved photo in file name=${photoFile.name}, path=${photoFile.path}");
        _afterRecordPhotoCropIfNecessary(photoFile).then((XFile photoFile) {
          // Process the file and close the camera
          photoFile.length().then((size) {
            File file = File(photoFile.path);
            setState(() {
              _cameraControlIsPreparing = false;
            });
            Navigator.pop(context);
          });
        });
      });
    }

    // Record video
    else {
      // Stop recording
      if (_cameraControlIsRecording) {
        setState(() {
          _cameraControlIsPreparing = true;
          _cameraControlIsRecording = false;
        });

        _cameraController.stopVideoRecording().then((XFile videoFile) {
          print("CameraScreen._onButtonPressRecord(): Saved video in file name=${videoFile.name}, path=${videoFile.path}");
          _afterRecordVideoCropIfNecessary(videoFile).then((XFile videoFile) {
            // Process the file and close the camera
            videoFile.length().then((size) {
              File file = File(videoFile.path);
              setState(() {
                _cameraControlIsPreparing = false;
              });
              Navigator.pop(context);
            });
          });
        });
      }

      // Start recording
      else {
        setState(() {
          _cameraControlIsPreparing = true;
        });

        _cameraController.prepareForVideoRecording().then((value) {
          _cameraController.startVideoRecording().then((value) {
            setState(() {
              _cameraControlIsPreparing = false;
              _cameraControlIsRecording = true;
            });
          });
        });
      }
    }
  }
  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Calculate all default ratios
    final deviceSize = MediaQuery.of(context).size;
    _screenWidth = deviceSize.width;
    _screenHeight = deviceSize.height;
    _cameraAspectRatio = _cameraControlIsInitializing ? 1 : _cameraController.value.aspectRatio;
    _cameraWidth = _screenWidth;
    _cameraHeight = _cameraWidth * _cameraAspectRatio;

    return Scaffold(
        body: Container(
            child: Stack(
              children: [
                // Main camera screen
                _cameraControlIsInitializing ? Container(child: _DesignProgressIndicatorCamera()) : Container(
                  color: Colors.black,
                  width: _screenWidth,
                  height: _screenHeight,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: _cameraWidth,
                      height: _cameraHeight,
                      child: CameraPreview(_cameraController),
                    ),
                  ),
                ),

                // Main camera error
                _cameraControlFailedToInitialize ? Container(child: _DesignErrorIndicatorCamera()) : Container(),

                // Main camera loading indicator
                _cameraControlIsPreparing ? Container(width: _screenWidth, height: _screenHeight, child: Center(child: CupertinoActivityIndicator(radius: 40.0))) : Container(),

                // Camera close icon
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        child: IconButton(
                            onPressed: () {
                              print('CameraScreen._onCloseButton(): Pressed!');
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close, color: Colors.white),
                            padding: EdgeInsets.all(15),
                            iconSize: 40
                        )
                    )
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Row with aspect ratio controls
                        _cameraControlIsRecording ? Container() : Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Zoom buttons
                              TextButton(
                                  onPressed: (){_onButtonPressZoomX1();},
                                  child: Text("1x", style: TextStyle(fontSize: 18)),
                                  style: _cameraControlZoomLevel == CameraControlZoomLevel.x1 ? TextButton.styleFrom(foregroundColor: this.cameraButtonTextSelected, splashFactory: NoSplash.splashFactory) : TextButton.styleFrom(foregroundColor: this.cameraButtonText, splashFactory: NoSplash.splashFactory)
                              ),
                              TextButton(
                                  onPressed: (){_onButtonPressZoomX2();},
                                  child: Text("2x", style: TextStyle(fontSize: 18)),
                                  style: _cameraControlZoomLevel == CameraControlZoomLevel.x2 ? TextButton.styleFrom(foregroundColor: this.cameraButtonTextSelected, splashFactory: NoSplash.splashFactory) : TextButton.styleFrom(foregroundColor: this.cameraButtonText, splashFactory: NoSplash.splashFactory)
                              ),

                              Expanded(child: Container()),
                            ],
                          ),
                        ),

                        // Row with all main control
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Switch photo/video modes button
                              _cameraControlIsRecording ? Container() : InkWell(
                                  onTap: () {_onButtonPressRecordingMode();},
                                  child: _cameraControlRecordingMode == CameraControlRecordingMode.photo ? _DesignButtonRecordingModeVideo() : _DesignButtonRecordingModePhoto()
                              ),

                              // Record button
                              InkWell(
                                onTap: () {_onButtonPressRecord();},
                                child: _cameraControlRecordingMode == CameraControlRecordingMode.photo ? _DesignButtonRecordPhoto() : (_cameraControlIsRecording ? _DesignButtonRecordVideoStop() : _DesignButtonRecordVideoStart()),
                              ),

                              // Switch back/frontal modes button
                              _cameraControlIsRecording ? Container() : InkWell(
                                onTap: () {_onButtonPressCameraType();},
                                child: _cameraControlCameraType == CameraControlCameraType.back ? _DesignButtonCameraTypeBack() : _DesignButtonCameraTypeFront(),
                              ),
                            ],
                          ),
                        ),

                        // Spacer
                        SizedBox(height: 63),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
