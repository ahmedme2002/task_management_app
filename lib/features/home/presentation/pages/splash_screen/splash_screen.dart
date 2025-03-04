import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_management_app/features/home/presentation/pages/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _textFadeController;
  late Animation<double> _textFadeAnimation;
  late Timer _textTimer;

  int taglineIndex = 0;

  final List<String> taglines = [
    "Plan. Track. Achieve.",
    "Organize your day.",
    "Stay on top of tasks.",
    "Boost your productivity."
  ];

  @override
  void initState() {
    super.initState();

    _textFadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _textFadeAnimation = CurvedAnimation(
      parent: _textFadeController,
      curve: Curves.easeInOut,
    );

    _textFadeController.forward();

    _textTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) return;
      setState(() {
        taglineIndex = (taglineIndex + 1) % taglines.length;
      });
    });

    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _textFadeController.dispose();
    _textTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundGradient(),
          Column(
            children: [
              _buildTopSection(size),
              _buildBottomSection(size),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection(Size size) {
    return Expanded(
      flex: 5,
      child: Stack(
        children: [
          _buildDiagonalBackground(),
          Center(child: _buildGlassMorphicLogo()),
        ],
      ),
    );
  }

  Widget _buildBottomSection(Size size) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Task Manager",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          FadeTransition(
            opacity: _textFadeAnimation,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: Text(
                taglines[taglineIndex],
                key: ValueKey(taglines[taglineIndex]),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildGlowingProgressBar(size),
        ],
      ),
    );
  }

  Widget _buildBackgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.purple.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildDiagonalBackground() {
    return ClipPath(
      clipper: DiagonalClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildGlassMorphicLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
        border: Border.all(color: Colors.white30, width: 2),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/th.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildGlowingProgressBar(Size size) {
    return Container(
      width: size.width * 0.8,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white30,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(seconds: 5),
          curve: Curves.easeInOut,
          width: size.width * 0.8,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.white],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlueAccent.withOpacity(0.5),
                blurRadius: 8,
                spreadRadius: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.lineTo(size.width, size.height - 120);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
