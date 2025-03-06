import 'package:equatable/equatable.dart';
import 'package:sisyphus/utils/helpers/network_status_checker.dart';

class NetworkStatusState extends Equatable {
  final bool isLoading;
  final NetworkStatus? status;

  const NetworkStatusState({required this.isLoading, this.status});

  @override
  List<Object?> get props => [isLoading, status];

  NetworkStatusState copyWith({bool? isLoading, NetworkStatus? status}) {
    return NetworkStatusState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
    );
  }
}
