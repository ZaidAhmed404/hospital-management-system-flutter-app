import 'package:bloc/bloc.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingState(loading: false));

  void setLoading(bool load) => emit(LoadingState(loading: load));
}
