import 'kits/chicago/chicago_ui_kit.dart';
import 'kits/liquid_glass/liquid_glass_ui_kit.dart';
import 'kits/material/material_ui_kit.dart';
import 'kits/nes/nes_ui_kit.dart';
import 'kits/neubrutalism/neubrutalism_ui_kit.dart';
import 'kits/neumorphic/neumorphic_ui_kit.dart';
import 'kits/shadcn/shadcn_ui_kit.dart';
import 'ui_kit.dart';

/// Catalogue of available UI libraries. Add a new [UiKit] here and it becomes
/// selectable live from Settings — no other change required.
class UiKitRegistry {
  const UiKitRegistry._();

  static const String defaultKitId = 'shadcn';

  static const List<UiKit> kits = <UiKit>[
    ShadcnUiKit(),
    MaterialUiKit(),
    LiquidGlassUiKit(),
    NeumorphicUiKit(),
    NesUiKit(),
    ChicagoUiKit(),
    NeubrutalismUiKit(),
  ];

  static UiKit byId(String id) =>
      kits.firstWhere((k) => k.id == id, orElse: () => kits.first);
}
