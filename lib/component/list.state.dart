import 'package:equatable/equatable.dart';

class ListState<T> extends Equatable {
  final ListLoadStatus _status;
  final IsFullStatus _isFullStatus;
  final List<T> _list;
  const ListState({
    ListLoadStatus? status,
    IsFullStatus? isFullStatus,
    List<T>? list,
  })  : _status = status ?? ListLoadStatus.initial,
        _isFullStatus = isFullStatus ?? IsFullStatus.havemore,
        _list = list ?? const [];

  ListLoadStatus get status => _status;
  IsFullStatus get isFullStatus => _isFullStatus;
  List<T> get list => _list;

  ListState<T> copyWith({
    ListLoadStatus? status,
    IsFullStatus? isFullStatus,
    List<T>? list,
  }) {
    return ListState<T>(
      status: status ?? _status,
      isFullStatus: isFullStatus ?? _isFullStatus,
      list: list ?? _list,
    );
  }

  @override
  List<Object> get props {
    print(_list.length);
    return [_status, _isFullStatus, _list.length, _list];
  }
}

enum ListLoadStatus { initial, loading, success, loadmore }

enum IsFullStatus { isfull, havemore }
