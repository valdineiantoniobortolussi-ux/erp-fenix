// import 'package:get/get.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/provider/provider_base.dart';
import 'package:http/http.dart' show Client;

class ApiProviderBase extends ProviderBase {
	/// defines the header sent in all requests that follow with the JWT Token
  static Map<String, String>? headerRequisition() {
    if (Session.tokenJWT.isEmpty) {
      return {
        "content-type": "application/json",
        "cnpj": (Session.empresaSessao.cnpj ?? "fenix") // se não tem cnpj definido ainda, vamos mandar o banco de dados padrão
      };
    } else {
      return {
        "content-type": "application/json", 
        // "authentication": "Bearer ${Session.tokenJWT}", //TODO: para o servidor Delphi mude de authorization para a authentication
        "authorization": "Bearer ${Session.tokenJWT}", 
        "cnpj": (Session.empresaSessao.cnpj!)
      };
    }
  }
	static final httpClient = Client();

	// Server
	static final String _endpoint = '${Constants.serverAddress}:${Constants.serverPort}${Constants.serverAddressComplement}';
	get endpoint => _endpoint;
	static var _url = '';
	get url => _url;

  // Server SH
	static final String _endpointSh = '${Constants.serverShAddress}:${Constants.serverShPort}${Constants.serverShAddressComplement}';
	get endpointSh => _endpointSh;
	static var _urlSh = _endpointSh;
	get urlSh => _urlSh;

	static final _resultJsonErrorObj = ResultJsonError();
	get resultJsonErrorObj => _resultJsonErrorObj;

	// the filter should be shipped as follows: ?filter=field||$condition||value
	// reference: https://github.com/nestjsx/crud/wiki/Requests
	void handleFilter(Filter? filter, String entity) {
		String? stringFilter = '';

    /* Para o servidor Node use o outro comente esse bloco e descomente o outro */
		if (filter != null) {
			if (filter.condition == 'cont') {
				stringFilter = '?filter=${filter.field!}||\$cont||${filter.value!}';
			} else if (filter.condition == 'eq') {
				stringFilter = '?filter=${filter.field!}||\$eq||${filter.value!}';
			} else if (filter.condition == 'between') {
				stringFilter = '?filter=${filter.field!}||\$between||${filter.initialDate!},${filter.finalDate!}';
			} else if (filter.condition == 'where') { // in this case the filter has already been mounted on the window
				stringFilter = filter.where;
			}
		}
    

    /* Use esse bloco apenas para o servidor Node 
		if (filter != null) {
			if (filter.condition == 'cont') {
				stringFilter = '?filter=${filter.field!.camelCase}||\$cont||${filter.value!}';
			} else if (filter.condition == 'eq') {
				stringFilter = '?filter=${filter.field!.camelCase}||\$eq||${filter.value!}';
			} else if (filter.condition == 'between') {
				stringFilter = '?filter=${filter.field!.camelCase}||\$between||${filter.initialDate!},${filter.finalDate!}';
			} else if (filter.condition == 'where') { // in this case the filter has already been mounted on the window
				stringFilter = filter.where;
			}
		}*/

		_url = _endpoint + entity + stringFilter!;
    _urlSh = _endpointSh + entity + stringFilter;
	}

}