import 'package:flutter_bloc_project/data/repository/artist/artist_repository_impl.dart';
import 'package:flutter_bloc_project/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_bloc_project/data/repository/banner/banner_repository_impl.dart';
import 'package:flutter_bloc_project/data/repository/blog/blog_repository_impl.dart';
import 'package:flutter_bloc_project/data/repository/genres/genres_repository_impl.dart';
import 'package:flutter_bloc_project/data/repository/playlist/playlist_repository_impl.dart';
import 'package:flutter_bloc_project/data/repository/song/song_repository_impl.dart';
import 'package:flutter_bloc_project/data/repository/video/video_repository_impl.dart';
import 'package:flutter_bloc_project/data/sources/artist/artist_firebase_service.dart';
import 'package:flutter_bloc_project/data/sources/auth/auth_firebase_service.dart';
import 'package:flutter_bloc_project/data/sources/banner/banner_firebase_service.dart';
import 'package:flutter_bloc_project/data/sources/blog/blog_firebase_service.dart';
import 'package:flutter_bloc_project/data/sources/genres/genres_firebase_service.dart';
import 'package:flutter_bloc_project/data/sources/playlist/playlist_firebase_service.dart';
import 'package:flutter_bloc_project/data/sources/song/song_firebase_service.dart';
import 'package:flutter_bloc_project/data/sources/video/video_firebase_service.dart';
import 'package:flutter_bloc_project/domain/repository/artist/artist.dart';
import 'package:flutter_bloc_project/domain/repository/auth/auth.dart';
import 'package:flutter_bloc_project/domain/repository/banner/banner.dart';
import 'package:flutter_bloc_project/domain/repository/blog/blog.dart';
import 'package:flutter_bloc_project/domain/repository/genres/genres.dart';
import 'package:flutter_bloc_project/domain/repository/playlist/playlist.dart';
import 'package:flutter_bloc_project/domain/repository/song/song.dart';
import 'package:flutter_bloc_project/domain/repository/video/video.dart';
import 'package:flutter_bloc_project/domain/usecases/artist/artist.dart';
import 'package:flutter_bloc_project/domain/usecases/auth/signin.dart';
import 'package:flutter_bloc_project/domain/usecases/auth/signup.dart';
import 'package:flutter_bloc_project/domain/usecases/banner/banner.dart';
import 'package:flutter_bloc_project/domain/usecases/blog/blog.dart';
import 'package:flutter_bloc_project/domain/usecases/genres/genre_detail.dart';
import 'package:flutter_bloc_project/domain/usecases/genres/genres.dart';
import 'package:flutter_bloc_project/domain/usecases/playlist/playlist.dart';
import 'package:flutter_bloc_project/domain/usecases/playlist/playlist_add.dart';
import 'package:flutter_bloc_project/domain/usecases/playlist/playlist_delete.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song_add.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song_delete.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song_detail.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song_update.dart';
import 'package:flutter_bloc_project/domain/usecases/video/video.dart';
import 'package:flutter_bloc_project/domain/usecases/video/video_detail.dart';
import 'package:flutter_bloc_project/domain/usecases/video/video_genres.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  /// Shared Preferences
  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  /// Firebase Services
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFireBaseService>(SongFireBaseServiceImpl());
  sl.registerSingleton<BlogFirebaseService>(BlogFireBaseServiceImpl());
  sl.registerSingleton<BannerFirebaseService>(BannerFirebaseServiceImpl());
  sl.registerSingleton<GenresFirebaseService>(GenresFirebaseServiceImpl());
  sl.registerSingleton<ArtistFirebaseService>(ArtistFirebaseServiceImpl());
  sl.registerSingleton<VideoFirebaseService>(VideoFirebaseServiceImpl());
  sl.registerSingleton<PlaylistFirebaseService>(PlaylistFirebaseServiceImpl());

  /// Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());
  sl.registerSingleton<BlogRepository>(BlogRepositoryImpl());
  sl.registerSingleton<BannerRepository>(BannerRepositoryImpl());
  sl.registerSingleton<GenresRepository>(GenresRepositoryImpl());
  sl.registerSingleton<ArtistRepository>(ArtistRepositoryImpl());
  sl.registerSingleton<VideoRepository>(VideoRepositoryImpl());
  sl.registerSingleton<PlaylistRepository>(PlaylistRepositoryImpl());

  /// UseCases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<SongUseCase>(SongUseCase());
  sl.registerSingleton<SongDetailUseCase>(SongDetailUseCase());
  sl.registerSingleton<SongAddUseCase>(SongAddUseCase());
  sl.registerSingleton<SongUpdateUseCase>(SongUpdateUseCase());
  sl.registerSingleton<SongDeleteUseCase>(SongDeleteUseCase());
  sl.registerSingleton<BlogUseCase>(BlogUseCase());
  sl.registerSingleton<BannerUseCase>(BannerUseCase());
  sl.registerSingleton<GenresUseCase>(GenresUseCase());
  sl.registerSingleton<GenreDetailUseCase>(GenreDetailUseCase());
  sl.registerSingleton<ArtistUseCase>(ArtistUseCase());
  sl.registerSingleton<VideoUseCase>(VideoUseCase());
  sl.registerSingleton<VideoDetailUseCase>(VideoDetailUseCase());
  sl.registerSingleton<VideoGenresUseCase>(VideoGenresUseCase());
  sl.registerSingleton<PlaylistUseCase>(PlaylistUseCase());
  sl.registerSingleton<PlaylistAddUseCase>(PlaylistAddUseCase());
  sl.registerSingleton<PlaylistDeleteUseCase>(PlaylistDeleteUseCase());
}
