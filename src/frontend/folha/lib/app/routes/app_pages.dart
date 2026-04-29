import 'package:get/get.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';
import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/page/login/login_page.dart';
import 'package:folha/app/page/shared_page/splash_screen_page.dart';
import 'package:folha/app/bindings/bindings_imports.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.empresaTransporteListPage, page:()=> const EmpresaTransporteListPage(), binding: EmpresaTransporteBindings()), 
		GetPage(name: Routes.empresaTransporteTabPage, page:()=> EmpresaTransporteTabPage()),
		GetPage(name: Routes.folhaLancamentoCabecalhoListPage, page:()=> const FolhaLancamentoCabecalhoListPage(), binding: FolhaLancamentoCabecalhoBindings()), 
		GetPage(name: Routes.folhaLancamentoCabecalhoTabPage, page:()=> FolhaLancamentoCabecalhoTabPage()),
		GetPage(name: Routes.folhaInssListPage, page:()=> const FolhaInssListPage(), binding: FolhaInssBindings()), 
		GetPage(name: Routes.folhaInssTabPage, page:()=> FolhaInssTabPage()),
		GetPage(name: Routes.folhaPppListPage, page:()=> const FolhaPppListPage(), binding: FolhaPppBindings()), 
		GetPage(name: Routes.folhaPppTabPage, page:()=> FolhaPppTabPage()),
		GetPage(name: Routes.operadoraPlanoSaudeListPage, page:()=> const OperadoraPlanoSaudeListPage(), binding: OperadoraPlanoSaudeBindings()), 
		GetPage(name: Routes.operadoraPlanoSaudeEditPage, page:()=> OperadoraPlanoSaudeEditPage()),
		GetPage(name: Routes.folhaLancamentoComissaoListPage, page:()=> const FolhaLancamentoComissaoListPage(), binding: FolhaLancamentoComissaoBindings()), 
		GetPage(name: Routes.folhaLancamentoComissaoEditPage, page:()=> FolhaLancamentoComissaoEditPage()),
		GetPage(name: Routes.folhaParametroListPage, page:()=> const FolhaParametroListPage(), binding: FolhaParametroBindings()), 
		GetPage(name: Routes.folhaParametroEditPage, page:()=> FolhaParametroEditPage()),
		GetPage(name: Routes.guiasAcumuladasListPage, page:()=> const GuiasAcumuladasListPage(), binding: GuiasAcumuladasBindings()), 
		GetPage(name: Routes.guiasAcumuladasEditPage, page:()=> GuiasAcumuladasEditPage()),
		GetPage(name: Routes.folhaFechamentoListPage, page:()=> const FolhaFechamentoListPage(), binding: FolhaFechamentoBindings()), 
		GetPage(name: Routes.folhaFechamentoEditPage, page:()=> FolhaFechamentoEditPage()),
		GetPage(name: Routes.feriasPeriodoAquisitivoListPage, page:()=> const FeriasPeriodoAquisitivoListPage(), binding: FeriasPeriodoAquisitivoBindings()), 
		GetPage(name: Routes.feriasPeriodoAquisitivoEditPage, page:()=> FeriasPeriodoAquisitivoEditPage()),
		GetPage(name: Routes.folhaTipoAfastamentoListPage, page:()=> const FolhaTipoAfastamentoListPage(), binding: FolhaTipoAfastamentoBindings()), 
		GetPage(name: Routes.folhaTipoAfastamentoEditPage, page:()=> FolhaTipoAfastamentoEditPage()),
		GetPage(name: Routes.folhaAfastamentoListPage, page:()=> const FolhaAfastamentoListPage(), binding: FolhaAfastamentoBindings()), 
		GetPage(name: Routes.folhaAfastamentoEditPage, page:()=> FolhaAfastamentoEditPage()),
		GetPage(name: Routes.folhaPlanoSaudeListPage, page:()=> const FolhaPlanoSaudeListPage(), binding: FolhaPlanoSaudeBindings()), 
		GetPage(name: Routes.folhaPlanoSaudeEditPage, page:()=> FolhaPlanoSaudeEditPage()),
		GetPage(name: Routes.folhaEventoListPage, page:()=> const FolhaEventoListPage(), binding: FolhaEventoBindings()), 
		GetPage(name: Routes.folhaEventoEditPage, page:()=> FolhaEventoEditPage()),
		GetPage(name: Routes.folhaRescisaoListPage, page:()=> const FolhaRescisaoListPage(), binding: FolhaRescisaoBindings()), 
		GetPage(name: Routes.folhaRescisaoEditPage, page:()=> FolhaRescisaoEditPage()),
		GetPage(name: Routes.folhaFeriasColetivasListPage, page:()=> const FolhaFeriasColetivasListPage(), binding: FolhaFeriasColetivasBindings()), 
		GetPage(name: Routes.folhaFeriasColetivasEditPage, page:()=> FolhaFeriasColetivasEditPage()),
		GetPage(name: Routes.folhaValeTransporteListPage, page:()=> const FolhaValeTransporteListPage(), binding: FolhaValeTransporteBindings()), 
		GetPage(name: Routes.folhaValeTransporteEditPage, page:()=> FolhaValeTransporteEditPage()),
		GetPage(name: Routes.folhaInssServicoListPage, page:()=> const FolhaInssServicoListPage(), binding: FolhaInssServicoBindings()), 
		GetPage(name: Routes.folhaInssServicoEditPage, page:()=> FolhaInssServicoEditPage()),
		GetPage(name: Routes.folhaHistoricoSalarialListPage, page:()=> const FolhaHistoricoSalarialListPage(), binding: FolhaHistoricoSalarialBindings()), 
		GetPage(name: Routes.folhaHistoricoSalarialEditPage, page:()=> FolhaHistoricoSalarialEditPage()),
		GetPage(name: Routes.feriadosListPage, page:()=> const FeriadosListPage(), binding: FeriadosBindings()), 
		GetPage(name: Routes.feriadosEditPage, page:()=> FeriadosEditPage()),
	];
}