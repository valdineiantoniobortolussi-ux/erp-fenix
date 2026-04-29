import 'package:get/get.dart';
import 'package:compras/app/page/shared_widget/shared_widget_imports.dart';
import 'package:compras/app/routes/app_routes.dart';
import 'package:compras/app/page/login/login_page.dart';
import 'package:compras/app/page/shared_page/splash_screen_page.dart';
import 'package:compras/app/bindings/bindings_imports.dart';
import 'package:compras/app/page/shared_page/shared_page_imports.dart';
import 'package:compras/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.compraRequisicaoListPage, page:()=> const CompraRequisicaoListPage(), binding: CompraRequisicaoBindings()), 
		GetPage(name: Routes.compraRequisicaoTabPage, page:()=> CompraRequisicaoTabPage()),
		GetPage(name: Routes.compraCotacaoListPage, page:()=> const CompraCotacaoListPage(), binding: CompraCotacaoBindings()), 
		GetPage(name: Routes.compraCotacaoTabPage, page:()=> CompraCotacaoTabPage()),
		GetPage(name: Routes.compraPedidoListPage, page:()=> const CompraPedidoListPage(), binding: CompraPedidoBindings()), 
		GetPage(name: Routes.compraPedidoTabPage, page:()=> CompraPedidoTabPage()),
		GetPage(name: Routes.compraTipoRequisicaoListPage, page:()=> const CompraTipoRequisicaoListPage(), binding: CompraTipoRequisicaoBindings()), 
		GetPage(name: Routes.compraTipoRequisicaoEditPage, page:()=> CompraTipoRequisicaoEditPage()),
		GetPage(name: Routes.compraTipoPedidoListPage, page:()=> const CompraTipoPedidoListPage(), binding: CompraTipoPedidoBindings()), 
		GetPage(name: Routes.compraTipoPedidoEditPage, page:()=> CompraTipoPedidoEditPage()),
	];
}