import 'package:brightness_volume_manager/brightness_volume_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double brightness = 0.0;
  double volume = 0.0;
  bool screenKeptOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Screen current brightness is :"),
                Text("$brightness"),
                const Text("Screen current volume is :"),
                Text("$volume"),
                const Text("isScreen Kept On:"),
                Text("$screenKeptOn"),
                ElevatedButton(
                    onPressed: () {
                      _getCurrentBrightness();
                      _getCurrentVolume();
                      _isScreenKeptOn();
                    },
                    child: const Text("Refresh")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const BrightnessVolumeWidgets()));
                    },
                    child: const Text("Widgets")),

                ElevatedButton(
                    onPressed: () async {
                      await BrightnessVolumeManager().keepScreenOn(!screenKeptOn);
                      _isScreenKeptOn();
                    },
                    child: const Text("ToggleScreenOn")),

                ElevatedButton(
                    onPressed: () {
                      BrightnessVolumeManager().resetCustomBrightness();
                    },
                    child: const Text("Reset Custom Brightness")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getCurrentBrightness() async {
    double b = await BrightnessVolumeManager().getBrightness();
    setState(() {
      brightness = b;
    });
  }

  void _getCurrentVolume() async {
    double b = await BrightnessVolumeManager().getVolume();
    setState(() {
      volume = b;
    });
  }

  void _isScreenKeptOn() async {
    bool b = await BrightnessVolumeManager().isScreenKeptOn();
    setState(() {
      screenKeptOn = b;
    });
  }
}

class BrightnessVolumeWidgets extends StatefulWidget {
  const BrightnessVolumeWidgets({super.key});

  @override
  State<BrightnessVolumeWidgets> createState() =>
      _BrightnessVolumeWidgetsState();
}

class _BrightnessVolumeWidgetsState extends State<BrightnessVolumeWidgets> {

  double brightness = 0.0;
  double volume = 0.0;
  
  @override
  void initState() {
    _getCurrentBrightness();
    _getCurrentVolume();
    super.initState();
  }

  void _getCurrentBrightness() async {
    double b = await BrightnessVolumeManager().getBrightness();
    setState(() {
      brightness = b;
    });
  }

  void _getCurrentVolume() async {
    double b = await BrightnessVolumeManager().getVolume();
    setState(() {
      volume = b;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Text("Brightness"),
              Row(
                children: <Widget>[
                  SwipeManager(
                      initialValue: brightness,
                      width: 200,
                      height: 20,
                      onChange: (v, z) {
                        BrightnessVolumeManager().setBrightness(v);
                      },
                      direction: SlideDirection.horizontal,
                      childBuilder: (ctx, value) => AnimatedSwitcher(
                        layoutBuilder: (Widget? currentChild,
                            List<Widget> previousChildren) {
                          return currentChild!;
                        },
                        duration: const Duration(seconds: 1),
                        child: Container(),
                      )),
                  SwipeManager(
                      initialValue: brightness,
                      onChange: (v, z) {
                        BrightnessVolumeManager().setBrightness(v);
                      },
                      direction: SlideDirection.vertical,
                      childBuilder: (ctx, value) => AnimatedSwitcher(
                        layoutBuilder: (Widget? currentChild,
                            List<Widget> previousChildren) {
                          return currentChild!;
                        },
                        duration: const Duration(seconds: 1),
                        child: Container(),
                      )),
                ],
              ),
              const SizedBox(height: 16),
              const Text("Volume"),
              Row(children: <Widget>[
                SwipeManager(
                    initialValue: volume,
                    width: 200,
                    height: 20,
                    onChange: (v, z) {
                      BrightnessVolumeManager().setVolume(v);
                    },
                    direction: SlideDirection.horizontal,
                    childBuilder: (ctx, value) => AnimatedSwitcher(
                      layoutBuilder: (Widget? currentChild,
                          List<Widget> previousChildren) {
                        return currentChild!;
                      },
                      duration: const Duration(seconds: 1),
                      child: Container(),
                    )),
                SwipeManager(
                    initialValue: volume,
                    onChange: (v, z) {
                      BrightnessVolumeManager().setVolume(v);
                    },
                    direction: SlideDirection.vertical,
                    childBuilder: (ctx, value) => AnimatedSwitcher(
                      layoutBuilder: (Widget? currentChild,
                          List<Widget> previousChildren) {
                        return currentChild!;
                      },
                      duration: const Duration(seconds: 1),
                      child: Container(),
                    )),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
