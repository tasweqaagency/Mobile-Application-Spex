import 'package:equatable/equatable.dart';
import '../../home/model/product_model.dart';

abstract class CompareState extends Equatable {
  const CompareState();

  @override
  List<Object> get props => [];
}

class CompareInitial extends CompareState {}

class CompareLoading extends CompareState {}

class CompareLoaded extends CompareState {
  final List<SimplifiedProductModel> products;
  const CompareLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class CompareError extends CompareState {
  final String message;
  const CompareError(this.message);

  @override
  List<Object> get props => [message];
}
