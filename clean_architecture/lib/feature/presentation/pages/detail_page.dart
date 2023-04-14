import 'package:clean_architecture/common/app_colors.dart';
import 'package:clean_architecture/feature/domain/entities/person_entity.dart';
import 'package:clean_architecture/feature/presentation/widgets/person_cashed_image_widget.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.person});

  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Character"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Text(
              person.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            PersonCashedImage(
              width: 200,
              height: 200,
              imageUrl: person.image,
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  person.status,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _itemDetail("Gender", person.gender),
            const SizedBox(height: 8),
            _itemDetail("Number of episodes", person.episode.length.toString()),
            const SizedBox(height: 8),
            _itemDetail("Species", person.species),
            const SizedBox(height: 8),
            _itemDetail("Last known location", person.location!.name),
            const SizedBox(height: 8),
            _itemDetail("Origin", person.origin!.name),
            const SizedBox(height: 8),
            _itemDetail(
                "Was created", DateTime.parse(person.created).toString()),
          ],
        ),
      ),
    );
  }

  Widget _itemDetail(String firstText, String secondText) {
    return Column(
      children: [
        const SizedBox(
          height: 4,
        ),
        Text(
          "$firstText: ",
          style: const TextStyle(
            color: AppColors.greyBackground,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          secondText,
          style: const TextStyle(
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
