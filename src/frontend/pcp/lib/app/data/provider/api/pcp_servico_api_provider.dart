import 'dart:convert';
import 'package:pcp/app/data/provider/api/api_provider_base.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PcpServicoApiProvider extends ApiProviderBase {

	Future<List<PcpServicoModel>?> getList({Filter? filter}) async {
		List<PcpServicoModel> pcpServicoModelList = [];

		try {
			handleFilter(filter, '/pcp-servico/');
			
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse(url)!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpServicoModelJson = json.decode(response.body) as List<dynamic>;
					for (var pcpServicoModel in pcpServicoModelJson) {
						pcpServicoModelList.add(PcpServicoModel.fromJson(pcpServicoModel));
					}
					return pcpServicoModelList;
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PcpServicoModel?> getObject(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.get(Uri.tryParse('$endpoint/pcp-servico/$pk')!, headers: ApiProviderBase.headerRequisition());

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpServicoModelJson = json.decode(response.body);
					return PcpServicoModel.fromJson(pcpServicoModelJson);		 
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PcpServicoModel?>? insert(PcpServicoModel pcpServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.post(
				Uri.tryParse('$endpoint/pcp-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pcpServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200 || response.statusCode == 201) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpServicoModelJson = json.decode(response.body);
					return PcpServicoModel.fromJson(pcpServicoModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PcpServicoModel?>? update(PcpServicoModel pcpServicoModel) async {
		try {
			final response = await ApiProviderBase.httpClient.put(
				Uri.tryParse('$endpoint/pcp-servico')!,
				headers: ApiProviderBase.headerRequisition(),
				body: pcpServicoModel.objectEncodeJson(),
			);

			if (response.statusCode == 200) {
				if (response.headers["content-type"]!.contains("html")) {
					handleResultError(response.body, response.headers);
					return null;
				} else {
					var pcpServicoModelJson = json.decode(response.body);
					return PcpServicoModel.fromJson(pcpServicoModelJson);
				}
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			final response = await ApiProviderBase.httpClient.delete(
				Uri.tryParse('$endpoint/pcp-servico/$pk')!,
				headers: ApiProviderBase.headerRequisition(),
			);

			if (response.statusCode == 200) {
				return true;
			} else {
				handleResultError(response.body, response.headers);
				return null;
			}
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	
}
