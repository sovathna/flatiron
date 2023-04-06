import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/data/app_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider<http.Client>(
  (ref) => http.Client(),
);

final appServiceProvider = Provider<AppService>(
  (ref) => AppServiceImpl(ref.watch(httpClientProvider)),
);
