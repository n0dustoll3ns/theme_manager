import 'package:provider/provider.dart';
import 'package:themes_sandbox/UX/user_theme_config.dart';
import 'package:themes_sandbox/provider/theme_provider.dart';

class AdditionalChanges {
  final List<UserThemeConfig> newConfigList;
  final int selectedOption;

  AdditionalChanges({required this.newConfigList, required this.selectedOption});

}
