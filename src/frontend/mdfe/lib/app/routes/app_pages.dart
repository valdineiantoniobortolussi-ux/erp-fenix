import 'package:get/get.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:mdfe/app/routes/app_routes.dart';
import 'package:mdfe/app/page/login/login_page.dart';
import 'package:mdfe/app/page/shared_page/splash_screen_page.dart';
import 'package:mdfe/app/bindings/bindings_imports.dart';
import 'package:mdfe/app/page/shared_page/shared_page_imports.dart';
import 'package:mdfe/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.mdfeCabecalhoListPage, page:()=> const MdfeCabecalhoListPage(), binding: MdfeCabecalhoBindings()), 
		GetPage(name: Routes.mdfeCabecalhoTabPage, page:()=> MdfeCabecalhoTabPage()),
		GetPage(name: Routes.mdfeInformacaoCteListPage, page:()=> const MdfeInformacaoCteListPage(), binding: MdfeInformacaoCteBindings()), 
		GetPage(name: Routes.mdfeInformacaoCteEditPage, page:()=> MdfeInformacaoCteEditPage()),
		GetPage(name: Routes.mdfeInformacaoNfeListPage, page:()=> const MdfeInformacaoNfeListPage(), binding: MdfeInformacaoNfeBindings()), 
		GetPage(name: Routes.mdfeInformacaoNfeEditPage, page:()=> MdfeInformacaoNfeEditPage()),
		GetPage(name: Routes.mdfeRodoviarioMotoristaListPage, page:()=> const MdfeRodoviarioMotoristaListPage(), binding: MdfeRodoviarioMotoristaBindings()), 
		GetPage(name: Routes.mdfeRodoviarioMotoristaEditPage, page:()=> MdfeRodoviarioMotoristaEditPage()),
		GetPage(name: Routes.mdfeRodoviarioVeiculoListPage, page:()=> const MdfeRodoviarioVeiculoListPage(), binding: MdfeRodoviarioVeiculoBindings()), 
		GetPage(name: Routes.mdfeRodoviarioVeiculoEditPage, page:()=> MdfeRodoviarioVeiculoEditPage()),
		GetPage(name: Routes.mdfeRodoviarioPedagioListPage, page:()=> const MdfeRodoviarioPedagioListPage(), binding: MdfeRodoviarioPedagioBindings()), 
		GetPage(name: Routes.mdfeRodoviarioPedagioEditPage, page:()=> MdfeRodoviarioPedagioEditPage()),
		GetPage(name: Routes.mdfeRodoviarioCiotListPage, page:()=> const MdfeRodoviarioCiotListPage(), binding: MdfeRodoviarioCiotBindings()), 
		GetPage(name: Routes.mdfeRodoviarioCiotEditPage, page:()=> MdfeRodoviarioCiotEditPage()),
	];
}