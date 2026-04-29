# Botão Editar nas Páginas de Lista

## Resumo das Alterações

Foi adicionado um botão de "Editar" em todas as 5 páginas de lista de tributação.

## 1. Definição do botão - `buttons.dart`

**Arquivo:** `lib/app/page/shared_widget/buttons.dart`

**Linhas 61-67:**
```dart
editButton({Function()? onPressed}) {
  return IconButton(
    tooltip: 'button_edit'.tr,                
    icon: iconButtonEdit(),
    onPressed: onPressed,
  );
}
```

O `iconButtonEdit()` já existia em `lib/app/infra/icons_util.dart:19-21`.

---

## 2. Páginas de Lista Modificadas

### 2.1 Grupo Tributário
**Arquivo:** `lib/app/page/modules/tribut_grupo_tributario/tribut_grupo_tributario_list_page.dart`  
**Linha:** 18

```dart
actions: [
    editButton(onPressed: controller.canUpdate ? controller.callEditPage : controller.noPrivilegeMessage),
    deleteButton(onPressed: controller.canDelete ? controller.delete : controller.noPrivilegeMessage),
    exitButton(),
```

### 2.2 Operação Fiscal
**Arquivo:** `lib/app/page/modules/tribut_operacao_fiscal/tribut_operacao_fiscal_list_page.dart`  
**Linha:** 18

```dart
actions: [
    editButton(onPressed: controller.canUpdate ? controller.callEditPage : controller.noPrivilegeMessage),
    deleteButton(onPressed: controller.canDelete ? controller.delete : controller.noPrivilegeMessage),
    exitButton(),
```

### 2.3 ISS
**Arquivo:** `lib/app/page/modules/tribut_iss/tribut_iss_list_page.dart`  
**Linha:** 18

```dart
actions: [
    editButton(onPressed: controller.canUpdate ? controller.callEditPage : controller.noPrivilegeMessage),
    deleteButton(onPressed: controller.canDelete ? controller.delete : controller.noPrivilegeMessage),
    exitButton(),
```

### 2.4 ICMS Customizado
**Arquivo:** `lib/app/page/modules/tribut_icms_custom_cab/tribut_icms_custom_cab_list_page.dart`  
**Linha:** 18

```dart
actions: [
    editButton(onPressed: controller.canUpdate ? controller.callEditPage : controller.noPrivilegeMessage),
    deleteButton(onPressed: controller.canDelete ? controller.delete : controller.noPrivilegeMessage),
    exitButton(),
```

### 2.5 Configura Tributação
**Arquivo:** `lib/app/page/modules/tribut_configura_of_gt/tribut_configura_of_gt_list_page.dart`  
**Linha:** 18

```dart
actions: [
    editButton(onPressed: controller.canUpdate ? controller.callEditPage : controller.noPrivilegeMessage),
    deleteButton(onPressed: controller.canDelete ? controller.delete : controller.noPrivilegeMessage),
    exitButton(),
```

---

## Comportamento

- O botão de editar abre a página de edição (`*_edit_page.dart`)
- Verifica se o usuário tem privilégio de atualização (`canUpdate`)
- Se não tiver privilégio, exibe mensagem "message_user_doesnt_have_privilege"
- Se nenhuma linha estiver selecionada, exibe mensagem "message_select_one_to_edited"
- Funcionalidade idêntica ao duplo clique na linha