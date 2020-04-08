import 'package:cloud_firestore/cloud_firestore.dart';

class Kid {
  String id;
  String parent;
  DateTime createdAt;

  Kid({
    this.id,
    this.parent,
    this.createdAt,
  });

  Kid.fromFirestore(DocumentSnapshot doc)
      : id = doc.data['id'],
        parent = doc.data['parent'],
        createdAt = (doc.data['createdAt'] as Timestamp).toDate();

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'parent': parent,
        'createdAt': createdAt,
      };
}
