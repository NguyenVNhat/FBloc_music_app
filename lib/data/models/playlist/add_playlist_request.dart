class AddPlaylistRequest {
  String? songId;
  String? IdUser;

  AddPlaylistRequest({this.songId, this.IdUser});
  Map<String, dynamic> toJson() {
    return {
      'idSong': songId,
      'idUser': IdUser,
    };
  }
}
