import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../state/diary_controller.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/ui_kit.dart';

/// Editable note card for a single calendar day.
class DayNoteEditor extends ConsumerStatefulWidget {
  const DayNoteEditor({super.key, required this.dateKey});

  final String dateKey;

  @override
  ConsumerState<DayNoteEditor> createState() => _DayNoteEditorState();
}

class _DayNoteEditorState extends ConsumerState<DayNoteEditor> {
  late final TextEditingController _controller;
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    final initial = ref.read(dayNotesProvider)[widget.dateKey] ?? '';
    _controller = TextEditingController(text: initial);
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(DayNoteEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dateKey != widget.dateKey && !_dirty) {
      _controller.text = ref.read(dayNotesProvider)[widget.dateKey] ?? '';
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final saved = ref.read(dayNotesProvider)[widget.dateKey] ?? '';
    final dirty = _controller.text.trim() != saved.trim();
    if (dirty != _dirty) setState(() => _dirty = dirty);
  }

  void _save() {
    ref.read(dayNotesProvider.notifier).setNote(widget.dateKey, _controller.text);
    setState(() => _dirty = false);
  }

  bool _isToday(String dateKey) {
    final now = DateTime.now();
    final today =
        '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
    return dateKey == today;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;

    ref.listen<Map<String, String>>(dayNotesProvider, (previous, next) {
      if (_dirty) return;
      final note = next[widget.dateKey] ?? '';
      if (_controller.text != note) {
        _controller.text = note;
      }
    });

    final title = _isToday(widget.dateKey) ? t.dayNoteTitle : t.dayNoteLabel;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(AppIcons.note, size: 20, color: tokens.palette.accent),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(title, style: tokens.type.bodyStrong),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(t.dayNoteHint, style: tokens.type.caption),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _controller,
            hint: t.dayNotePlaceholder,
            maxLines: 4,
          ),
          if (_dirty) ...[
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              variant: AppButtonVariant.secondary,
              expand: true,
              onPressed: _save,
              child: Text(t.commonSave),
            ),
          ],
        ],
      ),
    );
  }
}
