import 'package:flutter/material.dart';

import 'gp_theme.dart';

/// Official GymPulse mark. Same asset as the launcher icon.
class GpLogo extends StatelessWidget {
  const GpLogo({super.key, this.size = 72, this.rounded = true});

  static const assetPath = 'assets/branding/gympulse_icon.png';

  final double size;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      semanticLabel: 'Mr. Gym',
    );
    if (!rounded) return image;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.22),
      child: image,
    );
  }
}

/// Logo plus GymPulse wordmark for auth, setup, and Settings.
class GpBrandHeader extends StatelessWidget {
  const GpBrandHeader({
    super.key,
    this.logoSize = 72,
    this.subtitle,
    this.compact = false,
  });

  final double logoSize;
  final String? subtitle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final titleStyle = compact
        ? Theme.of(context).textTheme.titleLarge
        : Theme.of(context).textTheme.headlineMedium;
    if (compact) {
      return Row(
        children: [
          GpLogo(size: logoSize),
          const SizedBox(width: GpSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mr. Gym', style: titleStyle),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(color: GpColors.textSecondary),
                  ),
              ],
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GpLogo(size: logoSize),
        const SizedBox(height: GpSpacing.md),
        Text('Mr. Gym', style: titleStyle),
        if (subtitle != null) ...[
          const SizedBox(height: GpSpacing.xs),
          Text(
            subtitle!,
            style: const TextStyle(color: GpColors.textSecondary),
          ),
        ],
      ],
    );
  }
}
