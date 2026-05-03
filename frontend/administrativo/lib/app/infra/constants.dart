import 'package:encrypt/encrypt.dart';

class Constants {
	Constants._();

	static const String appName =	'T2Ti ERP 3.0 - Módulo Administrativo';
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
	static bool usingLocalDatabase = false; // este módulo funciona apenas com banco de dados remoto
	static const sqlGetSettings = "SELECT * FROM HIDDEN_SETTINGS WHERE ID=1";

	// server
	static String sentryDns = '';
	static String serverAddress = 'http://localhost';
	static String serverAddressComplement = '';
	static String serverPort = '5050';		 

  //http://localhost:8087/RetaguardaSH
	// sh server
	static String serverShAddress = 'http://localhost';
	static String serverShAddressComplement = '';
	static String serverShPort = '5004';	

  // security
  static String serverLanguage = "PHP";
  static String chave = '1234567890123456789012345678'; 
  static Key key = Key.fromUtf8(chave);
  static IV iv = IV.fromUtf8('1234567890123456');
  static Encrypter encrypter = Encrypter(AES(key, mode: AESMode.ctr, padding: null));  

  // mobile
  static const bool enableMobileLayout = true;	
}

enum DialogType {
	info,
	warning,
	error,
	success,
	question,
	noHeader
}