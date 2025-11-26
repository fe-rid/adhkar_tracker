import 'package:flutter/material.dart';

class AdhkarCard extends StatefulWidget {
  final String arabic;
  final String translation;
  final int initialCount;
  final ValueChanged<int>? onCountChanged;

  const AdhkarCard({
    Key? key,
    required this.arabic,
    required this.translation,
    this.initialCount = 0,
    this.onCountChanged,
  }) : super(key: key);

  @override
  State<AdhkarCard> createState() => _AdhkarCardState();
}

class _AdhkarCardState extends State<AdhkarCard> {
  late int _count;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  void _increment() {
    setState(() {
      _count++;
      _pressed = true;
    });

    widget.onCountChanged?.call(_count);

    Future.delayed(Duration(milliseconds: 220), () {
      if (mounted) {
        setState(() => _pressed = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Text(
              widget.arabic,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                height: 1.4,
                fontFamily: 'NotoNaskhArabic',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.translation,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Completed',
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 6),
                    Text(
                      '$_count',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.all(_pressed ? 6 : 8),
                  decoration: BoxDecoration(
                    color: _pressed ? primary.withOpacity(0.95) : primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: _increment,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: const Text(
                        '+1',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
