import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  const Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(2, 2),
              blurRadius: 12,
            )
          ]),
    );
  }
}

class Works extends StatelessWidget {
  const Works({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GridView.count(
    //   crossAxisCount: 3,
    //   childAspectRatio: 1.2,
    //   crossAxisSpacing: 10,
    //   mainAxisSpacing: 10,
    //   shrinkWrap: true, // new line
    //   physics: NeverScrollableScrollPhysics(),
    //   children: [Card(), Card(), Card(), Card(), Card(), Card()],
    // );
    return GridView.extent(
        maxCrossAxisExtent: 600,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.6,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shrinkWrap: true,
        children: const [
          Card(),
          Card(),
          Card(),
          Card(),
          Card(),
          Card(),
          Card(),
          Card(),
        ]);
  }
}
