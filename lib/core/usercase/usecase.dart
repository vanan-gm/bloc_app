import 'package:bloc_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserCase<SuccessType, Params>{
  Future<Either<Failure, SuccessType>> call(Params params);
}