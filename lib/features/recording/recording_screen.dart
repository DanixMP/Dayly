import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/platform.dart';
import '../../l10n/app_localizations.dart';
import '../../state/settings_controller.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import 'camera_recording_view.dart';

/// On Android/iOS this hosts the live camera viewfinder + hold-to-record
/// interaction (Design.MD §6.1) via [CameraRecordingView]. On desktop/web —
/// where there's no capture pipeline — it shows the idle record affordance so
/// the flow and theming can still be exercised while testing UI kits.
class RecordingScreen extends ConsumerWidget {
  const RecordingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final duration = ref.watch(settingsProvider).defaultDurationSec;

    return AppScaffold(
      leading: AppIconButton(
        icon: AppIcons.back,
        tooltip: t.commonBack,
        onPressed: () => context.pop(),
      ),
      title: Text(t.recordTitle, style: tokens.type.sectionTitle),
      body: isMobilePlatform
          ? const CameraRecordingView()
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Faux record button (idle state from the design).
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: p.accent, width: 4),
                      ),
                      child: Center(
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: p.textPrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(t.recordHold, style: tokens.type.body),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      t.recordHint(duration, 10),
                      style: tokens.type.caption,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      t.recordDeviceOnly,
                      textAlign: TextAlign.center,
                      style: tokens.type.caption,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
