import 'package:find_hospital/pages/detail_page.dart';
import 'package:find_hospital/pages/map/map_var.dart';
import 'package:find_hospital/theme.dart';
import 'package:flutter/material.dart';
import 'package:find_hospital/models/rsapotek.dart';

class RsapotekCard extends StatelessWidget {
  final Rsapotek rsapotek;
  final Function() onpress;
  const RsapotekCard(this.rsapotek, this.onpress, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 130,
              height: 110,
              child: Stack(
                children: [
                  (rsapotek.imageUrl == "null")
                      ? Image.asset('assets/city1.png')
                      : Image.network(MapVariable.images + rsapotek.imageUrl)
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 150 - (2 * edge),
                child: Text(
                  rsapotek.name,
                  style: blackTextStyle.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text.rich(
                TextSpan(
                  text: '${rsapotek.distance}',
                  style: purpleTextStyle.copyWith(
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' Meter',
                      style: greyTextStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                rsapotek.city,
                style: greyTextStyle,
              )
            ],
          ),
        ],
      ),
    );
  }
}
