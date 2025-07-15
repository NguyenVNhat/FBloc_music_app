import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/repository/artist/artist.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class ArtistUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return sl<ArtistRepository>().getArtists();
  }
}
