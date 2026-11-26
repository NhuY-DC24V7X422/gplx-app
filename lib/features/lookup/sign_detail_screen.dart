import 'package:flutter/material.dart';

import '../../core/database/app_database.dart';
import '../../data/models/catalog_models.dart';
import '../common/question_image.dart';

// Chi tiết 1 biển báo
class SignDetailScreen extends StatelessWidget {
  const SignDetailScreen({super.key, required this.sign});

  final TrafficSign sign;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Biển ${sign.code}')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          QuestionImage(imageRef: sign.localImagePath, height: 220),
          const SizedBox(height: 20),
          Text(
            sign.name,
            style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${sign.code} · ${signGroupNames[sign.groupCode] ?? sign.groupCode}',
            style: text.titleSmall,
          ),
          const SizedBox(height: 16),
          Text(sign.description, style: text.bodyLarge),
        ],
      ),
    );
  }
}
