import 'package:get/get.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';
import 'package:vendas/app/routes/app_routes.dart';
import 'package:vendas/app/page/login/login_page.dart';
import 'package:vendas/app/page/shared_page/splash_screen_page.dart';
import 'package:vendas/app/bindings/bindings_imports.dart';
import 'package:vendas/app/page/shared_page/shared_page_imports.dart';
import 'package:vendas/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.vendaCondicoesPagamentoListPage, page:()=> const VendaCondicoesPagamentoListPage(), binding: VendaCondicoesPagamentoBindings()), 
		GetPage(name: Routes.vendaCondicoesPagamentoTabPage, page:()=> VendaCondicoesPagamentoTabPage()),
		GetPage(name: Routes.vendaOrcamentoCabecalhoListPage, page:()=> const VendaOrcamentoCabecalhoListPage(), binding: VendaOrcamentoCabecalhoBindings()), 
		GetPage(name: Routes.vendaOrcamentoCabecalhoTabPage, page:()=> VendaOrcamentoCabecalhoTabPage()),
		GetPage(name: Routes.vendaCabecalhoListPage, page:()=> const VendaCabecalhoListPage(), binding: VendaCabecalhoBindings()), 
		GetPage(name: Routes.vendaCabecalhoTabPage, page:()=> VendaCabecalhoTabPage()),
		GetPage(name: Routes.notaFiscalTipoListPage, page:()=> const NotaFiscalTipoListPage(), binding: NotaFiscalTipoBindings()), 
		GetPage(name: Routes.notaFiscalTipoEditPage, page:()=> NotaFiscalTipoEditPage()),
	];
}