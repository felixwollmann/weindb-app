
import 'package:equatable/equatable.dart';

/// Represents the State of either a Wein, a Sorte, a Region or a Weinbauer
class ElementState<T> extends Equatable {
  /// Whether the element is currently reloading from the database
  final bool isLoading;

  /// Whether the element is currently initially loading from the database
  /// 
  /// In this case, a loading indicator should be shown by the UI
  final bool isInitializing;

  /// Whether there has been an error while loading the data
  final bool isError;

  /// The actual data
  /// 
  /// A list of [T]
  final List<T> data;

  ElementState({
    this.isLoading = false,
    this.isError = false,
    this.data = const [],
    this.isInitializing = false,
  });

  // copyWith
  ElementState<T> copyWith({
    bool? isLoading,
    bool? isError,
    List<T>? data,
    bool? isInitializing,
  }) {
    return ElementState<T>(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      data: data ?? this.data,
      isInitializing: isInitializing ?? this.isInitializing,
    );
  }

  // props for equatable
  @override
  List<Object?> get props => [
        isLoading,
        isError,
        data,
        isInitializing,
      ];
}
