import 'package:get/get.dart';
import 'package:estoque/app/page/shared_widget/shared_widget_imports.dart';
import 'package:estoque/app/routes/app_routes.dart';
import 'package:estoque/app/page/login/login_page.dart';
import 'package:estoque/app/page/shared_page/splash_screen_page.dart';
import 'package:estoque/app/bindings/bindings_imports.dart';
import 'package:estoque/app/page/shared_page/shared_page_imports.dart';
import 'package:estoque/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.requisicaoInternaCabecalhoListPage, page:()=> const RequisicaoInternaCabecalhoListPage(), binding: RequisicaoInternaCabecalhoBindings()), 
		GetPage(name: Routes.requisicaoInternaCabecalhoTabPage, page:()=> RequisicaoInternaCabecalhoTabPage()),
		GetPage(name: Routes.estoqueReajusteCabecalhoListPage, page:()=> const EstoqueReajusteCabecalhoListPage(), binding: EstoqueReajusteCabecalhoBindings()), 
		GetPage(name: Routes.estoqueReajusteCabecalhoTabPage, page:()=> EstoqueReajusteCabecalhoTabPage()),
		GetPage(name: Routes.estoqueCorListPage, page:()=> const EstoqueCorListPage(), binding: EstoqueCorBindings()), 
		GetPage(name: Routes.estoqueCorEditPage, page:()=> EstoqueCorEditPage()),
		GetPage(name: Routes.estoqueTamanhoListPage, page:()=> const EstoqueTamanhoListPage(), binding: EstoqueTamanhoBindings()), 
		GetPage(name: Routes.estoqueTamanhoEditPage, page:()=> EstoqueTamanhoEditPage()),
		GetPage(name: Routes.estoqueSaborListPage, page:()=> const EstoqueSaborListPage(), binding: EstoqueSaborBindings()), 
		GetPage(name: Routes.estoqueSaborEditPage, page:()=> EstoqueSaborEditPage()),
		GetPage(name: Routes.estoqueMarcaListPage, page:()=> const EstoqueMarcaListPage(), binding: EstoqueMarcaBindings()), 
		GetPage(name: Routes.estoqueMarcaEditPage, page:()=> EstoqueMarcaEditPage()),
		GetPage(name: Routes.estoqueGradeListPage, page:()=> const EstoqueGradeListPage(), binding: EstoqueGradeBindings()), 
		GetPage(name: Routes.estoqueGradeEditPage, page:()=> EstoqueGradeEditPage()),
	];
}