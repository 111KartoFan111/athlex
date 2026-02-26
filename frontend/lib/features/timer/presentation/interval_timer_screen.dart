import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum IntervalPhase { work, rest }

class _IntervalPhaseConfig {
  final String label;
  final int durationSeconds;
  final IntervalPhase phase;
  const _IntervalPhaseConfig(this.label, this.durationSeconds, this.phase);
}

class IntervalTimerScreen extends StatefulWidget {
  const IntervalTimerScreen({super.key});

  @override
  State<IntervalTimerScreen> createState() => _IntervalTimerScreenState();
}

class _IntervalTimerScreenState extends State<IntervalTimerScreen> {
  // Default config: 5 rounds of 40s work / 20s rest
  final List<_IntervalPhaseConfig> _phases = [
    const _IntervalPhaseConfig('Work', 40, IntervalPhase.work),
    const _IntervalPhaseConfig('Rest', 20, IntervalPhase.rest),
    const _IntervalPhaseConfig('Work', 40, IntervalPhase.work),
    const _IntervalPhaseConfig('Rest', 20, IntervalPhase.rest),
    const _IntervalPhaseConfig('Work', 40, IntervalPhase.work),
    const _IntervalPhaseConfig('Rest', 20, IntervalPhase.rest),
    const _IntervalPhaseConfig('Work', 40, IntervalPhase.work),
    const _IntervalPhaseConfig('Rest', 20, IntervalPhase.rest),
    const _IntervalPhaseConfig('Work', 40, IntervalPhase.work),
    const _IntervalPhaseConfig('Rest', 20, IntervalPhase.rest),
  ];

  int _currentPhaseIndex = 0;
  late int _secondsRemaining;
  bool _isPlaying = false;
  bool _isFinished = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = _phases[_currentPhaseIndex].durationSeconds;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _advancePhase();
        }
      });
    });
  }

  void _advancePhase() {
    if (_currentPhaseIndex < _phases.length - 1) {
      _currentPhaseIndex++;
      _secondsRemaining = _phases[_currentPhaseIndex].durationSeconds;
    } else {
      // Timer finished all rounds
      _timer?.cancel();
      _isPlaying = false;
      _isFinished = true;
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _timer?.cancel();
        _isPlaying = false;
      } else {
        if (_isFinished) return;
        _isPlaying = true;
        _startTimer();
      }
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _currentPhaseIndex = 0;
      _secondsRemaining = _phases[_currentPhaseIndex].durationSeconds;
      _isPlaying = false;
      _isFinished = false;
    });
  }

  void _skipPhase() {
    _timer?.cancel();
    setState(() {
      _advancePhase();
      if (!_isFinished && _isPlaying) {
        _startTimer();
      }
    });
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final phase = _isFinished ? null : _phases[_currentPhaseIndex];
    final nextPhase = (_currentPhaseIndex < _phases.length - 1 && !_isFinished)
        ? _phases[_currentPhaseIndex + 1]
        : null;

    final totalSeconds = phase?.durationSeconds.toDouble() ?? 1;
    final progress = _isFinished ? 1.0 : (_secondsRemaining / totalSeconds).clamp(0.0, 1.0);

    final isWorkPhase = phase?.phase == IntervalPhase.work;
    final accentColor = isWorkPhase ? AppColors.neonGreen : Colors.orange;

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
                    // Phase label
                    Text(
                      _isFinished ? '🎉 Finished!' : phase!.label,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: _isFinished ? AppColors.neonGreen : accentColor,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Circular Timer
                    SizedBox(
                      width: 280,
                      height: 280,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CustomPaint(
                            painter: _TimerPainter(
                              progress: progress,
                              color: accentColor,
                            ),
                          ),
                          Center(
                            child: Text(
                              _isFinished ? '00:00' : _formatTime(_secondsRemaining),
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
                    const SizedBox(height: 32),
                    // Round counter
                    Text(
                      'Round ${(_currentPhaseIndex ~/ 2) + 1} of ${_phases.length ~/ 2}',
                      style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    // Next Up Indicator
                    Text(
                      nextPhase != null ? 'Next: ${nextPhase.label} (${nextPhase.durationSeconds}s)' : (_isFinished ? 'All done!' : 'Last phase!'),
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
                    onPressed: _reset,
                    isPrimary: false,
                  ),
                  _buildControlButton(
                    icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                    onPressed: _isFinished ? null : _togglePlayPause,
                    isPrimary: true,
                    size: 80,
                  ),
                  _buildControlButton(
                    icon: Icons.skip_next,
                    onPressed: _isFinished ? null : _skipPhase,
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
    required VoidCallback? onPressed,
    required bool isPrimary,
    double size = 64,
  }) {
    final isDisabled = onPressed == null;
    return InkWell(
      onTap: isDisabled ? null : onPressed,
      customBorder: const CircleBorder(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDisabled
              ? AppColors.surface.withOpacity(0.4)
              : (isPrimary ? AppColors.neonGreen : AppColors.surface),
        ),
        child: Icon(
          icon,
          size: size * 0.45,
          color: isPrimary ? AppColors.background : (isDisabled ? AppColors.textSecondary : AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _TimerPainter extends CustomPainter {
  final double progress;
  final Color color;

  _TimerPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 8;

    final bgPaint = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;
    canvas.drawCircle(center, radius, bgPaint);

    final activePaint = Paint()
      ..color = color
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
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
