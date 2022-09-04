import 'package:shop_app/models/login_model.dart';

abstract class StatesLogin {}
class StateInitialLogin extends StatesLogin {}
class StateLoadingLogin extends StatesLogin {}

class StateSuccessLogin extends StatesLogin {
  final LoginModel loginModel;

  StateSuccessLogin(this.loginModel);
}

class StateErrorLogin extends StatesLogin {
  final String error ;

  StateErrorLogin(this.error);

}
class StatePasswordVisibilityLogin extends StatesLogin {}
