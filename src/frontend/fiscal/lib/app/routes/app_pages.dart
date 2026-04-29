import 'package:get/get.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:fiscal/app/routes/app_routes.dart';
import 'package:fiscal/app/page/login/login_page.dart';
import 'package:fiscal/app/page/shared_page/splash_screen_page.dart';
import 'package:fiscal/app/bindings/bindings_imports.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.fiscalParametroListPage, page:()=> const FiscalParametroListPage(), binding: FiscalParametroBindings()), 
		GetPage(name: Routes.fiscalParametroTabPage, page:()=> FiscalParametroTabPage()),
		GetPage(name: Routes.fiscalLivroListPage, page:()=> const FiscalLivroListPage(), binding: FiscalLivroBindings()), 
		GetPage(name: Routes.fiscalLivroTabPage, page:()=> FiscalLivroTabPage()),
		GetPage(name: Routes.simplesNacionalCabecalhoListPage, page:()=> const SimplesNacionalCabecalhoListPage(), binding: SimplesNacionalCabecalhoBindings()), 
		GetPage(name: Routes.simplesNacionalCabecalhoTabPage, page:()=> SimplesNacionalCabecalhoTabPage()),
		GetPage(name: Routes.fiscalMunicipalRegimeListPage, page:()=> const FiscalMunicipalRegimeListPage(), binding: FiscalMunicipalRegimeBindings()), 
		GetPage(name: Routes.fiscalMunicipalRegimeEditPage, page:()=> FiscalMunicipalRegimeEditPage()),
		GetPage(name: Routes.fiscalEstadualRegimeListPage, page:()=> const FiscalEstadualRegimeListPage(), binding: FiscalEstadualRegimeBindings()), 
		GetPage(name: Routes.fiscalEstadualRegimeEditPage, page:()=> FiscalEstadualRegimeEditPage()),
		GetPage(name: Routes.fiscalEstadualPorteListPage, page:()=> const FiscalEstadualPorteListPage(), binding: FiscalEstadualPorteBindings()), 
		GetPage(name: Routes.fiscalEstadualPorteEditPage, page:()=> FiscalEstadualPorteEditPage()),
		GetPage(name: Routes.fiscalNotaFiscalEntradaListPage, page:()=> const FiscalNotaFiscalEntradaListPage(), binding: FiscalNotaFiscalEntradaBindings()), 
		GetPage(name: Routes.fiscalNotaFiscalEntradaEditPage, page:()=> FiscalNotaFiscalEntradaEditPage()),
		GetPage(name: Routes.fiscalApuracaoIcmsListPage, page:()=> const FiscalApuracaoIcmsListPage(), binding: FiscalApuracaoIcmsBindings()), 
		GetPage(name: Routes.fiscalApuracaoIcmsEditPage, page:()=> FiscalApuracaoIcmsEditPage()),
		GetPage(name: Routes.fiscalNotaFiscalSaidaListPage, page:()=> const FiscalNotaFiscalSaidaListPage(), binding: FiscalNotaFiscalSaidaBindings()), 
		GetPage(name: Routes.fiscalNotaFiscalSaidaEditPage, page:()=> FiscalNotaFiscalSaidaEditPage()),
	];
}