import 'package:get_it/get_it.dart';
import 'package:vocabulary_app/database/app_db.dart';


GetIt locator = GetIt.instance;


void setUp(){
  locator.registerLazySingleton(()=> AppDb());
}