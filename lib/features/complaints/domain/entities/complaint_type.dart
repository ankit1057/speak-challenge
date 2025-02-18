import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ComplaintType {
  complaint,
  feedback,
  compliment;

  String get displayName {
    switch (this) {
      case ComplaintType.complaint:
        return 'Complaint';
      case ComplaintType.feedback:
        return 'Feedback';
      case ComplaintType.compliment:
        return 'Compliment';
    }
  }

  String get description {
    switch (this) {
      case ComplaintType.complaint:
        return 'Report an issue or problem that needs resolution';
      case ComplaintType.feedback:
        return 'Share your suggestions for improvement';
      case ComplaintType.compliment:
        return 'Recognize good service or positive experiences';
    }
  }

  IconData get icon {
    switch (this) {
      case ComplaintType.complaint:
        return FontAwesomeIcons.triangleExclamation;
      case ComplaintType.feedback:
        return FontAwesomeIcons.comment;
      case ComplaintType.compliment:
        return FontAwesomeIcons.thumbsUp;
    }
  }

  Color get color {
    switch (this) {
      case ComplaintType.complaint:
        return Colors.orange;
      case ComplaintType.feedback:
        return Colors.blue;
      case ComplaintType.compliment:
        return Colors.green;
    }
  }
} 