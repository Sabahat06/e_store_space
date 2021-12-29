

import 'package:e_store_space/update_prompt/ClickType.dart';

abstract class IBorderedButtonClicked {
  void onBorderButtonClick(ClickType clickType);
}

abstract class IFilledButtonClicked {
  void onFilledButtonClick(ClickType clickType);
}
