import 'package:get_it/get_it.dart';
import 'package:uniris_lib_dart/services/api_coins_service.dart';
import 'package:uniris_mobile_wallet/model/db/appdb.dart';
import 'package:uniris_mobile_wallet/model/vault.dart';
import 'package:uniris_mobile_wallet/service/app_service.dart';
import 'package:uniris_mobile_wallet/util/hapticutil.dart';
import 'package:uniris_mobile_wallet/util/biometrics.dart';
import 'package:uniris_mobile_wallet/util/sharedprefsutil.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<AppService>(() => AppService());
  sl.registerLazySingleton<DBHelper>(() => DBHelper());
  sl.registerLazySingleton<HapticUtil>(() => HapticUtil());
  sl.registerLazySingleton<BiometricUtil>(() => BiometricUtil());
  sl.registerLazySingleton<Vault>(() => Vault());
  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());
  sl.registerLazySingleton<ApiCoinsService>(() => ApiCoinsService());
}
