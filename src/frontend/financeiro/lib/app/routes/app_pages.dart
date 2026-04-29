import 'package:get/get.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro/app/routes/app_routes.dart';
import 'package:financeiro/app/page/login/login_page.dart';
import 'package:financeiro/app/page/shared_page/splash_screen_page.dart';
import 'package:financeiro/app/bindings/bindings_imports.dart';
import 'package:financeiro/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
    GetPage(name: Routes.menuModulesPage, page:()=> const MenuModulesPage()),
		
		GetPage(name: Routes.talonarioChequeListPage, page:()=> const TalonarioChequeListPage(), binding: TalonarioChequeBindings()), 
		GetPage(name: Routes.talonarioChequeTabPage, page:()=> TalonarioChequeTabPage()),
		GetPage(name: Routes.finLancamentoPagarListPage, page:()=> const FinLancamentoPagarListPage(), binding: FinLancamentoPagarBindings()), 
		GetPage(name: Routes.finLancamentoPagarTabPage, page:()=> FinLancamentoPagarTabPage()),
		GetPage(name: Routes.finLancamentoReceberListPage, page:()=> const FinLancamentoReceberListPage(), binding: FinLancamentoReceberBindings()), 
		GetPage(name: Routes.finLancamentoReceberTabPage, page:()=> FinLancamentoReceberTabPage()),
		GetPage(name: Routes.bancoContaCaixaListPage, page:()=> const BancoContaCaixaListPage(), binding: BancoContaCaixaBindings()), 
		GetPage(name: Routes.bancoContaCaixaEditPage, page:()=> BancoContaCaixaEditPage()),
		GetPage(name: Routes.finDocumentoOrigemListPage, page:()=> const FinDocumentoOrigemListPage(), binding: FinDocumentoOrigemBindings()), 
		GetPage(name: Routes.finDocumentoOrigemEditPage, page:()=> FinDocumentoOrigemEditPage()),
		GetPage(name: Routes.finNaturezaFinanceiraListPage, page:()=> const FinNaturezaFinanceiraListPage(), binding: FinNaturezaFinanceiraBindings()), 
		GetPage(name: Routes.finNaturezaFinanceiraEditPage, page:()=> FinNaturezaFinanceiraEditPage()),
		GetPage(name: Routes.finStatusParcelaListPage, page:()=> const FinStatusParcelaListPage(), binding: FinStatusParcelaBindings()), 
		GetPage(name: Routes.finStatusParcelaEditPage, page:()=> FinStatusParcelaEditPage()),
		GetPage(name: Routes.finTipoPagamentoListPage, page:()=> const FinTipoPagamentoListPage(), binding: FinTipoPagamentoBindings()), 
		GetPage(name: Routes.finTipoPagamentoEditPage, page:()=> FinTipoPagamentoEditPage()),
		GetPage(name: Routes.finChequeEmitidoListPage, page:()=> const FinChequeEmitidoListPage(), binding: FinChequeEmitidoBindings()), 
		GetPage(name: Routes.finChequeEmitidoEditPage, page:()=> FinChequeEmitidoEditPage()),
		GetPage(name: Routes.finTipoRecebimentoListPage, page:()=> const FinTipoRecebimentoListPage(), binding: FinTipoRecebimentoBindings()), 
		GetPage(name: Routes.finTipoRecebimentoEditPage, page:()=> FinTipoRecebimentoEditPage()),
		GetPage(name: Routes.finChequeRecebidoListPage, page:()=> const FinChequeRecebidoListPage(), binding: FinChequeRecebidoBindings()), 
		GetPage(name: Routes.finChequeRecebidoEditPage, page:()=> FinChequeRecebidoEditPage()),
		GetPage(name: Routes.finConfiguracaoBoletoListPage, page:()=> const FinConfiguracaoBoletoListPage(), binding: FinConfiguracaoBoletoBindings()), 
		GetPage(name: Routes.finConfiguracaoBoletoEditPage, page:()=> FinConfiguracaoBoletoEditPage()),
	];
}