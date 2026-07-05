import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/constants/app_versions.dart';
import '../../l10n/app_localizations.dart';
import '../../state/settings_controller.dart';
import '../../theme/app_fonts.dart';
import '../../theme/app_assets.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/motion/app_motion.dart';
import '../../ui/ui_kit.dart';

/// Hidden behind the About section — tap the version label five times to unlock
/// the color customizer.
class AboutDevScreen extends ConsumerStatefulWidget {
  const AboutDevScreen({super.key});

  @override
  ConsumerState<AboutDevScreen> createState() => _AboutDevScreenState();
}

class _AboutDevScreenState extends ConsumerState<AboutDevScreen> {
  int _versionTapCount = 0;
  DateTime? _lastVersionTap;
  bool _showUnlockMessage = false;
  PackageInfo? _packageInfo;

  static const _requiredTaps = 5;
  static const _tapResetWindow = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _packageInfo = info);
    });
  }

  void _onVersionTap() {
    final now = DateTime.now();
    if (_lastVersionTap != null &&
        now.difference(_lastVersionTap!) > _tapResetWindow) {
      _versionTapCount = 0;
    }
    _lastVersionTap = now;
    _versionTapCount++;

    final settings = ref.read(settingsProvider);
    if (settings.colorCustomizerUnlocked) return;

    if (_versionTapCount >= _requiredTaps) {
      ref.read(settingsProvider.notifier).unlockColorCustomizer();
      setState(() {
        _versionTapCount = 0;
        _showUnlockMessage = true;
      });
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final settings = ref.watch(settingsProvider);
    final version = _packageInfo?.version ?? AppVersions.primary;
    final build = _packageInfo?.buildNumber;

    return AppScaffold(
      leading: AppIconButton(
        icon: AppIcons.back,
        tooltip: t.commonBack,
        onPressed: () => context.pop(),
      ),
      title: Text(t.aboutDevTitle, style: tokens.type.sectionTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          128,
        ),
        children: [
          StaggeredEntrance(
            index: 0,
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  AppLogo(size: 72),
                  const SizedBox(height: AppSpacing.md),
                  Text(t.aboutDevName, style: tokens.type.monthHeader),
                  const SizedBox(height: AppSpacing.xs),
                  Text(t.aboutDevRole, style: tokens.type.label),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    t.aboutDevBio,
                    style: tokens.type.body,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          StaggeredEntrance(
            index: 1,
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        AppIcons.code,
                        size: 18,
                        color: tokens.palette.accent,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(t.aboutDevStackTitle, style: tokens.type.label),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(t.aboutDevStackBody, style: tokens.type.body),
                ],
              ),
            ),
          ),
          if (settings.colorCustomizerUnlocked) ...[
            const SizedBox(height: AppSpacing.md),
            const StaggeredEntrance(
              index: 2,
              child: ColorCustomizerSection(),
            ),
          ],
          if (_showUnlockMessage) ...[
            const SizedBox(height: AppSpacing.md),
            StaggeredEntrance(
              index: 3,
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  t.aboutDevEasterEggUnlocked,
                  style: tokens.type.bodyStrong.copyWith(
                    color: tokens.palette.accent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          StaggeredEntrance(
            index: 4,
            child: Center(
              child: GestureDetector(
                onTap: _onVersionTap,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: tokens.palette.surfaceElevated,
                    borderRadius: const BorderRadius.all(AppRadii.md),
                    border: Border.all(color: tokens.palette.border),
                  ),
                  child: Text(
                    build == null
                        ? t.aboutDevVersion(version)
                        : t.aboutDevVersionBuild(version, build),
                    style: tokens.type.caption,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Accent, background, and photo swatches — only shown after the easter egg unlocks.
class ColorCustomizerSection extends ConsumerWidget {
  const ColorCustomizerSection({super.key});

  static final _imagePicker = ImagePicker();

  Future<void> _pickBackgroundImage(
    BuildContext context,
    WidgetRef ref,
    Brightness brightness,
  ) async {
    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      imageQuality: 85,
    );
    if (picked == null || !context.mounted) return;
    await ref
        .read(settingsProvider.notifier)
        .setCustomBackgroundImage(brightness, picked.path);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final settings = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);
    final brightness = effectiveThemeBrightness(context, settings);
    final overrides = settings.colorOverridesFor(brightness);
    final isDark = brightness == Brightness.dark;
    final imagePath = overrides.backgroundImagePath;

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(AppIcons.palette, size: 18, color: tokens.palette.accent),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  t.settingsCustomColors,
                  style: tokens.type.label,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isDark ? t.settingsCustomColorsDarkHint : t.settingsCustomColorsLightHint,
            style: tokens.type.caption,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(t.settingsAccentColor, style: tokens.type.bodyStrong),
          const SizedBox(height: AppSpacing.xs),
          _ColorSwatchRow(
            colors: CustomColorPresets.accentOptions,
            selected: settings.customAccent,
            onSelected: controller.setCustomAccent,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(t.settingsBackgroundColor, style: tokens.type.bodyStrong),
          const SizedBox(height: AppSpacing.xs),
          _ColorSwatchRow(
            colors: CustomColorPresets.backgroundOptionsFor(brightness),
            selected: overrides.background,
            onSelected: (color) =>
                controller.setCustomBackground(brightness, color),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(t.settingsBackgroundImage, style: tokens.type.bodyStrong),
          const SizedBox(height: AppSpacing.xs),
          Text(t.settingsBackgroundImageHint, style: tokens.type.caption),
          const SizedBox(height: AppSpacing.sm),
          if (imagePath != null) ...[
            ClipRRect(
              borderRadius: const BorderRadius.all(AppRadii.md),
              child: Image.file(
                File(imagePath),
                key: ValueKey(imagePath),
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
                gaplessPlayback: false,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          Row(
            children: [
              Expanded(
                child: AppButton(
                  variant: AppButtonVariant.secondary,
                  onPressed: () => _pickBackgroundImage(context, ref, brightness),
                  child: Text(t.settingsChooseBackgroundImage),
                ),
              ),
              if (imagePath != null) ...[
                const SizedBox(width: AppSpacing.sm),
                AppButton(
                  variant: AppButtonVariant.ghost,
                  onPressed: () =>
                      controller.clearCustomBackgroundImage(brightness),
                  child: Text(t.settingsRemoveBackgroundImage),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(t.settingsBoxColor, style: tokens.type.bodyStrong),
          const SizedBox(height: AppSpacing.xs),
          _ColorSwatchRow(
            colors: CustomColorPresets.surfaceOptionsFor(brightness),
            selected: overrides.surface,
            onSelected: (color) => controller.setCustomSurface(brightness, color),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(t.settingsAppFont, style: tokens.type.bodyStrong),
          const SizedBox(height: AppSpacing.xs),
          Text(t.settingsAppFontHint, style: tokens.type.caption),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final preset in AppFontPresets.unlockedOptions)
                AppChoiceChip(
                  label: Text(_fontLabel(t, preset)),
                  selected: (settings.customFontId ?? AppFontPreset.auto.id) ==
                      preset.id,
                  onTap: () => controller.setCustomFont(preset),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            variant: AppButtonVariant.ghost,
            onPressed: controller.resetCustomColors,
            child: Text(t.settingsResetColors),
          ),
        ],
      ),
    );
  }
}

String _fontLabel(AppLocalizations t, AppFontPreset preset) {
  return switch (preset) {
    AppFontPreset.auto => t.settingsFontAuto,
    AppFontPreset.classic => t.settingsFontClassic,
    AppFontPreset.vazirmatn => t.settingsFontVazir,
    AppFontPreset.poppins => t.settingsFontPoppins,
    AppFontPreset.nunito => t.settingsFontNunito,
    AppFontPreset.lora => t.settingsFontLora,
    AppFontPreset.spaceGrotesk => t.settingsFontSpaceGrotesk,
  };
}

class _ColorSwatchRow extends StatelessWidget {
  const _ColorSwatchRow({
    required this.colors,
    required this.selected,
    required this.onSelected,
  });

  final List<Color> colors;
  final Color? selected;
  final ValueChanged<Color> onSelected;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final color in colors)
          GestureDetector(
            onTap: () => onSelected(color),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected?.toARGB32() == color.toARGB32()
                      ? tokens.palette.accent
                      : tokens.palette.border,
                  width: selected?.toARGB32() == color.toARGB32() ? 2.5 : 1,
                ),
              ),
              child: selected?.toARGB32() == color.toARGB32()
                  ? Icon(
                      AppIcons.check,
                      size: 18,
                      color: _contrastIconColor(color),
                    )
                  : null,
            ),
          ),
      ],
    );
  }

  Color _contrastIconColor(Color background) {
    final luminance = background.computeLuminance();
    return luminance > 0.5 ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5);
  }
}
