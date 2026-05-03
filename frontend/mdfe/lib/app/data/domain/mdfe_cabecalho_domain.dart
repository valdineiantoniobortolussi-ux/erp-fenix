class MdfeCabecalhoDomain {
	MdfeCabecalhoDomain._();

	static getUf(String? uf) { 
		switch (uf) { 
			case '': 
			case 'AC': 
				return 'AC'; 
			case 'AL': 
				return 'AL'; 
			case 'AM': 
				return 'AM'; 
			case 'AP': 
				return 'AP'; 
			case 'BA': 
				return 'BA'; 
			case 'CE': 
				return 'CE'; 
			case 'DF': 
				return 'DF'; 
			case 'ES': 
				return 'ES'; 
			case 'GO': 
				return 'GO'; 
			case 'MA': 
				return 'MA'; 
			case 'MG': 
				return 'MG'; 
			case 'MS': 
				return 'MS'; 
			case 'MT': 
				return 'MT'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'PR': 
				return 'PR'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'RS': 
				return 'RS'; 
			case 'SC': 
				return 'SC'; 
			case 'SE': 
				return 'SE'; 
			case 'SP': 
				return 'SP'; 
			case 'TO': 
				return 'TO'; 
			default: 
				return null; 
		} 
	} 

	static setUf(String? uf) { 
		switch (uf) { 
			case 'AC': 
				return 'AC'; 
			case 'AL': 
				return 'AL'; 
			case 'AM': 
				return 'AM'; 
			case 'AP': 
				return 'AP'; 
			case 'BA': 
				return 'BA'; 
			case 'CE': 
				return 'CE'; 
			case 'DF': 
				return 'DF'; 
			case 'ES': 
				return 'ES'; 
			case 'GO': 
				return 'GO'; 
			case 'MA': 
				return 'MA'; 
			case 'MG': 
				return 'MG'; 
			case 'MS': 
				return 'MS'; 
			case 'MT': 
				return 'MT'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'PR': 
				return 'PR'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'RS': 
				return 'RS'; 
			case 'SC': 
				return 'SC'; 
			case 'SE': 
				return 'SE'; 
			case 'SP': 
				return 'SP'; 
			case 'TO': 
				return 'TO'; 
			default: 
				return null; 
		} 
	}

	static getTipoAmbiente(String? tipoAmbiente) { 
		switch (tipoAmbiente) { 
			case '': 
			case '1': 
				return '1-Produção'; 
			case '2': 
				return '2-Homologação'; 
			default: 
				return null; 
		} 
	} 

	static setTipoAmbiente(String? tipoAmbiente) { 
		switch (tipoAmbiente) { 
			case '1-Produção': 
				return '1'; 
			case '2-Homologação': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getTipoEmitente(String? tipoEmitente) { 
		switch (tipoEmitente) { 
			case '': 
			case '1': 
				return '1-Prestador de serviço de transporte'; 
			case '2': 
				return '2-Transportador de Carga Própria'; 
			default: 
				return null; 
		} 
	} 

	static setTipoEmitente(String? tipoEmitente) { 
		switch (tipoEmitente) { 
			case '1-Prestador de serviço de transporte': 
				return '1'; 
			case '2-Transportador de Carga Própria': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getTipoTransportadora(String? tipoTransportadora) { 
		switch (tipoTransportadora) { 
			case '': 
			case 'ETC': 
				return 'ETC'; 
			case 'TAC': 
				return 'TAC'; 
			case 'CTC': 
				return 'CTC'; 
			default: 
				return null; 
		} 
	} 

	static setTipoTransportadora(String? tipoTransportadora) { 
		switch (tipoTransportadora) { 
			case 'ETC': 
				return 'ETC'; 
			case 'TAC': 
				return 'TAC'; 
			case 'CTC': 
				return 'CTC'; 
			default: 
				return null; 
		} 
	}

	static getModelo(String? modelo) { 
		switch (modelo) { 
			case '': 
			case '58': 
				return '58'; 
			default: 
				return null; 
		} 
	} 

	static setModelo(String? modelo) { 
		switch (modelo) { 
			case '58': 
				return '58'; 
			default: 
				return null; 
		} 
	}

	static getModal(String? modal) { 
		switch (modal) { 
			case '': 
			case '1': 
				return '1-Rodoviário'; 
			case '2': 
				return '2-Aéreo'; 
			case '3': 
				return '3-Aquaviário'; 
			case '4': 
				return '4-Ferroviário'; 
			default: 
				return null; 
		} 
	} 

	static setModal(String? modal) { 
		switch (modal) { 
			case '1-Rodoviário': 
				return '1'; 
			case '2-Aéreo': 
				return '2'; 
			case '3-Aquaviário': 
				return '3'; 
			case '4-Ferroviário': 
				return '4'; 
			default: 
				return null; 
		} 
	}

	static getTipoEmissao(String? tipoEmissao) { 
		switch (tipoEmissao) { 
			case '': 
			case '1': 
				return '1-Normal'; 
			case '2': 
				return '2-Contingência'; 
			default: 
				return null; 
		} 
	} 

	static setTipoEmissao(String? tipoEmissao) { 
		switch (tipoEmissao) { 
			case '1-Normal': 
				return '1'; 
			case '2-Contingência': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getProcessoEmissao(String? processoEmissao) { 
		switch (processoEmissao) { 
			case '': 
			case '0': 
				return '0-Emissão de MDF-e com aplicativo do  contribuinte'; 
			case '3': 
				return '3-emissão MDF-e pelo contribuinte com  aplicativo fornecido pelo Fisco'; 
			default: 
				return null; 
		} 
	} 

	static setProcessoEmissao(String? processoEmissao) { 
		switch (processoEmissao) { 
			case '0-Emissão de MDF-e com aplicativo do  contribuinte': 
				return '0'; 
			case '3-emissão MDF-e pelo contribuinte com  aplicativo fornecido pelo Fisco': 
				return '3'; 
			default: 
				return null; 
		} 
	}

	static getUfInicio(String? ufInicio) { 
		switch (ufInicio) { 
			case '': 
			case 'AC': 
				return 'AC'; 
			case 'AL': 
				return 'AL'; 
			case 'AP': 
				return 'AP'; 
			case 'AM': 
				return 'AM'; 
			case 'BA': 
				return 'BA'; 
			case 'CE': 
				return 'CE'; 
			case 'DF': 
				return 'DF'; 
			case 'ES': 
				return 'ES'; 
			case 'GO': 
				return 'GO'; 
			case 'MA': 
				return 'MA'; 
			case 'MT': 
				return 'MT'; 
			case 'MS': 
				return 'MS'; 
			case 'MG': 
				return 'MG'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PR': 
				return 'PR'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RS': 
				return 'RS'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'SC': 
				return 'SC'; 
			case 'SP': 
				return 'SP'; 
			case 'SE': 
				return 'SE'; 
			case 'TO': 
				return 'TO'; 
			default: 
				return null; 
		} 
	} 

	static setUfInicio(String? ufInicio) { 
		switch (ufInicio) { 
			case 'AC': 
				return 'AC'; 
			case 'AL': 
				return 'AL'; 
			case 'AP': 
				return 'AP'; 
			case 'AM': 
				return 'AM'; 
			case 'BA': 
				return 'BA'; 
			case 'CE': 
				return 'CE'; 
			case 'DF': 
				return 'DF'; 
			case 'ES': 
				return 'ES'; 
			case 'GO': 
				return 'GO'; 
			case 'MA': 
				return 'MA'; 
			case 'MT': 
				return 'MT'; 
			case 'MS': 
				return 'MS'; 
			case 'MG': 
				return 'MG'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PR': 
				return 'PR'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RS': 
				return 'RS'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'SC': 
				return 'SC'; 
			case 'SP': 
				return 'SP'; 
			case 'SE': 
				return 'SE'; 
			case 'TO': 
				return 'TO'; 
			default: 
				return null; 
		} 
	}

	static getUfFim(String? ufFim) { 
		switch (ufFim) { 
			case '': 
			case 'AC': 
				return 'AC'; 
			case 'AL': 
				return 'AL'; 
			case 'AP': 
				return 'AP'; 
			case 'AM': 
				return 'AM'; 
			case 'BA': 
				return 'BA'; 
			case 'CE': 
				return 'CE'; 
			case 'DF': 
				return 'DF'; 
			case 'ES': 
				return 'ES'; 
			case 'GO': 
				return 'GO'; 
			case 'MA': 
				return 'MA'; 
			case 'MT': 
				return 'MT'; 
			case 'MS': 
				return 'MS'; 
			case 'MG': 
				return 'MG'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PR': 
				return 'PR'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RS': 
				return 'RS'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'SC': 
				return 'SC'; 
			case 'SP': 
				return 'SP'; 
			case 'SE': 
				return 'SE'; 
			case 'TO': 
				return 'TO'; 
			default: 
				return null; 
		} 
	} 

	static setUfFim(String? ufFim) { 
		switch (ufFim) { 
			case 'AC': 
				return 'AC'; 
			case 'AL': 
				return 'AL'; 
			case 'AP': 
				return 'AP'; 
			case 'AM': 
				return 'AM'; 
			case 'BA': 
				return 'BA'; 
			case 'CE': 
				return 'CE'; 
			case 'DF': 
				return 'DF'; 
			case 'ES': 
				return 'ES'; 
			case 'GO': 
				return 'GO'; 
			case 'MA': 
				return 'MA'; 
			case 'MT': 
				return 'MT'; 
			case 'MS': 
				return 'MS'; 
			case 'MG': 
				return 'MG'; 
			case 'PA': 
				return 'PA'; 
			case 'PB': 
				return 'PB'; 
			case 'PR': 
				return 'PR'; 
			case 'PE': 
				return 'PE'; 
			case 'PI': 
				return 'PI'; 
			case 'RJ': 
				return 'RJ'; 
			case 'RN': 
				return 'RN'; 
			case 'RS': 
				return 'RS'; 
			case 'RO': 
				return 'RO'; 
			case 'RR': 
				return 'RR'; 
			case 'SC': 
				return 'SC'; 
			case 'SP': 
				return 'SP'; 
			case 'SE': 
				return 'SE'; 
			case 'TO': 
				return 'TO'; 
			default: 
				return null; 
		} 
	}

	static getCodigoUnidadeMedida(String? codigoUnidadeMedida) { 
		switch (codigoUnidadeMedida) { 
			case '': 
			case '0': 
				return '01-KG'; 
			case '1': 
				return '02-TON'; 
			default: 
				return null; 
		} 
	} 

	static setCodigoUnidadeMedida(String? codigoUnidadeMedida) { 
		switch (codigoUnidadeMedida) { 
			case '01-KG': 
				return '0'; 
			case '02-TON': 
				return '1'; 
			default: 
				return null; 
		} 
	}

}