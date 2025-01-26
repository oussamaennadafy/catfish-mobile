import 'package:flutter/material.dart';

enum NameAvatarSize {
  small,
  meduim,
  large,
}

class NameAvatar extends StatelessWidget {
  const NameAvatar({
    super.key,
    this.firstName,
    this.lastName,
    this.size,
  });

  final String? firstName;
  final String? lastName;
  final NameAvatarSize? size;

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding;
    double fontSize;
    switch (size) {
      case NameAvatarSize.large:
        {
          padding = EdgeInsets.all(22.0);
          fontSize = 22;
        }
        break;
      case NameAvatarSize.meduim:
        {
          padding = EdgeInsets.all(14.0);
          fontSize = 14;
        }
        break;
      case NameAvatarSize.small:
        {
          padding = EdgeInsets.all(8.0);
          fontSize = 12;
        }
        break;
      default:
        {
          padding = EdgeInsets.all(14.0);
          fontSize = 14;
        }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.redAccent.shade200,
            borderRadius: BorderRadius.all(
              Radius.circular(9999),
            ),
          ),
          child: Row(
            children: [
              Text(
                firstName != null ? firstName![0] : "G",
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 1),
              Text(
                lastName != null ? lastName![0] : "H",
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
