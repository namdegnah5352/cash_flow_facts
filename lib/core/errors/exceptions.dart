class ServerException implements Exception{
  String message;
  ServerException(this.message);
}
class NoRecord extends ServerException{
  NoRecord(String message) : super(message);
}