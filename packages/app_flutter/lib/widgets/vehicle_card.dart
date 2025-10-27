import 'package:flutter/material.dart';

enum VehicleType { car, motorcycle, truck }

class VehicleCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final VehicleType type;
  final VoidCallback? onTap;
  final DismissDirectionCallback? onDismissed;

  const VehicleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.type,
    this.onTap,
    this.onDismissed,
  });

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    IconData icon;
    List<Color> gradient;
    switch (widget.type) {
      case VehicleType.car:
        icon = Icons.directions_car_rounded;
        gradient = [scheme.primary, scheme.tertiary];
        break;
      case VehicleType.motorcycle:
        icon = Icons.two_wheeler_rounded;
        gradient = [scheme.secondary, scheme.primary];
        break;
      case VehicleType.truck:
        icon = Icons.local_shipping_rounded;
        gradient = [scheme.tertiary, scheme.secondary];
        break;
    }

    return Dismissible(
      key: ValueKey(widget.title + widget.subtitle),
      direction: widget.onDismissed == null
          ? DismissDirection.none
          : DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: scheme.error,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: scheme.onError),
      ),
      onDismissed: widget.onDismissed,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.98 : 1,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTapDown: (_) => setState(() => _pressed = true),
            onTapCancel: () => setState(() => _pressed = false),
            onTap: () {
              setState(() => _pressed = false);
              widget.onTap?.call();
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradient.first.withAlpha((0.12 * 255).round()),
                    gradient.last.withAlpha((0.06 * 255).round()),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: scheme.surfaceTint.withAlpha((0.15 * 255).round()),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, size: 26, color: scheme.primary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
