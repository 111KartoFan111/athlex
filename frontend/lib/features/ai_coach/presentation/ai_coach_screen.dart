import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/network/dio_client.dart';
import '../../auth/presentation/providers/auth_provider.dart';

// ─── Model ───────────────────────────────────────────────────────────────────
enum _Sender { user, coach }

class _ChatMessage {
  final String text;
  final _Sender sender;
  final String? workoutTitle;
  final String? workoutMeta;
  final int? workoutId;
  const _ChatMessage(this.text, this.sender,
      {this.workoutTitle, this.workoutMeta, this.workoutId});
}

// ─── Local response engine ────────────────────────────────────────────────────
class _CoachEngine {
  static const _rng = {'seed': 42};

  static String _reply(String input, String sport, String level) {
    final lower = input.toLowerCase();

    if (lower.contains('sore') || lower.contains('hurt') || lower.contains('pain')) {
      return 'Rest is part of training 💪 Based on your $sport focus and $level level, I recommend active recovery: light stretching and foam rolling for 15-20 minutes. Avoid high-intensity today.';
    }
    if (lower.contains('tired') || lower.contains('fatigue') || lower.contains('Energy')) {
      return 'Feeling low energy happens to everyone. For $level $sport athletes, a shorter workout at 60% intensity still keeps momentum without burning you out further. Hydrate and fuel up first!';
    }
    if (lower.contains('warm') || lower.contains('warmup') || lower.contains('warm up')) {
      return 'Great habit asking about warm-ups! For $sport, I recommend 5-10 min of dynamic movements: leg swings, hip circles, and light cardio. Gets blood flowing and prevents injury.';
    }
    if (lower.contains('cardio') || lower.contains('run') || lower.contains('endurance')) {
      return 'For $level $sport endurance training, try Zone 2 cardio: 30-45 min at a pace where you can hold a conversation. This builds aerobic base efficiently.';
    }
    if (lower.contains('strength') || lower.contains('muscle') || lower.contains('weight')) {
      return 'Building strength at $level for $sport: focus on compound lifts (3×8-12 reps). Progressive overload is key — increase weight by 5% each week when you can complete all reps with good form.';
    }
    if (lower.contains('workout') || lower.contains('today') || lower.contains('plan')) {
      return 'Based on your $level $sport profile, here\'s what I\'d suggest for today: a 30-40 minute session targeting your primary sport movements, followed by 10 min mobility work.';
    }
    if (lower.contains('rest') || lower.contains('recover') || lower.contains('day off')) {
      return 'Recovery days are essential! Sleep, nutrition, and hydration are your best tools. As a $level $sport athlete, aim for 7-9 hours of sleep and 2-3 litres of water daily.';
    }
    if (lower.contains('diet') || lower.contains('eat') || lower.contains('nutrition') || lower.contains('food')) {
      return 'Nutrition for $sport athletes at $level: Aim for protein at 1.6-2g per kg bodyweight. Carbs are your fuel, especially before training. Eat real food over supplements when possible.';
    }
    if (lower.contains('hello') || lower.contains('hi') || lower.contains('hey')) {
      return 'Hey there! I\'m your ATHLEX AI Coach 🤖 I know your profile — $level $sport athlete. Ask me anything about training, recovery, nutrition, or just tell me how you\'re feeling today.';
    }

    // Default fallback
    final defaults = [
      'Great question! For a $level $sport athlete like you, consistency is the #1 factor. Small daily progress beats occasional big efforts.',
      'Tell me more about what you\'re experiencing. The more context you give me, the better I can tailor advice for your $sport training at $level.',
      'As a $level $sport athlete, your goals should guide every session. What are you working towards right now — endurance, strength, or skill?',
    ];
    return defaults[input.length % defaults.length];
  }

