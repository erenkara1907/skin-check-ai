import 'package:patrol/patrol.dart';

/// Shared Patrol configuration for all integration tests.
const patrolConfig = PatrolTesterConfig(
  settleTimeout: Duration(seconds: 15),
  existsTimeout: Duration(seconds: 10),
  visibleTimeout: Duration(seconds: 10),
);
