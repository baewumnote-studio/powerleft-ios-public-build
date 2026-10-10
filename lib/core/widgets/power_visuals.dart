import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'app_card.dart';

class PowerBackdrop extends StatelessWidget {
  const PowerBackdrop({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const [Color(0xFF064A3C), Color(0xFF032D26), Color(0xFF021E1B)]
              : const [Color(0xFFF0F8F4), Color(0xFFF7FAF8)],
          stops: dark ? const [0, .45, 1] : null,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -140,
            right: -150,
            width: 430,
            height: 430,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(
                        0xFF50EAB1,
                      ).withValues(alpha: dark ? .08 : .1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class PowerIconTile extends StatelessWidget {
  const PowerIconTile({super.key, required this.icon, this.size = 42});
  final IconData icon;
  final double size;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * .3),
        border: Border.all(color: color.withValues(alpha: .22)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: .22), color.withValues(alpha: .05)],
        ),
      ),
      child: Icon(icon, size: size * .52, color: color),
    );
  }
}

class PowerMark extends StatelessWidget {
  const PowerMark({
    super.key,
    this.size = 56,
    this.plus = false,
    this.tile = true,
  });
  final double size;
  final bool plus;
  final bool tile;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final glyph = CustomPaint(
      size: Size.square(size),
      painter: _PowerMarkPainter(color, plus),
    );
    return ExcludeSemantics(
      child: tile
          ? Container(
              padding: EdgeInsets.all(size * .12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size * .32),
                border: Border.all(color: color.withValues(alpha: .35)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withValues(alpha: .25),
                    color.withValues(alpha: .045),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: .08),
                    blurRadius: 18,
                  ),
                ],
              ),
              child: glyph,
            )
          : glyph,
    );
  }
}

class _PowerMarkPainter extends CustomPainter {
  const _PowerMarkPainter(this.color, this.plus);
  final Color color;
  final bool plus;
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final line = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * .068
      ..strokeCap = StrokeCap.round;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * .22, w * .23, w * .56, w * .65),
        Radius.circular(w * .08),
      ),
      line,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * .4, w * .12, w * .2, w * .11),
        Radius.circular(w * .025),
      ),
      Paint()..color = color,
    );
    final c = Offset(w * .5, w * .555);
    if (plus) {
      canvas.drawLine(c - Offset(w * .12, 0), c + Offset(w * .12, 0), line);
      canvas.drawLine(c - Offset(0, w * .12), c + Offset(0, w * .12), line);
    } else {
      canvas.drawCircle(
        c,
        w * .18,
        Paint()..color = color.withValues(alpha: .23),
      );
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: w * .18),
        -math.pi / 2,
        math.pi * .64,
        true,
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_PowerMarkPainter oldDelegate) =>
      color != oldDelegate.color || plus != oldDelegate.plus;
}

