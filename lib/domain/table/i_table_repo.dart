import 'package:aj_customer/infrastructure/core/failures/app_exceptions.dart';
import 'package:fpdart/fpdart.dart';

import 'models/reserve_dining_table.dart';
import 'models/table_reservation_details.dart';

abstract class ITableRepo {
  Future<Option> reserveDiningTable(ReserveDiningTable payload);

  Future<Either<AppExceptions, List<TableReservationDetails>>> reservationHistory();
}
