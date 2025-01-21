import 'package:catfish_mobile/features/onboarding/models/content_card.dart';
import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.item,
  });

  final ContentCardModel item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 18 * 2,
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(24.0),
              ),
            ),
            child: Image.asset(
              item.imageSource,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 28),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 14),
          Text(
            item.subTitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: 12)
        ],
      ),
    );
  }
}
