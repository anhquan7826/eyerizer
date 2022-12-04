import 'package:camera/camera.dart';
import 'package:eyerizer/controller/colorblind_simulator/colorblind_simulator.controller.dart';
import 'package:eyerizer/controller/colorblind_simulator/colorblind_simulator.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorblindSimulator extends StatefulWidget {
  const ColorblindSimulator({Key? key}) : super(key: key);

  @override
  State<ColorblindSimulator> createState() => _ColorblindSimulatorState();
}

class _ColorblindSimulatorState extends State<ColorblindSimulator> {
  final ColorblindSimulatorController controller = ColorblindSimulatorController();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colorblind Simulator'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BlocConsumer(
        bloc: controller,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ColorblindSimulatorCameraInitiatingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ColorblindSimulatorCameraErrorState) {
            return const Center(
              child: Text('Cannot initiate camera!'),
            );
          } else {
            return ColorFiltered(
              colorFilter: ColorFilter.matrix(controller.filterMatrix),
              child: CameraPreview(
                controller.cameraController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    radioButton(type: FilterType.normal, title: 'Normal'),
                    radioButton(type: FilterType.tritanopia, title: 'Tritanopia'),
                    radioButton(type: FilterType.deuteranopia, title: 'Deuteranopia'),
                    radioButton(type: FilterType.protanopia, title: 'Protanopia'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget radioButton({required FilterType type, required String title}) {
    return Row(
      children: [
        Radio(
          value: type,
          groupValue: controller.filterType,
          onChanged: (t) {
            setState(() {
              controller.filterType = type;
            });
          },
        ),
        Text(title),
      ],
    );
  }
}
