import 'package:get/get.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';
import 'package:ponto/app/routes/app_routes.dart';
import 'package:ponto/app/page/login/login_page.dart';
import 'package:ponto/app/page/shared_page/splash_screen_page.dart';
import 'package:ponto/app/bindings/bindings_imports.dart';
import 'package:ponto/app/page/shared_page/shared_page_imports.dart';
import 'package:ponto/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.pontoEscalaListPage, page:()=> const PontoEscalaListPage(), binding: PontoEscalaBindings()), 
		GetPage(name: Routes.pontoEscalaTabPage, page:()=> PontoEscalaTabPage()),
		GetPage(name: Routes.pontoBancoHorasListPage, page:()=> const PontoBancoHorasListPage(), binding: PontoBancoHorasBindings()), 
		GetPage(name: Routes.pontoBancoHorasTabPage, page:()=> PontoBancoHorasTabPage()),
		GetPage(name: Routes.pontoAbonoListPage, page:()=> const PontoAbonoListPage(), binding: PontoAbonoBindings()), 
		GetPage(name: Routes.pontoAbonoTabPage, page:()=> PontoAbonoTabPage()),
		GetPage(name: Routes.pontoParametroListPage, page:()=> const PontoParametroListPage(), binding: PontoParametroBindings()), 
		GetPage(name: Routes.pontoParametroEditPage, page:()=> PontoParametroEditPage()),
		GetPage(name: Routes.pontoHorarioListPage, page:()=> const PontoHorarioListPage(), binding: PontoHorarioBindings()), 
		GetPage(name: Routes.pontoHorarioEditPage, page:()=> PontoHorarioEditPage()),
		GetPage(name: Routes.pontoRelogioListPage, page:()=> const PontoRelogioListPage(), binding: PontoRelogioBindings()), 
		GetPage(name: Routes.pontoRelogioEditPage, page:()=> PontoRelogioEditPage()),
		GetPage(name: Routes.pontoClassificacaoJornadaListPage, page:()=> const PontoClassificacaoJornadaListPage(), binding: PontoClassificacaoJornadaBindings()), 
		GetPage(name: Routes.pontoClassificacaoJornadaEditPage, page:()=> PontoClassificacaoJornadaEditPage()),
		GetPage(name: Routes.pontoHorarioAutorizadoListPage, page:()=> const PontoHorarioAutorizadoListPage(), binding: PontoHorarioAutorizadoBindings()), 
		GetPage(name: Routes.pontoHorarioAutorizadoEditPage, page:()=> PontoHorarioAutorizadoEditPage()),
		GetPage(name: Routes.pontoFechamentoJornadaListPage, page:()=> const PontoFechamentoJornadaListPage(), binding: PontoFechamentoJornadaBindings()), 
		GetPage(name: Routes.pontoFechamentoJornadaEditPage, page:()=> PontoFechamentoJornadaEditPage()),
	];
}