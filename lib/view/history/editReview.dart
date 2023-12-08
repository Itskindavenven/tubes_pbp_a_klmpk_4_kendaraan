import 'package:flutter/material.dart';
import 'package:pbp_widget_a_klmpk4/entity/review.dart';
import 'package:pbp_widget_a_klmpk4/client/reviewClient.dart';

class EditReviewPage extends StatefulWidget {
  final Review initialReview;

  const EditReviewPage({Key? key, required this.initialReview})
      : super(key: key);

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  late TextEditingController nilaiController;
  late TextEditingController komentarController;

  void initState() {
    super.initState();
    komentarController =
        TextEditingController(text: widget.initialReview.komentar);
    nilaiController =
        TextEditingController(text: widget.initialReview.nilai.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit your review:'),
            TextField(
              controller: komentarController,
              decoration: InputDecoration(labelText: 'Comment'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: nilaiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Rating'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                updateReview(widget.initialReview.id!);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void updateReview(int id) {
    try {
      int rating = int.parse(nilaiController.text);
      Review updateReview = Review(
        id: id,
        id_user: widget.initialReview.id_user,
        id_car: widget.initialReview.id_car,
        komentar: komentarController.text,
        nilai: rating,
      );
      reviewClient.update(updateReview);
    } catch (e) {
      print('Error parsing rating: $e');
    }
  }
}