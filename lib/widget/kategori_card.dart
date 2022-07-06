import 'package:find_hospital/models/kategori.dart';
import 'package:find_hospital/theme.dart';
import 'package:flutter/material.dart';

class KategoriCard extends StatelessWidget {
  final Kategori kategori;
  final Function() onpress;
  const KategoriCard(this.kategori, this.onpress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 150,
          width: 120,
          color: const Color(0xffF6F7F8),
          child: Column(children: [
            Image.asset(
              kategori.imageUrl,
              width: 120,
              height: 102,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 11,
            ),
            Text(
              kategori.name,
              style: blackTextStyle.copyWith(fontSize: 16),
            )
          ]),
        ),
      ),
    );
  }
}
