import 'package:dartz/dartz.dart';
import 'package:sparkz/core/failure/failure.dart';

import 'package:sparkz/feature/search/domain/entity/add_unparked_entity.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_response_entity.dart';
import 'package:sparkz/feature/search/domain/entity/delete_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_response_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_response_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, AddUnparkedResponseEntity>> addUnparked(
      AddUnparkedEntity request);
  Future<Either<Failure, List<AddUnparkedEntity>>> listUnparked(
      ListUnparkedRequestEntity request);
  Future<Either<Failure, List<ListCompatibleSpotsResponseEntity>>>
      listCompatibleSpots(ListCompatibleSpotsEntity request);
  Future<Either<Failure, bool>> deleteUnparked(
      DeleteUnparkedRequestEntity request);
  Future<Either<Failure, SubmitBidResponseEntity>> submitBid(
      SubmitBidRequestEntity request);
}
