import 'package:find_hospital/pages/map/map_var.dart';
import 'package:flutter/material.dart';
import '../theme.dart';

class FacilityItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const FacilityItem({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          MapVariable.images + imageUrl,
          width: 60,
        ),
        const SizedBox(
          height: 6,
        ),
        Center(
          child: Text(
            ' $name',
            overflow: TextOverflow.fade,
            style: greyTextStyle.copyWith(
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
