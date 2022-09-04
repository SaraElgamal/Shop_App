import 'package:shop_app/models/login_model.dart';

abstract class StatesRegister {}
class StateInitialRegister extends StatesRegister {}
class StateLoadingRegister extends StatesRegister {}

class StateSuccessRegister extends StatesRegister {
  final LoginModel loginModel;

  StateSuccessRegister(this.loginModel);
}

class StateErrorRegister extends StatesRegister {
  final String error ;

  StateErrorRegister(this.error);

}
class StatePasswordVisibilityRegister extends StatesRegister {}
