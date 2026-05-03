import 'package:get/get.dart';
import 'package:administrativo/app/routes/app_routes.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';
import 'package:administrativo/app/page/login/login_page.dart';
import 'package:administrativo/app/page/shared_page/splash_screen_page.dart';
import 'package:administrativo/app/bindings/bindings_imports.dart';
import 'package:administrativo/app/page/shared_page/shared_page_imports.dart';
import 'package:administrativo/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    	GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.papelListPage, page:()=> const PapelListPage(), binding: PapelBindings()), 
		GetPage(name: Routes.papelTabPage, page:()=> PapelTabPage()),
		GetPage(name: Routes.empresaListPage, page:()=> const EmpresaListPage(), binding: EmpresaBindings()), 
		GetPage(name: Routes.empresaTabPage, page:()=> EmpresaTabPage()),
		GetPage(name: Routes.auditoriaListPage, page:()=> const AuditoriaListPage(), binding: AuditoriaBindings()), 
		GetPage(name: Routes.funcaoListPage, page:()=> const FuncaoListPage(), binding: FuncaoBindings()), 
		GetPage(name: Routes.usuarioListPage, page:()=> const UsuarioListPage(), binding: UsuarioBindings()), 
		GetPage(name: Routes.usuarioEditPage, page:()=> UsuarioEditPage()),
	];
}