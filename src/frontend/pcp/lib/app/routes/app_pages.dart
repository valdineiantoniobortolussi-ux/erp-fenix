import 'package:get/get.dart';
import 'package:pcp/app/page/shared_widget/shared_widget_imports.dart';
import 'package:pcp/app/routes/app_routes.dart';
import 'package:pcp/app/page/login/login_page.dart';
import 'package:pcp/app/page/shared_page/splash_screen_page.dart';
import 'package:pcp/app/bindings/bindings_imports.dart';
import 'package:pcp/app/page/shared_page/shared_page_imports.dart';
import 'package:pcp/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.pcpOpCabecalhoListPage, page:()=> const PcpOpCabecalhoListPage(), binding: PcpOpCabecalhoBindings()), 
		GetPage(name: Routes.pcpOpCabecalhoTabPage, page:()=> PcpOpCabecalhoTabPage()),
		GetPage(name: Routes.pcpServicoListPage, page:()=> const PcpServicoListPage(), binding: PcpServicoBindings()), 
		GetPage(name: Routes.pcpServicoTabPage, page:()=> PcpServicoTabPage()),
		GetPage(name: Routes.pcpInstrucaoListPage, page:()=> const PcpInstrucaoListPage(), binding: PcpInstrucaoBindings()), 
		GetPage(name: Routes.pcpInstrucaoEditPage, page:()=> PcpInstrucaoEditPage()),
	];
}