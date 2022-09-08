part of 'report_bloc.dart';

@immutable
abstract class ReportEvent extends Equatable {
  const ReportEvent();
}

class ReportLoadApiEvent extends ReportEvent {
  @override
  List<Object?> get props => [];
}
