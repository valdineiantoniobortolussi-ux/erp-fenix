import 'dart:convert';

import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';

class EmpresaApiProvider extends ApiProviderBase {

	Future<bool?>? registrar(EmpresaModel empresaModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpointSh/empresa/registra-empresa-erp/')!,
				headers: ApiProviderBase.headerRequisition(),
				body: Util.crypt(empresaModel.objectEncodeJson()),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return false;
				} else {
          Session.empresaSessao = EmpresaModel.fromJson(json.decode(Util.decrypt(response.body)));
          await Session.gravarCnpj();
          return true;
				}
			} else {
				handleResultError(response.body, response.headers);
				return false;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return false;
	}

	Future<EmpresaModel> getEmpresaPorCnpj(dynamic cnpj) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpointSh/empresa/cnpj/$cnpj')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return EmpresaModel();
				} else {
					var empresaModelJson = json.decode(response.body);
					return EmpresaModel.fromJson(empresaModelJson);		 
				}
			} else {
				handleResultError(response.body, response.headers);
				return EmpresaModel();
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return EmpresaModel();
	}

}
