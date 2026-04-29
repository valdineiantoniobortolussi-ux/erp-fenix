import 'package:get/get.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';
import 'package:patrimonio/app/routes/app_routes.dart';
import 'package:patrimonio/app/page/login/login_page.dart';
import 'package:patrimonio/app/page/shared_page/splash_screen_page.dart';
import 'package:patrimonio/app/bindings/bindings_imports.dart';
import 'package:patrimonio/app/page/shared_page/shared_page_imports.dart';
import 'package:patrimonio/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.patrimBemListPage, page:()=> const PatrimBemListPage(), binding: PatrimBemBindings()), 
		GetPage(name: Routes.patrimBemTabPage, page:()=> PatrimBemTabPage()),
		GetPage(name: Routes.patrimIndiceAtualizacaoListPage, page:()=> const PatrimIndiceAtualizacaoListPage(), binding: PatrimIndiceAtualizacaoBindings()), 
		GetPage(name: Routes.patrimIndiceAtualizacaoEditPage, page:()=> PatrimIndiceAtualizacaoEditPage()),
		GetPage(name: Routes.patrimTaxaDepreciacaoListPage, page:()=> const PatrimTaxaDepreciacaoListPage(), binding: PatrimTaxaDepreciacaoBindings()), 
		GetPage(name: Routes.patrimTaxaDepreciacaoEditPage, page:()=> PatrimTaxaDepreciacaoEditPage()),
		GetPage(name: Routes.patrimGrupoBemListPage, page:()=> const PatrimGrupoBemListPage(), binding: PatrimGrupoBemBindings()), 
		GetPage(name: Routes.patrimGrupoBemEditPage, page:()=> PatrimGrupoBemEditPage()),
		GetPage(name: Routes.patrimTipoAquisicaoBemListPage, page:()=> const PatrimTipoAquisicaoBemListPage(), binding: PatrimTipoAquisicaoBemBindings()), 
		GetPage(name: Routes.patrimTipoAquisicaoBemEditPage, page:()=> PatrimTipoAquisicaoBemEditPage()),
		GetPage(name: Routes.patrimEstadoConservacaoListPage, page:()=> const PatrimEstadoConservacaoListPage(), binding: PatrimEstadoConservacaoBindings()), 
		GetPage(name: Routes.patrimEstadoConservacaoEditPage, page:()=> PatrimEstadoConservacaoEditPage()),
		GetPage(name: Routes.seguradoraListPage, page:()=> const SeguradoraListPage(), binding: SeguradoraBindings()), 
		GetPage(name: Routes.seguradoraEditPage, page:()=> SeguradoraEditPage()),
		GetPage(name: Routes.patrimTipoMovimentacaoListPage, page:()=> const PatrimTipoMovimentacaoListPage(), binding: PatrimTipoMovimentacaoBindings()), 
		GetPage(name: Routes.patrimTipoMovimentacaoEditPage, page:()=> PatrimTipoMovimentacaoEditPage()),
	];
}