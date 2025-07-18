import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<E> throttleDroppable<E>({Duration? duration}) {
  return (events, mapper) {
    return events.throttleTime(duration ?? AppConstants.throttleDuration).switchMap(mapper);
  };
}