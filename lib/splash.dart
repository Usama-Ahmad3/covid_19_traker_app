import 'dart:async';
import 'package:covid_19/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class Splash extends StatefulWidget{
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() => SplashState();
}
class SplashState extends State<Splash> with TickerProviderStateMixin{
 late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const World_states(),))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(animation: _controller,
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Image.asset('assets/images/virus.png',fit: BoxFit.fill,),
                    ),
                  ),
                  builder: (BuildContext context,Widget? child) {
                    return Transform.rotate(angle: _controller.value * 2.0 * math.pi,
                    child: child,);
                  }),
              const SizedBox(
                height: 50,
              ),
              const Align(
                  alignment: Alignment.center,
                  child: Text('Covid-19\nTracker App',textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),))
            ],
          ),
        ),
    );
  }
}