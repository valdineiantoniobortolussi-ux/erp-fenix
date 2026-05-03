class CteCabecalhoDomain {
	CteCabecalhoDomain._();

	static getUfEmitente(String? ufEmitente) { 
		switch (ufEmitente) { 
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

	static setUfEmitente(String? ufEmitente) { 
		switch (ufEmitente) { 
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

	static getFormaPagamento(String? formaPagamento) { 
		switch (formaPagamento) { 
			case '': 
			case '0': 
				return '0-Pago'; 
			case '1': 
				return '1-A pagar'; 
			case '2': 
				return '2-Outros'; 
			default: 
				return null; 
		} 
	} 

	static setFormaPagamento(String? formaPagamento) { 
		switch (formaPagamento) { 
			case '0-Pago': 
				return '0'; 
			case '1-A pagar': 
				return '1'; 
			case '2-Outros': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getModelo(String? modelo) { 
		switch (modelo) { 
			case '': 
			case '57': 
				return '57'; 
			default: 
				return null; 
		} 
	} 

	static setModelo(String? modelo) { 
		switch (modelo) { 
			case '57': 
				return '57'; 
			default: 
				return null; 
		} 
	}

	static getFormatoImpressaoDacte(String? formatoImpressaoDacte) { 
		switch (formatoImpressaoDacte) { 
			case '': 
			case '1': 
				return '1-Retrato'; 
			case '2': 
				return '2-Paisagem'; 
			default: 
				return null; 
		} 
	} 

	static setFormatoImpressaoDacte(String? formatoImpressaoDacte) { 
		switch (formatoImpressaoDacte) { 
			case '1-Retrato': 
				return '1'; 
			case '2-Paisagem': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getTipoEmissao(String? tipoEmissao) { 
		switch (tipoEmissao) { 
			case '': 
			case '1': 
				return '1 - Normal'; 
			case '4': 
				return '4-EPEC pela SVC'; 
			case '5': 
				return '5 - Contingência FSDA'; 
			case '7': 
				return '7 - Autorização pela SVC-RS'; 
			case '8': 
				return '8 - Autorização pela SVC-SP'; 
			default: 
				return null; 
		} 
	} 

	static setTipoEmissao(String? tipoEmissao) { 
		switch (tipoEmissao) { 
			case '1 - Normal': 
				return '1'; 
			case '4-EPEC pela SVC': 
				return '4'; 
			case '5 - Contingência FSDA': 
				return '5'; 
			case '7 - Autorização pela SVC-RS': 
				return '7'; 
			case '8 - Autorização pela SVC-SP': 
				return '8'; 
			default: 
				return null; 
		} 
	}

	static getAmbiente(String? ambiente) { 
		switch (ambiente) { 
			case '': 
			case '1': 
				return '1-Produção'; 
			case '2': 
				return '2-Homologação'; 
			default: 
				return null; 
		} 
	} 

	static setAmbiente(String? ambiente) { 
		switch (ambiente) { 
			case '1-Produção': 
				return '1'; 
			case '2-Homologação': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getTipoCte(String? tipoCte) { 
		switch (tipoCte) { 
			case '': 
			case '0': 
				return '0 - CT-e Normal'; 
			case '1': 
				return '1 - CT-e de Complemento de Valores'; 
			case '2': 
				return '2 - CT-e de Anulação'; 
			case '3': 
				return '3 - CT-e Substituto'; 
			default: 
				return null; 
		} 
	} 

	static setTipoCte(String? tipoCte) { 
		switch (tipoCte) { 
			case '0 - CT-e Normal': 
				return '0'; 
			case '1 - CT-e de Complemento de Valores': 
				return '1'; 
			case '2 - CT-e de Anulação': 
				return '2'; 
			case '3 - CT-e Substituto': 
				return '3'; 
			default: 
				return null; 
		} 
	}

	static getProcessoEmissao(String? processoEmissao) { 
		switch (processoEmissao) { 
			case '': 
			case '0': 
				return '0 - emissão de CT-e com aplicativo do contribuinte; 1 - emissão de CT-e avulsa pelo Fisco; 2 - emissão de CT-e avulsa'; 
			case 'p': 
				return 'pelo contribuinte com seu certificado digital'; 
			case 'a': 
				return 'através do site do Fisco; 3 - emissão CT-e pelo contribuinte com aplicativo fornecido pelo Fisco'; 
			default: 
				return null; 
		} 
	} 

	static setProcessoEmissao(String? processoEmissao) { 
		switch (processoEmissao) { 
			case '0 - emissão de CT-e com aplicativo do contribuinte; 1 - emissão de CT-e avulsa pelo Fisco; 2 - emissão de CT-e avulsa': 
				return '0'; 
			case 'pelo contribuinte com seu certificado digital': 
				return 'p'; 
			case 'através do site do Fisco; 3 - emissão CT-e pelo contribuinte com aplicativo fornecido pelo Fisco': 
				return 'a'; 
			default: 
				return null; 
		} 
	}

	static getUfEnvio(String? ufEnvio) { 
		switch (ufEnvio) { 
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

	static setUfEnvio(String? ufEnvio) { 
		switch (ufEnvio) { 
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

	static getModal(String? modal) { 
		switch (modal) { 
			case '': 
			case '0': 
				return '01-Rodoviário'; 
			case '1': 
				return '02-Aéreo'; 
			case '2': 
				return '03-Aquaviário'; 
			case '3': 
				return '04-Ferroviário'; 
			case '4': 
				return '05-Dutoviário'; 
			case '5': 
				return '06-Multimodal'; 
			default: 
				return null; 
		} 
	} 

	static setModal(String? modal) { 
		switch (modal) { 
			case '01-Rodoviário': 
				return '0'; 
			case '02-Aéreo': 
				return '1'; 
			case '03-Aquaviário': 
				return '2'; 
			case '04-Ferroviário': 
				return '3'; 
			case '05-Dutoviário': 
				return '4'; 
			case '06-Multimodal': 
				return '5'; 
			default: 
				return null; 
		} 
	}

	static getTipoServico(String? tipoServico) { 
		switch (tipoServico) { 
			case '': 
			case '0': 
				return '0 - Normal'; 
			case '1': 
				return '1 - Subcontratação'; 
			case '2': 
				return '2 - Redespacho'; 
			case '3': 
				return '3 - Redespacho Intermediário'; 
			case '4': 
				return '4 - Serviço Vinculado a Multimodal'; 
			default: 
				return null; 
		} 
	} 

	static setTipoServico(String? tipoServico) { 
		switch (tipoServico) { 
			case '0 - Normal': 
				return '0'; 
			case '1 - Subcontratação': 
				return '1'; 
			case '2 - Redespacho': 
				return '2'; 
			case '3 - Redespacho Intermediário': 
				return '3'; 
			case '4 - Serviço Vinculado a Multimodal': 
				return '4'; 
			default: 
				return null; 
		} 
	}

	static getUfIniPrestacao(String? ufIniPrestacao) { 
		switch (ufIniPrestacao) { 
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

	static setUfIniPrestacao(String? ufIniPrestacao) { 
		switch (ufIniPrestacao) { 
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

	static getUfFimPrestacao(String? ufFimPrestacao) { 
		switch (ufFimPrestacao) { 
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

	static setUfFimPrestacao(String? ufFimPrestacao) { 
		switch (ufFimPrestacao) { 
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

	static getRetira(String? retira) { 
		switch (retira) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setRetira(String? retira) { 
		switch (retira) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getTomador(String? tomador) { 
		switch (tomador) { 
			case '': 
			case '0': 
				return '0-Remetente'; 
			case '1': 
				return '1-Expedidor'; 
			case '2': 
				return '2-Recebedor'; 
			case '3': 
				return '3-Destinatário'; 
			case '4': 
				return '4-Outros'; 
			default: 
				return null; 
		} 
	} 

	static setTomador(String? tomador) { 
		switch (tomador) { 
			case '0-Remetente': 
				return '0'; 
			case '1-Expedidor': 
				return '1'; 
			case '2-Recebedor': 
				return '2'; 
			case '3-Destinatário': 
				return '3'; 
			case '4-Outros': 
				return '4'; 
			default: 
				return null; 
		} 
	}

	static getEntregaTipoPeriodo(String? entregaTipoPeriodo) { 
		switch (entregaTipoPeriodo) { 
			case '': 
			case '0': 
				return '0-Sem data definida'; 
			case '1': 
				return '1-Na data'; 
			case '2': 
				return '2-Até a data'; 
			case '3': 
				return '3-A partir da data'; 
			case '4': 
				return '4-No período'; 
			default: 
				return null; 
		} 
	} 

	static setEntregaTipoPeriodo(String? entregaTipoPeriodo) { 
		switch (entregaTipoPeriodo) { 
			case '0-Sem data definida': 
				return '0'; 
			case '1-Na data': 
				return '1'; 
			case '2-Até a data': 
				return '2'; 
			case '3-A partir da data': 
				return '3'; 
			case '4-No período': 
				return '4'; 
			default: 
				return null; 
		} 
	}

	static getEntregaTipoHora(String? entregaTipoHora) { 
		switch (entregaTipoHora) { 
			case '': 
			case '0': 
				return '0-Sem hora definida'; 
			case '1': 
				return '1-No horário'; 
			case '2': 
				return '2-Até o horário'; 
			case '3': 
				return '3-A partir do horário'; 
			case '4': 
				return '4-No intervalo de tempo'; 
			default: 
				return null; 
		} 
	} 

	static setEntregaTipoHora(String? entregaTipoHora) { 
		switch (entregaTipoHora) { 
			case '0-Sem hora definida': 
				return '0'; 
			case '1-No horário': 
				return '1'; 
			case '2-Até o horário': 
				return '2'; 
			case '3-A partir do horário': 
				return '3'; 
			case '4-No intervalo de tempo': 
				return '4'; 
			default: 
				return null; 
		} 
	}

	static getSimplesNacionalIndicador(String? simplesNacionalIndicador) { 
		switch (simplesNacionalIndicador) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setSimplesNacionalIndicador(String? simplesNacionalIndicador) { 
		switch (simplesNacionalIndicador) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}