import 'package:get/get.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:frotas/app/routes/app_routes.dart';
import 'package:frotas/app/page/login/login_page.dart';
import 'package:frotas/app/page/shared_page/splash_screen_page.dart';
import 'package:frotas/app/bindings/bindings_imports.dart';
import 'package:frotas/app/page/shared_page/shared_page_imports.dart';
import 'package:frotas/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.frotaVeiculoListPage, page:()=> const FrotaVeiculoListPage(), binding: FrotaVeiculoBindings()), 
		GetPage(name: Routes.frotaVeiculoTabPage, page:()=> FrotaVeiculoTabPage()),
		GetPage(name: Routes.frotaVeiculoTipoListPage, page:()=> const FrotaVeiculoTipoListPage(), binding: FrotaVeiculoTipoBindings()), 
		GetPage(name: Routes.frotaVeiculoTipoEditPage, page:()=> FrotaVeiculoTipoEditPage()),
		GetPage(name: Routes.frotaCombustivelTipoListPage, page:()=> const FrotaCombustivelTipoListPage(), binding: FrotaCombustivelTipoBindings()), 
		GetPage(name: Routes.frotaCombustivelTipoEditPage, page:()=> FrotaCombustivelTipoEditPage()),
		GetPage(name: Routes.frotaMotoristaListPage, page:()=> const FrotaMotoristaListPage(), binding: FrotaMotoristaBindings()), 
		GetPage(name: Routes.frotaMotoristaEditPage, page:()=> FrotaMotoristaEditPage()),
	];
}