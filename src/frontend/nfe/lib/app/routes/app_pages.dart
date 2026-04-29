import 'package:get/get.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';
import 'package:nfe/app/routes/app_routes.dart';
import 'package:nfe/app/page/login/login_page.dart';
import 'package:nfe/app/page/shared_page/splash_screen_page.dart';
import 'package:nfe/app/bindings/bindings_imports.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.nfeCabecalhoListPage, page:()=> const NfeCabecalhoListPage(), binding: NfeCabecalhoBindings()), 
		GetPage(name: Routes.nfeCabecalhoTabPage, page:()=> NfeCabecalhoTabPage()),
		GetPage(name: Routes.nfeDetalheListPage, page:()=> const NfeDetalheListPage(), binding: NfeDetalheBindings()), 
		GetPage(name: Routes.nfeDetalheTabPage, page:()=> NfeDetalheTabPage()),
		GetPage(name: Routes.nfeDuplicataListPage, page:()=> const NfeDuplicataListPage(), binding: NfeDuplicataBindings()), 
		GetPage(name: Routes.nfeDuplicataEditPage, page:()=> NfeDuplicataEditPage()),
		GetPage(name: Routes.nfeImportacaoDetalheListPage, page:()=> const NfeImportacaoDetalheListPage(), binding: NfeImportacaoDetalheBindings()), 
		GetPage(name: Routes.nfeImportacaoDetalheEditPage, page:()=> NfeImportacaoDetalheEditPage()),
		GetPage(name: Routes.nfeCanaFornecimentoDiarioListPage, page:()=> const NfeCanaFornecimentoDiarioListPage(), binding: NfeCanaFornecimentoDiarioBindings()), 
		GetPage(name: Routes.nfeCanaFornecimentoDiarioEditPage, page:()=> NfeCanaFornecimentoDiarioEditPage()),
		GetPage(name: Routes.nfeCanaDeducoesSafraListPage, page:()=> const NfeCanaDeducoesSafraListPage(), binding: NfeCanaDeducoesSafraBindings()), 
		GetPage(name: Routes.nfeCanaDeducoesSafraEditPage, page:()=> NfeCanaDeducoesSafraEditPage()),
		GetPage(name: Routes.nfeTransporteReboqueListPage, page:()=> const NfeTransporteReboqueListPage(), binding: NfeTransporteReboqueBindings()), 
		GetPage(name: Routes.nfeTransporteReboqueEditPage, page:()=> NfeTransporteReboqueEditPage()),
		GetPage(name: Routes.nfeTransporteVolumeListPage, page:()=> const NfeTransporteVolumeListPage(), binding: NfeTransporteVolumeBindings()), 
		GetPage(name: Routes.nfeTransporteVolumeEditPage, page:()=> NfeTransporteVolumeEditPage()),
		GetPage(name: Routes.nfeTransporteVolumeLacreListPage, page:()=> const NfeTransporteVolumeLacreListPage(), binding: NfeTransporteVolumeLacreBindings()), 
		GetPage(name: Routes.nfeTransporteVolumeLacreEditPage, page:()=> NfeTransporteVolumeLacreEditPage()),
		GetPage(name: Routes.nfeConfiguracaoListPage, page:()=> const NfeConfiguracaoListPage(), binding: NfeConfiguracaoBindings()), 
		GetPage(name: Routes.nfeConfiguracaoEditPage, page:()=> NfeConfiguracaoEditPage()),
		GetPage(name: Routes.nfeNumeroInutilizadoListPage, page:()=> const NfeNumeroInutilizadoListPage(), binding: NfeNumeroInutilizadoBindings()), 
		GetPage(name: Routes.nfeNumeroInutilizadoEditPage, page:()=> NfeNumeroInutilizadoEditPage()),
	];
}