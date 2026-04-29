import 'package:encrypt/encrypt.dart';
import 'package:cte/app/infra/session.dart';

class Constants {
	Constants._();

	static const String appName =	'T2Ti ERP 3.0 - Tributação';
	static const String appVersion =	'version 1.0.1';
	
	static const double flutterBootstrapGutterSize = 10.0;
	static const int gridRowsPerPage = 10;

	static const String imageDir = 'assets/images';
	static const String dialogQuestionIcon = '$imageDir/dialog-question-icon.png';
	static const String dialogInfoIcon = '$imageDir/dialog-info-icon.png';
	static const String dialogErrorIcon = '$imageDir/dialog-error-icon.png';	
	static const String logotipo = '$imageDir/logotipo.png';
	static const String backgroundImage = '$imageDir/background.png';
	static const String loginImage = '$imageDir/login.jpg';
	static const String profileImage = '$imageDir/profile.png';

	// local database
	static bool usingLocalDatabase = !Session.empresaComPlanoAtivo; // se não tiver com o plano ativo, então carrega o banco local
	static const sqlGetSettings = "SELECT * FROM HIDDEN_SETTINGS WHERE ID=1";

	// server
	static String sentryDns = '';
	static String serverAddress = 'http://localhost';
	static String serverAddressComplement = '';//'/erp3/cte';
	static String serverPort = '5000';		 

	// sh server
	static String serverShAddress = 'http://localhost';
	static String serverShAddressComplement = '/erp3/retaguarda-sh';
	static String serverShPort = '80';	

  // security
  static String serverLanguage = "PHP";
  static String chave = '#Sua-Chave-de-32-caracteres-aqui'; // #Sua-Chave-de-32-caracteres-aqui tem que alterar para produção e gerar os valores do ENV com a chave correta
  static Key key = Key.fromUtf8(chave);
  static IV iv = IV.fromUtf8('#Seu-Vetor-aqui#');
  static Encrypter encrypter = Encrypter(AES(key, mode: AESMode.ctr, padding: null));  
}

enum DialogType {
	info,
	warning,
	error,
	success,
	question,
	noHeader
}