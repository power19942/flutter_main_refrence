import 'package:flutter/foundation.dart';
import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/services/api_path.dart';
import 'package:time_tracker/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job jobData);

  Stream<List<Job>> jobsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;
  final _service = FirestoreService.instance;

  Future<void> setJob(Job job) async =>
      await _service.setData(path: ApiPath.job(uid, job.id), data: job.toMap());

  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: ApiPath.jobs(uid),
      builder: (data, documentId) {
        return Job.fromMap(data, documentId);
      });
}
