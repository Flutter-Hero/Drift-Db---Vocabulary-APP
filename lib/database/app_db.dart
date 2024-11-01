import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'db_tables.dart';
part 'app_db.g.dart';


LazyDatabase _openConnection(){
  return LazyDatabase((){

    return driftDatabase(name: 'my_database');

  });
}

@DriftDatabase(tables: [Vocabulary, VCategory])
class AppDb extends _$AppDb{

   AppDb() : super(_openConnection());

     @override
  int get schemaVersion => 1;



}