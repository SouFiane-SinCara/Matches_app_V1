import 'package:flutter/material.dart';
import 'package:match_app_v1/UI/config/colors.dart';

class Matchcard extends StatelessWidget {
  String imageurlone;
  String imageurltow;
  int clubonescoor;
  int clubtowscoor;

  Matchcard({
    super.key,
    required this.imageurlone,
    required this.clubonescoor,
    required this.imageurltow,
    required this.clubtowscoor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: prime,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: prime,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Image.network(imageurlone),
              ),
              Text(
                "$clubonescoor",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 39, color: second),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: second,
                width: 2,
              ),
              Text(
                "$clubtowscoor",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 39, color: second),
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.network(imageurltow)),
            ],
          ),
        ),
      ),
    );
  }
}
