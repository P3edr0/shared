import '../shared_exceptions.dart';

abstract class IDatasourceExceptionManager {
  ISharedExceptions call(String errorCode);
}
