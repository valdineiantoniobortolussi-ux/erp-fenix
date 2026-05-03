import 'package:tributacao/app/infra/session.dart';
import 'package:tributacao/app/page/shared_widget/message_dialog.dart';

mixin ControllerBaseMixin {
  bool canInsert = false;
  bool canUpdate = false;
  bool canDelete = false;
  String functionName = "";

  void noPrivilegeMessage() {
    showNoPrivilegeSnackBar();
  }

void setPrivilege() {
    final isAdmin = Session.loggedInUser.administrador == 'S';

    // função aninhada para chegar o privilégio
    bool checkPrivilege(String functionName, String privilege) {
      final matchingItems = Session.accessControlList.where(
        (t) => t.funcaoNome?.toLowerCase() == functionName.toLowerCase(),
      ).toList();

      if (matchingItems.isNotEmpty) {
        final item = matchingItems[0];
        switch (privilege) {
          case 'podeInserir':
            return item.podeInserir == 'S';
          case 'podeAlterar':
            return item.podeAlterar == 'S';
          case 'podeExcluir':
            return item.podeExcluir == 'S';
          default:
            return false;
        }
      }
      return false;
    }

    canInsert = isAdmin ? true : checkPrivilege(functionName, 'podeInserir');
    canUpdate = isAdmin ? true : checkPrivilege(functionName, 'podeAlterar');
    canDelete = isAdmin ? true : checkPrivilege(functionName, 'podeExcluir');
  }

}