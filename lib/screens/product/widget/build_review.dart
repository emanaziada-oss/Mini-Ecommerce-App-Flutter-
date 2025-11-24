

import 'package:flutter/material.dart';
import 'package:myproject/core/data/models/product_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class BuildReview extends StatelessWidget {
  final Review review;
  const BuildReview({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 20, color: Colors.grey[600]),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      timeago.format(review.date! ),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating!.round() ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            review.comment.toString(),
            style: TextStyle(
                color: Colors.grey[700], fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }
}