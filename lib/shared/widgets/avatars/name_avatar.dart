import 'package:flutter/material.dart';

class NameAvatar extends StatelessWidget {
  const NameAvatar({
    super.key,
    this.firstName,
    this.lastName,
  });

  final String? firstName;
  final String? lastName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(22.0),
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
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 1),
              Text(
                lastName != null ? lastName![0] : "H",
                style: TextStyle(
                  fontSize: 22,
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
