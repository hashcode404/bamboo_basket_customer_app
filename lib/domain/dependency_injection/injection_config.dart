import 'package:aj_customer/domain/dependency_injection/injection_config.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void configureInjection() => getIt.init(environment: Environment.prod);
