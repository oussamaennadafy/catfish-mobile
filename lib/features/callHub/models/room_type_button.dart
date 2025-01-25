import 'package:catfish_mobile/features/callHub/enums/room_types.dart';
import 'package:catfish_mobile/shared/widgets/buttons/icon_button.dart';

class RoomTypeButton {
  const RoomTypeButton({
    required this.roomType,
    required this.typeButton,
  });

  final RoomType roomType;
  final AppIconButton typeButton;
}
