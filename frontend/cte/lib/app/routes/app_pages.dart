import 'package:get/get.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';
import 'package:cte/app/routes/app_routes.dart';
import 'package:cte/app/page/login/login_page.dart';
import 'package:cte/app/page/shared_page/splash_screen_page.dart';
import 'package:cte/app/bindings/bindings_imports.dart';
import 'package:cte/app/page/shared_page/shared_page_imports.dart';
import 'package:cte/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.cteCabecalhoListPage, page:()=> const CteCabecalhoListPage(), binding: CteCabecalhoBindings()), 
		GetPage(name: Routes.cteCabecalhoTabPage, page:()=> CteCabecalhoTabPage()),
		GetPage(name: Routes.cteInformacaoNfTransporteListPage, page:()=> const CteInformacaoNfTransporteListPage(), binding: CteInformacaoNfTransporteBindings()), 
		GetPage(name: Routes.cteInformacaoNfTransporteEditPage, page:()=> CteInformacaoNfTransporteEditPage()),
		GetPage(name: Routes.cteInfNfTransporteLacreListPage, page:()=> const CteInfNfTransporteLacreListPage(), binding: CteInfNfTransporteLacreBindings()), 
		GetPage(name: Routes.cteInfNfTransporteLacreEditPage, page:()=> CteInfNfTransporteLacreEditPage()),
		GetPage(name: Routes.cteInformacaoNfCargaListPage, page:()=> const CteInformacaoNfCargaListPage(), binding: CteInformacaoNfCargaBindings()), 
		GetPage(name: Routes.cteInformacaoNfCargaEditPage, page:()=> CteInformacaoNfCargaEditPage()),
		GetPage(name: Routes.cteInfNfCargaLacreListPage, page:()=> const CteInfNfCargaLacreListPage(), binding: CteInfNfCargaLacreBindings()), 
		GetPage(name: Routes.cteInfNfCargaLacreEditPage, page:()=> CteInfNfCargaLacreEditPage()),
		GetPage(name: Routes.cteDocumentoAnteriorIdListPage, page:()=> const CteDocumentoAnteriorIdListPage(), binding: CteDocumentoAnteriorIdBindings()), 
		GetPage(name: Routes.cteDocumentoAnteriorIdEditPage, page:()=> CteDocumentoAnteriorIdEditPage()),
		GetPage(name: Routes.cteRodoviarioOccListPage, page:()=> const CteRodoviarioOccListPage(), binding: CteRodoviarioOccBindings()), 
		GetPage(name: Routes.cteRodoviarioOccEditPage, page:()=> CteRodoviarioOccEditPage()),
		GetPage(name: Routes.cteRodoviarioPedagioListPage, page:()=> const CteRodoviarioPedagioListPage(), binding: CteRodoviarioPedagioBindings()), 
		GetPage(name: Routes.cteRodoviarioPedagioEditPage, page:()=> CteRodoviarioPedagioEditPage()),
		GetPage(name: Routes.cteRodoviarioVeiculoListPage, page:()=> const CteRodoviarioVeiculoListPage(), binding: CteRodoviarioVeiculoBindings()), 
		GetPage(name: Routes.cteRodoviarioVeiculoEditPage, page:()=> CteRodoviarioVeiculoEditPage()),
		GetPage(name: Routes.cteRodoviarioLacreListPage, page:()=> const CteRodoviarioLacreListPage(), binding: CteRodoviarioLacreBindings()), 
		GetPage(name: Routes.cteRodoviarioLacreEditPage, page:()=> CteRodoviarioLacreEditPage()),
		GetPage(name: Routes.cteRodoviarioMotoristaListPage, page:()=> const CteRodoviarioMotoristaListPage(), binding: CteRodoviarioMotoristaBindings()), 
		GetPage(name: Routes.cteRodoviarioMotoristaEditPage, page:()=> CteRodoviarioMotoristaEditPage()),
		GetPage(name: Routes.cteAquaviarioBalsaListPage, page:()=> const CteAquaviarioBalsaListPage(), binding: CteAquaviarioBalsaBindings()), 
		GetPage(name: Routes.cteAquaviarioBalsaEditPage, page:()=> CteAquaviarioBalsaEditPage()),
		GetPage(name: Routes.cteFerroviarioFerroviaListPage, page:()=> const CteFerroviarioFerroviaListPage(), binding: CteFerroviarioFerroviaBindings()), 
		GetPage(name: Routes.cteFerroviarioFerroviaEditPage, page:()=> CteFerroviarioFerroviaEditPage()),
		GetPage(name: Routes.cteFerroviarioVagaoListPage, page:()=> const CteFerroviarioVagaoListPage(), binding: CteFerroviarioVagaoBindings()), 
		GetPage(name: Routes.cteFerroviarioVagaoEditPage, page:()=> CteFerroviarioVagaoEditPage()),
	];
}