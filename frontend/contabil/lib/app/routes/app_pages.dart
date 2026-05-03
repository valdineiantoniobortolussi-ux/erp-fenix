import 'package:get/get.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';
import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/page/login/login_page.dart';
import 'package:contabil/app/page/shared_page/splash_screen_page.dart';
import 'package:contabil/app/bindings/bindings_imports.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.contabilLancamentoCabecalhoListPage, page:()=> const ContabilLancamentoCabecalhoListPage(), binding: ContabilLancamentoCabecalhoBindings()), 
		GetPage(name: Routes.contabilLancamentoCabecalhoTabPage, page:()=> ContabilLancamentoCabecalhoTabPage()),
		GetPage(name: Routes.contabilDreCabecalhoListPage, page:()=> const ContabilDreCabecalhoListPage(), binding: ContabilDreCabecalhoBindings()), 
		GetPage(name: Routes.contabilDreCabecalhoTabPage, page:()=> ContabilDreCabecalhoTabPage()),
		GetPage(name: Routes.contabilLivroListPage, page:()=> const ContabilLivroListPage(), binding: ContabilLivroBindings()), 
		GetPage(name: Routes.contabilLivroTabPage, page:()=> ContabilLivroTabPage()),
		GetPage(name: Routes.contabilEncerramentoExeCabListPage, page:()=> const ContabilEncerramentoExeCabListPage(), binding: ContabilEncerramentoExeCabBindings()), 
		GetPage(name: Routes.contabilEncerramentoExeCabTabPage, page:()=> ContabilEncerramentoExeCabTabPage()),
		GetPage(name: Routes.centroResultadoListPage, page:()=> const CentroResultadoListPage(), binding: CentroResultadoBindings()), 
		GetPage(name: Routes.centroResultadoTabPage, page:()=> CentroResultadoTabPage()),
		GetPage(name: Routes.rateioCentroResultadoCabListPage, page:()=> const RateioCentroResultadoCabListPage(), binding: RateioCentroResultadoCabBindings()), 
		GetPage(name: Routes.rateioCentroResultadoCabTabPage, page:()=> RateioCentroResultadoCabTabPage()),
		GetPage(name: Routes.contabilIndiceListPage, page:()=> const ContabilIndiceListPage(), binding: ContabilIndiceBindings()), 
		GetPage(name: Routes.contabilIndiceTabPage, page:()=> ContabilIndiceTabPage()),
		GetPage(name: Routes.aidfAimdfListPage, page:()=> const AidfAimdfListPage(), binding: AidfAimdfBindings()), 
		GetPage(name: Routes.aidfAimdfEditPage, page:()=> AidfAimdfEditPage()),
		GetPage(name: Routes.fapListPage, page:()=> const FapListPage(), binding: FapBindings()), 
		GetPage(name: Routes.fapEditPage, page:()=> FapEditPage()),
		GetPage(name: Routes.registroCartorioListPage, page:()=> const RegistroCartorioListPage(), binding: RegistroCartorioBindings()), 
		GetPage(name: Routes.registroCartorioEditPage, page:()=> RegistroCartorioEditPage()),
		GetPage(name: Routes.contabilParametroListPage, page:()=> const ContabilParametroListPage(), binding: ContabilParametroBindings()), 
		GetPage(name: Routes.contabilParametroEditPage, page:()=> ContabilParametroEditPage()),
		GetPage(name: Routes.planoContaRefSpedListPage, page:()=> const PlanoContaRefSpedListPage(), binding: PlanoContaRefSpedBindings()), 
		GetPage(name: Routes.planoContaRefSpedEditPage, page:()=> PlanoContaRefSpedEditPage()),
		GetPage(name: Routes.planoContaListPage, page:()=> const PlanoContaListPage(), binding: PlanoContaBindings()), 
		GetPage(name: Routes.planoContaEditPage, page:()=> PlanoContaEditPage()),
		GetPage(name: Routes.contabilContaListPage, page:()=> const ContabilContaListPage(), binding: ContabilContaBindings()), 
		GetPage(name: Routes.contabilContaEditPage, page:()=> ContabilContaEditPage()),
		GetPage(name: Routes.contabilHistoricoListPage, page:()=> const ContabilHistoricoListPage(), binding: ContabilHistoricoBindings()), 
		GetPage(name: Routes.contabilHistoricoEditPage, page:()=> ContabilHistoricoEditPage()),
		GetPage(name: Routes.contabilLancamentoPadraoListPage, page:()=> const ContabilLancamentoPadraoListPage(), binding: ContabilLancamentoPadraoBindings()), 
		GetPage(name: Routes.contabilLancamentoPadraoEditPage, page:()=> ContabilLancamentoPadraoEditPage()),
		GetPage(name: Routes.contabilLoteListPage, page:()=> const ContabilLoteListPage(), binding: ContabilLoteBindings()), 
		GetPage(name: Routes.contabilLoteEditPage, page:()=> ContabilLoteEditPage()),
		GetPage(name: Routes.contabilLancamentoOrcadoListPage, page:()=> const ContabilLancamentoOrcadoListPage(), binding: ContabilLancamentoOrcadoBindings()), 
		GetPage(name: Routes.contabilLancamentoOrcadoEditPage, page:()=> ContabilLancamentoOrcadoEditPage()),
		GetPage(name: Routes.lancaCentroResultadoListPage, page:()=> const LancaCentroResultadoListPage(), binding: LancaCentroResultadoBindings()), 
		GetPage(name: Routes.lancaCentroResultadoEditPage, page:()=> LancaCentroResultadoEditPage()),
		GetPage(name: Routes.encerraCentroResultadoListPage, page:()=> const EncerraCentroResultadoListPage(), binding: EncerraCentroResultadoBindings()), 
		GetPage(name: Routes.encerraCentroResultadoEditPage, page:()=> EncerraCentroResultadoEditPage()),
		GetPage(name: Routes.contabilContaRateioListPage, page:()=> const ContabilContaRateioListPage(), binding: ContabilContaRateioBindings()), 
		GetPage(name: Routes.contabilContaRateioEditPage, page:()=> ContabilContaRateioEditPage()),
		GetPage(name: Routes.contabilFechamentoListPage, page:()=> const ContabilFechamentoListPage(), binding: ContabilFechamentoBindings()), 
		GetPage(name: Routes.contabilFechamentoEditPage, page:()=> ContabilFechamentoEditPage()),
		GetPage(name: Routes.planoCentroResultadoListPage, page:()=> const PlanoCentroResultadoListPage(), binding: PlanoCentroResultadoBindings()), 
		GetPage(name: Routes.planoCentroResultadoEditPage, page:()=> PlanoCentroResultadoEditPage()),
	];
}