//search records by keyword
// Future<List<Note>> search(String keyword) async {
//   Database db = await DbHelper.instance.getDbInstance();
//   List<Map<String, dynamic>> result = await db.query(
//     DbConstants.tableName,
//     where: '${DbConstants.columnTitle} LIKE ? OR ${DbConstants.columnContent} LIKE ?',
//     whereArgs: ['%$keyword%', '%$keyword%'],
//     orderBy: '${DbConstants.columnCreatedAt} DESC',
//   );
//   List<Note> notes = result.map((e) => Note.fromMap(e)).toList();
//   noteNotifier.value = notes;
//   return notes;
// }
