import 'package:get/get.dart';
import 'package:ged/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ged/app/routes/app_routes.dart';
import 'package:ged/app/page/login/login_page.dart';
import 'package:ged/app/page/shared_page/splash_screen_page.dart';
import 'package:ged/app/bindings/bindings_imports.dart';
import 'package:ged/app/page/shared_page/shared_page_imports.dart';
import 'package:ged/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.gedDocumentoCabecalhoListPage, page:()=> const GedDocumentoCabecalhoListPage(), binding: GedDocumentoCabecalhoBindings()), 
		GetPage(name: Routes.gedDocumentoCabecalhoTabPage, page:()=> GedDocumentoCabecalhoTabPage()),
		GetPage(name: Routes.gedTipoDocumentoListPage, page:()=> const GedTipoDocumentoListPage(), binding: GedTipoDocumentoBindings()), 
		GetPage(name: Routes.gedTipoDocumentoEditPage, page:()=> GedTipoDocumentoEditPage()),
		GetPage(name: Routes.gedVersaoDocumentoListPage, page:()=> const GedVersaoDocumentoListPage(), binding: GedVersaoDocumentoBindings()), 
		GetPage(name: Routes.gedVersaoDocumentoEditPage, page:()=> GedVersaoDocumentoEditPage()),
	];
}