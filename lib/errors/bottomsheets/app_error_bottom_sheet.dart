import 'package:catfish_mobile/shared/widgets/buttons/primary_button.dart';
import 'package:catfish_mobile/shared/widgets/shadows/illustration_shadow.dart';
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
              IllustrationShadow(
                size: primaryButton == null ? 150 : 120,
              ),
              SvgPicture.asset(
                AppIllustrations.errorIllustration,
                // height: 100,
                alignment: Alignment.center,
                width: primaryButton == null ? 150 : 120,
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
        SizedBox(height: 12.0),
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
        Spacer(),
        if (primaryButton != null)
          primaryButton!.copyWith(
            margin: EdgeInsets.symmetric(horizontal: 24.0),
          ),
        Spacer(),
        // SizedBox(height: 24),
      ],
    );
  }
}
