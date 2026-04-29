import 'package:get/get.dart';
import 'package:frotas/app/controller/login_controller.dart';

class LoginBindings implements Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<LoginController>(() => LoginController()),
    ];
  }
}