  static _ChatMessage respond(String input, String sport, String level) {
    final replyText = _reply(input, sport, level);

    // If workout-related, attach a suggested workout card
    bool offerWorkout = input.toLowerCase().contains('workout') ||
        input.toLowerCase().contains('plan') ||
        input.toLowerCase().contains('today') ||
        input.toLowerCase().contains('muscles') ||
        input.toLowerCase().contains('train');

    if (offerWorkout) {
      return _ChatMessage(replyText, _Sender.coach,
          workoutTitle: 'Adaptive $sport Session',
          workoutMeta: '30 min • Tailored for $level',
          workoutId: null);
    }
    return _ChatMessage(replyText, _Sender.coach);
  }
}

// ─── Screen ───────────────────────────────────────────────────────────────────
class AiCoachScreen extends ConsumerStatefulWidget {
  const AiCoachScreen({super.key});

  @override
  ConsumerState<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends ConsumerState<AiCoachScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isTyping = false;

  late List<_ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = [
      const _ChatMessage(
        'Hey! I\'m your ATHLEX AI Coach 🤖 Tell me how you\'re feeling today or ask anything about your training.',
        _Sender.coach,
      )
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final authState = ref.read(authStateProvider);
    final sport = authState.user?.primarySport?.name ?? 'your sport';
    final level = authState.user?.level?.toString().split('.').last ?? 'beginner';

    setState(() {
      _messages.add(_ChatMessage(text, _Sender.user));
      _isTyping = true;
    });
    _controller.clear();
    _scrollDown();

    // Simulate a short "thinking" delay
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    final reply = _CoachEngine.respond(text, sport, level);
    setState(() {
      _messages.add(reply);
      _isTyping = false;
    });
    _scrollDown();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.neonGreen,
              child: Icon(Icons.smart_toy, color: AppColors.background, size: 18),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI Coach', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Online', style: TextStyle(fontSize: 11, color: AppColors.neonGreen)),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isTyping && index == _messages.length) {
                    return _buildTypingIndicator();
                  }
                  return _buildMessage(context, theme, _messages[index]);
                },
              ),
            ),
            _buildInputBar(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context, ThemeData theme, _ChatMessage msg) {
    final isUser = msg.sender == _Sender.user;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.neonGreen,
              child: Icon(Icons.smart_toy, color: AppColors.background, size: 16),
            ),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.surface : AppColors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                      bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                    ),
                    border: isUser
                        ? null
                        : Border.all(
                            color: AppColors.neonGreen.withOpacity(0.4),
                            width: 1,
                          ),
                    boxShadow: isUser
                        ? null
                        : [
                            BoxShadow(
                              color: AppColors.neonGreen.withOpacity(0.08),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                  ),
                  child: Text(msg.text, style: theme.textTheme.bodyMedium),
                ),
                if (msg.workoutTitle != null) ...[
                  const SizedBox(height: 12),
                  _buildWorkoutCard(context, theme, msg),
                ],
              ],
            ),
          ),
          if (isUser) const SizedBox(width: 10),
          if (isUser)
            const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.surface,
              child: Icon(Icons.person, color: AppColors.textSecondary, size: 16),
            ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, ThemeData theme, _ChatMessage msg) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.fitness_center, color: AppColors.neonGreen, size: 18),
              const SizedBox(width: 8),
              Text('Suggested Workout', style: theme.textTheme.bodySmall?.copyWith(color: AppColors.neonGreen)),
            ],
          ),
          const SizedBox(height: 8),
          Text(msg.workoutTitle!, style: theme.textTheme.titleMedium),
          Text(msg.workoutMeta!, style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (msg.workoutId != null) {
                  context.push('/workout/${msg.workoutId}');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Go to Sports tab to find workouts for your sport!')),
                  );
                }
              },
              child: const Text('Go to Workouts'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.neonGreen,
            child: Icon(Icons.smart_toy, color: AppColors.background, size: 16),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => _Dot(delay: i * 200)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.surface,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
              decoration: InputDecoration(
                hintText: 'Ask your coach...',
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _send,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.neonGreen,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.send, color: AppColors.background, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Animated dot for typing indicator ───────────────────────────────────────
class _Dot extends StatefulWidget {
  final int delay;
  const _Dot({required this.delay});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
    _anim = Tween<double>(begin: 0, end: -6).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, _anim.value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: AppColors.textSecondary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
