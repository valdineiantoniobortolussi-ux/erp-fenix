import 'package:get/get.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';
import 'package:wms/app/routes/app_routes.dart';
import 'package:wms/app/page/login/login_page.dart';
import 'package:wms/app/page/shared_page/splash_screen_page.dart';
import 'package:wms/app/bindings/bindings_imports.dart';
import 'package:wms/app/page/shared_page/shared_page_imports.dart';
import 'package:wms/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.wmsRecebimentoCabecalhoListPage, page:()=> const WmsRecebimentoCabecalhoListPage(), binding: WmsRecebimentoCabecalhoBindings()), 
		GetPage(name: Routes.wmsRecebimentoCabecalhoTabPage, page:()=> WmsRecebimentoCabecalhoTabPage()),
		GetPage(name: Routes.wmsCaixaListPage, page:()=> const WmsCaixaListPage(), binding: WmsCaixaBindings()), 
		GetPage(name: Routes.wmsCaixaTabPage, page:()=> WmsCaixaTabPage()),
		GetPage(name: Routes.wmsOrdemSeparacaoCabListPage, page:()=> const WmsOrdemSeparacaoCabListPage(), binding: WmsOrdemSeparacaoCabBindings()), 
		GetPage(name: Routes.wmsOrdemSeparacaoCabTabPage, page:()=> WmsOrdemSeparacaoCabTabPage()),
		GetPage(name: Routes.wmsAgendamentoListPage, page:()=> const WmsAgendamentoListPage(), binding: WmsAgendamentoBindings()), 
		GetPage(name: Routes.wmsAgendamentoEditPage, page:()=> WmsAgendamentoEditPage()),
		GetPage(name: Routes.wmsParametroListPage, page:()=> const WmsParametroListPage(), binding: WmsParametroBindings()), 
		GetPage(name: Routes.wmsParametroEditPage, page:()=> WmsParametroEditPage()),
		GetPage(name: Routes.wmsRuaListPage, page:()=> const WmsRuaListPage(), binding: WmsRuaBindings()), 
		GetPage(name: Routes.wmsRuaEditPage, page:()=> WmsRuaEditPage()),
		GetPage(name: Routes.wmsEstanteListPage, page:()=> const WmsEstanteListPage(), binding: WmsEstanteBindings()), 
		GetPage(name: Routes.wmsEstanteEditPage, page:()=> WmsEstanteEditPage()),
		GetPage(name: Routes.wmsExpedicaoListPage, page:()=> const WmsExpedicaoListPage(), binding: WmsExpedicaoBindings()), 
		GetPage(name: Routes.wmsExpedicaoEditPage, page:()=> WmsExpedicaoEditPage()),
	];
}