import 'dart:convert';
import 'package:nfe/app/data/provider/api/api_provider_base.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class ErpTipoPlanoApiProvider extends ApiProviderBase {

	Future<List<ErpTipoPlanoModel>> getList({Filter? filter}) async {
		List<ErpTipoPlanoModel> erpTipoPlanoModelList = [];

		try {
			handleFilter(filter, '/erp-tipo-plano/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(urlSh)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					// handleResultError(response.body, response.headers);
					return [];
				} else {
					var erpTipoPlanoModelJson = json.decode(response.body) as List<dynamic>;
					for (var erpTipoPlanoModel in erpTipoPlanoModelJson) {
						erpTipoPlanoModelList.add(ErpTipoPlanoModel.fromJson(erpTipoPlanoModel));
					}
					return erpTipoPlanoModelList;
				}
			} else {
				handleResultError(response.body, response.headers);
				return [];
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return [];
		}
	}
}
