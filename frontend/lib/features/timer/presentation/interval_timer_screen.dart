import 'package:flutter/material.dart';
import 'dart:math';
import '../../../core/theme/app_colors.dart';

class IntervalTimerScreen extends StatefulWidget {
  const IntervalTimerScreen({super.key});

  @override
  State<IntervalTimerScreen> createState() => _IntervalTimerScreenState();
}

class _IntervalTimerScreenState extends State<IntervalTimerScreen> {
  bool _isPlaying = true;
  double _progress = 0.75; // Mock progress (e.g., 45s out of 60s)

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interval Timer'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Massive Circular Timer
                    SizedBox(
                      width: 280,
                      height: 280,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CustomPaint(
                            painter: _TimerPainter(progress: _progress),
                          ),
                          Center(
                            child: Text(
                              '00:45',
                              style: theme.textTheme.displayLarge?.copyWith(
                                color: AppColors.textPrimary,
                                fontSize: 72,
                                fontWeight: FontWeight.w300,
                                fontFeatures: const [FontFeature.tabularFigures()],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Next Up Indicator
                    Text(
                      'Next: Rest (15s)',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Controls
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: Icons.replay,
                    onPressed: () {},
                    isPrimary: false,
                  ),
                  _buildControlButton(
                    icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                    onPressed: () {
                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                    },
                    isPrimary: true,
                    size: 80,
                  ),
                  _buildControlButton(
                    icon: Icons.skip_next,
                    onPressed: () {},
                    isPrimary: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isPrimary,
    double size = 64,
  }) {
    return InkWell(
      onTap: onPressed,
      customBorder: const CircleBorder(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPrimary ? AppColors.neonGreen : AppColors.surface,
        ),
        child: Icon(
          icon,
          size: size * 0.45,
          color: isPrimary ? AppColors.background : AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _TimerPainter extends CustomPainter {
  final double progress;

  _TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 8;

    // Background track
    final bgPaint = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    canvas.drawCircle(center, radius, bgPaint);

    // Active progress
    final activePaint = Paint()
      ..color = AppColors.neonGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
