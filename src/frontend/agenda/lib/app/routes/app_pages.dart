import 'package:get/get.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';
import 'package:agenda/app/routes/app_routes.dart';
import 'package:agenda/app/page/login/login_page.dart';
import 'package:agenda/app/page/shared_page/splash_screen_page.dart';
import 'package:agenda/app/bindings/bindings_imports.dart';
import 'package:agenda/app/page/shared_page/shared_page_imports.dart';
import 'package:agenda/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.agendaCompromissoListPage, page:()=> const AgendaCompromissoListPage(), binding: AgendaCompromissoBindings()), 
		GetPage(name: Routes.agendaCompromissoTabPage, page:()=> AgendaCompromissoTabPage()),
		GetPage(name: Routes.recadoRemetenteListPage, page:()=> const RecadoRemetenteListPage(), binding: RecadoRemetenteBindings()), 
		GetPage(name: Routes.recadoRemetenteTabPage, page:()=> RecadoRemetenteTabPage()),
		GetPage(name: Routes.agendaCategoriaCompromissoListPage, page:()=> const AgendaCategoriaCompromissoListPage(), binding: AgendaCategoriaCompromissoBindings()), 
		GetPage(name: Routes.agendaCategoriaCompromissoEditPage, page:()=> AgendaCategoriaCompromissoEditPage()),
		GetPage(name: Routes.reuniaoSalaListPage, page:()=> const ReuniaoSalaListPage(), binding: ReuniaoSalaBindings()), 
		GetPage(name: Routes.reuniaoSalaEditPage, page:()=> ReuniaoSalaEditPage()),
	];
}