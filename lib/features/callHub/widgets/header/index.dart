import 'package:catfish_mobile/features/callHub/widgets/header/counter/index.dart';
import 'package:catfish_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: double.infinity,
      child: Row(
        children: [
          Counter(),
          Spacer(),
          Row(
            spacing: 12.0,
            children: [
              PrimaryButton(
                text: "add friend",
                icon: Icons.people_alt,
                height: 45,
              ),
              Container(
                padding: const EdgeInsets.all(0),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: SizedBox(
                  height: 45,
                  child: Image.network(
                    "https://i.ibb.co/c6m2Rk1/Shape-Square-Person-Duncan-Bentley.jpg",
                    cacheHeight: 45,
                    cacheWidth: 45,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