class PowerMetric extends StatelessWidget {
  const PowerMetric({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(
      children: [
        PowerIconTile(icon: icon, size: 36),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(width: 10),
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    ),
  );
}

class PowerComparison extends StatelessWidget {
  const PowerComparison({
    super.key,
    required this.labels,
    required this.values,
    this.gauges = false,
  });
  final List<String> labels;
  final List<String> values;
  final bool gauges;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final vertical =
            constraints.maxWidth < 300 ||
            MediaQuery.textScalerOf(context).scale(16) > 21;
        Widget panel(int i) => Container(
          padding: EdgeInsets.symmetric(
            horizontal: vertical ? 16 : 7,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                scheme.primary.withValues(alpha: i == 1 ? .2 : .08),
                scheme.primary.withValues(alpha: .025),
              ],
            ),
            border: Border.all(
              color: scheme.primary.withValues(alpha: i == 1 ? .95 : .23),
              width: i == 1 ? 1.6 : 1,
            ),
            boxShadow: i == 1
                ? [
                    BoxShadow(
                      color: scheme.primary.withValues(alpha: .09),
                      blurRadius: 16,
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              if (gauges) ...[
                SizedBox(
                  width: 48,
                  height: 28,
                  child: CustomPaint(
                    painter: _GaugePainter(scheme.primary, [.35, .65, .88][i]),
                  ),
                ),
                const SizedBox(height: 14),
              ],
              Text(
                labels[i],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: i == 1 ? scheme.primary : scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 58),
                child: Center(
                  child: Text(
                    values[i],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      height: 1.3,
                      letterSpacing: -.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        if (vertical) {
          return Column(
            children: [
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: SizedBox(width: double.infinity, child: panel(i)),
                ),
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 3; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              Expanded(child: panel(i)),
            ],
          ],
        );
      },
    );
  }
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter(this.color, this.fraction);
  final Color color;
  final double fraction;
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(3, 3, size.width - 6, size.width - 6);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      rect,
      math.pi,
      math.pi,
      false,
      stroke..color = color.withValues(alpha: .18),
    );
    canvas.drawArc(
      rect,
      math.pi,
      math.pi * fraction,
      false,
      stroke..color = color,
    );
    final c = Offset(size.width / 2, size.width / 2),
        angle = math.pi + math.pi * fraction;
    canvas.drawLine(
      c,
      c + Offset(math.cos(angle), math.sin(angle)) * 16,
      Paint()
        ..color = color
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(c, 3, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) =>
      color != oldDelegate.color || fraction != oldDelegate.fraction;
}

class PowerInputRow extends StatelessWidget {
  const PowerInputRow({
    super.key,
    required this.icon,
    required this.label,
    required this.control,
    this.caption,
    this.controlWidth = 116,
  });
  final IconData icon;
  final String label;
  final Widget control;
  final String? caption;
  final double controlWidth;
  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final labelWidget = Row(
          children: [
            PowerIconTile(icon: icon, size: 36),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (caption != null)
                    Text(
                      caption!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
        if (MediaQuery.textScalerOf(context).scale(16) > 20 ||
            constraints.maxWidth < 270) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [labelWidget, const SizedBox(height: 12), control],
          );
        }
        return Row(
          children: [
            Expanded(child: labelWidget),
            const SizedBox(width: 10),
            SizedBox(width: controlWidth, child: control),
          ],
        );
      },
    ),
  );
}

class PowerLandscape extends StatelessWidget {
  const PowerLandscape({super.key, this.height = 100});
  final double height;
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _LandscapePainter(
          Theme.of(context).colorScheme.primary,
          Theme.of(context).brightness == Brightness.dark,
        ),
      ),
    ),
  );
}

class _LandscapePainter extends CustomPainter {
  const _LandscapePainter(this.accent, this.dark);
  final Color accent;
  final bool dark;
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final moon = Offset(w * .79, h * .4);
    canvas.drawCircle(
      moon,
      h * .33,
      Paint()
        ..shader = RadialGradient(
          colors: [accent.withValues(alpha: .24), accent.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: moon, radius: h * .33)),
    );
    canvas.drawCircle(
      moon,
      h * .19,
      Paint()..color = accent.withValues(alpha: dark ? .8 : .6),
    );
    for (var layer = 0; layer < 3; layer++) {
      final path = Path()..moveTo(0, h);
      for (final p in [
        [0.0, .82],
        [.1, .62],
        [.23, .76],
        [.4, .35],
        [.48, .51],
        [.59, .29],
        [.7, .64],
        [.81, .52],
        [1.0, .78],
      ]) {
        path.lineTo(w * p[0], h * (p[1] + layer * .12));
      }
      path.lineTo(w, h);
      path.close();
      canvas.drawPath(
        path,
        Paint()
          ..color = (dark ? const Color(0xFF064438) : const Color(0xFF76C1A4))
              .withValues(alpha: .55 + layer * .15),
      );
    }
    for (final x in [.09, .13, .66, .7, .88, .93]) {
      final treeH = h * (x == .93 ? .6 : .38);
      final tree = Path()
        ..moveTo(w * x, h - treeH)
        ..lineTo(w * x - treeH * .25, h * .96)
        ..lineTo(w * x + treeH * .25, h * .96)
        ..close();
      final color = dark ? const Color(0xFF022E26) : const Color(0xFF3E8D70);
      canvas.drawPath(tree, Paint()..color = color);
      canvas.drawLine(
        Offset(w * x, h - treeH * .2),
        Offset(w * x, h),
        Paint()
          ..color = color
          ..strokeWidth = 3,
      );
    }
  }

  @override
  bool shouldRepaint(_LandscapePainter oldDelegate) =>
      accent != oldDelegate.accent || dark != oldDelegate.dark;
}
