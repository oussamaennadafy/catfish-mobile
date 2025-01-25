import 'package:catfish_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:catfish_mobile/theme/app_illustrations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AppErrorBottomSheet extends StatelessWidget {
  const AppErrorBottomSheet({
    super.key,
    this.title,
    this.description,
    this.illustration,
    this.primaryButton,
  });

  final String? illustration;
  final String? title;
  final String? description;
  final PrimaryButton? primaryButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: context.pop,
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.1),
                      blurRadius: 80,
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      9999,
                    ),
                  ),
                ),
              ),
              SvgPicture.asset(
                AppIllustrations.errorIllustration,
                // height: 100,
                alignment: Alignment.center,
                width: 150,
              ),
            ],
          ),
        ),
        SizedBox(height: 18.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title ?? "Oops! Something went wrong",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        SizedBox(height: 18.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            description ?? "The application has encountered an unknown error. try again",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16.0,
            ),
          ),
        ),
        if (primaryButton != null) primaryButton!,
        // SizedBox(height: 24),
      ],
    );
  }
}
