import 'package:bloc_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserCase<SuccessType, Params>{
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams{}

class NormalParams{
  final int page;
  NormalParams({required this.page});
}

class SearchParams{
  final int page;
  final String keyword;
  final List<String> filterCategories;
  SearchParams({required this.keyword, required this.page, this.filterCategories = const []});
}