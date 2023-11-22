import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signtalk/screens/slicer.dart';
import 'package:signtalk/screens/switch_widget.dart';
import 'package:tflite/tflite.dart';

class OfflineScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const OfflineScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  bool mode = true;
  bool detecting = false;
  bool isAIGuessing = false;
  bool input = false;
  String answer = '';
  late CameraController cameraController;
  final TextEditingController controller = TextEditingController();
  List<Slicer> slicers = [];
  late final Future init;

  onSwitchTap() {
    setState(() {
      mode = !mode;
      final int key = mode ? 1 : 0;
      switcher = Switcher(key: ValueKey(key), mode: mode, onTap: onSwitchTap);
    });
    if (!mode) {
      cameraController.initialize().then(
            (_) => setState(() {}),
          );
    }
  }

  Future initResources() async {
    await Tflite.loadModel(
      model: "assets/detect.tflite",
      labels: "assets/labels.txt",
    );
  }

  late Widget switcher =
      Switcher(key: const ValueKey(1), mode: mode, onTap: onSwitchTap);

  late Widget switchWidgetMode = Center(
    child: Switcher(
      mode: mode,
      onTap: onSwitchTap,
    ),
  );

  applymodelonimages(CameraImage cameraImage) {
    Tflite.runModelOnFrame(
            bytesList: cameraImage.planes.map(
              (plane) {
                return plane.bytes;
              },
            ).toList(),
            imageHeight: cameraImage.height,
            imageWidth: cameraImage.width,
            numResults: 2)
        .then(
      (value) {
        isAIGuessing = false;
        if (value != null) {
          if (value.isNotEmpty) {
            var guess = value[0];
            debugPrint(guess.toString());
            setState(() => answer =
                '${guess['label'].toString()} - (${(guess['confidence'] as double).toStringAsFixed(2)})');
          }
        }
      },
    );
  }

  translate(String input) {
    final output = input.replaceAll(RegExp('[^A-Za-z ]'), '');
    final List<String> words = output.split(' ');
    slicers = [];
    for (final word in words) {
      if (word.isEmpty) continue;
      slicers.add(Slicer(word: word));
    }
  }

  @override
  void initState() {
    debugPrint('offline screen init has been called');
    cameraController =
        CameraController(widget.cameras![0], ResolutionPreset.high);
    init = initResources();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    debugPrint("OnDispose has been called");
    cameraController.dispose();
    await Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 2,
                  )
                ],
                border: Border(
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.arrow_back, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: SizedBox(
                            child: Image.asset(
                              'assets/images/text.png',
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      spreadRadius: 2,
                      offset: Offset(0.0, 2.5),
                    )
                  ],
                ),
                child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    firstChild: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: input
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: slicers,
                                ),
                              )
                            : Text("Enter text below to translate.",
                                style: GoogleFonts.poppins()),
                      ),
                    ),
                    secondChild: FutureBuilder(
                      future: init,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                flex: 1,
                                child: SizedBox(
                                  child: CameraPreview(cameraController),
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 25,
                                width: 25,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    setState(() => detecting = !detecting);
                                    if (detecting) {
                                      cameraController.startImageStream(
                                        (image) {
                                          if (!isAIGuessing) {
                                            isAIGuessing = true;
                                            applymodelonimages(image);
                                          }
                                        },
                                      );
                                    } else {
                                      await cameraController.stopImageStream();
                                      setState(() => answer = '');
                                      setState(() {});
                                    }
                                  },
                                  icon: Icon(
                                    detecting
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    size: 25,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  CircularProgressIndicator(strokeWidth: 1.0),
                            ),
                          );
                        }
                      },
                    ),
                    crossFadeState: mode
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond),
              ),
            ),
            Expanded(
              flex: mode ? 2 : 1,
              child: Stack(
                children: [
                  Center(
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: switcher),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 0,
                    right: 0,
                    child: AnimatedCrossFade(
                      firstChild: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8))),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    border: InputBorder.none,
                                    hintText: '...'),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                translate(controller.text);
                                setState(() {
                                  input = true;
                                });
                              },
                              splashRadius: 0.1,
                              icon: const Icon(Icons.check_rounded, size: 18),
                              padding: EdgeInsets.zero,
                            )
                          ],
                        ),
                      ),
                      secondChild: Container(
                        height: mode ? 60 : 80,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8))),
                        child: Center(
                          child: Text(answer == ''
                              ? 'Translation appears here..'
                              : answer),
                        ),
                      ),
                      crossFadeState: mode
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
