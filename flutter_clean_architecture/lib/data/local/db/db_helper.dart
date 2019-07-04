abstract class DatabaseHelper{
  String getDatabaseName();
  Future<int> insert(Map<String, dynamic> row);
}