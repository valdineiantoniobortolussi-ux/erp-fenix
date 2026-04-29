class NfeCabecalhoDomain {
	NfeCabecalhoDomain._();

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

	static getCodigoModelo(String? codigoModelo) { 
		switch (codigoModelo) { 
			case '': 
			case '55': 
				return '55'; 
			default: 
				return null; 
		} 
	} 

	static setCodigoModelo(String? codigoModelo) { 
		switch (codigoModelo) { 
			case '55': 
				return '55'; 
			default: 
				return null; 
		} 
	}

	static getTipoOperacao(String? tipoOperacao) { 
		switch (tipoOperacao) { 
			case '': 
			case '0': 
				return '0=Entrada'; 
			case '1': 
				return '1=Saída'; 
			default: 
				return null; 
		} 
	} 

	static setTipoOperacao(String? tipoOperacao) { 
		switch (tipoOperacao) { 
			case '0=Entrada': 
				return '0'; 
			case '1=Saída': 
				return '1'; 
			default: 
				return null; 
		} 
	}

	static getLocalDestino(String? localDestino) { 
		switch (localDestino) { 
			case '': 
			case '1': 
				return '1=Operação interna'; 
			case '2': 
				return '2=Operação interestadual'; 
			case '3': 
				return '3=Operação com exterior'; 
			default: 
				return null; 
		} 
	} 

	static setLocalDestino(String? localDestino) { 
		switch (localDestino) { 
			case '1=Operação interna': 
				return '1'; 
			case '2=Operação interestadual': 
				return '2'; 
			case '3=Operação com exterior': 
				return '3'; 
			default: 
				return null; 
		} 
	}

	static getFormatoImpressaoDanfe(String? formatoImpressaoDanfe) { 
		switch (formatoImpressaoDanfe) { 
			case '': 
			case '0': 
				return '0=Sem geração de DANFE'; 
			case '1': 
				return '1=DANFE normal'; 
			case 'R': 
				return 'Retrato'; 
			case '2': 
				return '2=DANFE normal'; 
			case 'P': 
				return 'Paisagem'; 
			case '3': 
				return '3=DANFE Simplificado'; 
			default: 
				return null; 
		} 
	} 

	static setFormatoImpressaoDanfe(String? formatoImpressaoDanfe) { 
		switch (formatoImpressaoDanfe) { 
			case '0=Sem geração de DANFE': 
				return '0'; 
			case '1=DANFE normal': 
				return '1'; 
			case 'Retrato': 
				return 'R'; 
			case '2=DANFE normal': 
				return '2'; 
			case 'Paisagem': 
				return 'P'; 
			case '3=DANFE Simplificado': 
				return '3'; 
			default: 
				return null; 
		} 
	}

	static getTipoEmissao(String? tipoEmissao) { 
		switch (tipoEmissao) { 
			case '': 
			case '1': 
				return '1=Emissão normal'; 
			case '2': 
				return '2=Contingência FS-IA'; 
			case '4': 
				return '4=Contingência EPEC'; 
			case '5': 
				return '5=Contingência FS-DA'; 
			case '6': 
				return '6=Contingência SVC-AN'; 
			case '7': 
				return '7=Contingência SVC-RS'; 
			default: 
				return null; 
		} 
	} 

	static setTipoEmissao(String? tipoEmissao) { 
		switch (tipoEmissao) { 
			case '1=Emissão normal': 
				return '1'; 
			case '2=Contingência FS-IA': 
				return '2'; 
			case '4=Contingência EPEC': 
				return '4'; 
			case '5=Contingência FS-DA': 
				return '5'; 
			case '6=Contingência SVC-AN': 
				return '6'; 
			case '7=Contingência SVC-RS': 
				return '7'; 
			default: 
				return null; 
		} 
	}

	static getAmbiente(String? ambiente) { 
		switch (ambiente) { 
			case '': 
			case '1': 
				return '1=Produção'; 
			case '2': 
				return '2=Homologação'; 
			default: 
				return null; 
		} 
	} 

	static setAmbiente(String? ambiente) { 
		switch (ambiente) { 
			case '1=Produção': 
				return '1'; 
			case '2=Homologação': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getFinalidadeEmissao(String? finalidadeEmissao) { 
		switch (finalidadeEmissao) { 
			case '': 
			case '1': 
				return '1=NF-e normal'; 
			case '2': 
				return '2=NF-e complementar'; 
			case '3': 
				return '3=NF-e de ajuste'; 
			case '4': 
				return '4=Devolução de mercadoria'; 
			default: 
				return null; 
		} 
	} 

	static setFinalidadeEmissao(String? finalidadeEmissao) { 
		switch (finalidadeEmissao) { 
			case '1=NF-e normal': 
				return '1'; 
			case '2=NF-e complementar': 
				return '2'; 
			case '3=NF-e de ajuste': 
				return '3'; 
			case '4=Devolução de mercadoria': 
				return '4'; 
			default: 
				return null; 
		} 
	}

	static getConsumidorOperacao(String? consumidorOperacao) { 
		switch (consumidorOperacao) { 
			case '': 
			case '0': 
				return '0=Normal'; 
			case '1': 
				return '1=Consumidor final'; 
			default: 
				return null; 
		} 
	} 

	static setConsumidorOperacao(String? consumidorOperacao) { 
		switch (consumidorOperacao) { 
			case '0=Normal': 
				return '0'; 
			case '1=Consumidor final': 
				return '1'; 
			default: 
				return null; 
		} 
	}

	static getConsumidorPresenca(String? consumidorPresenca) { 
		switch (consumidorPresenca) { 
			case '': 
			case '0': 
				return '0=Não se aplica'; 
			case '1': 
				return '1=Operação presencial'; 
			case '2': 
				return '2=Operação não presencial'; 
			case 'p': 
				return 'pela Internet'; 
			case '3': 
				return '3=Operação não presencial'; 
			case 'T': 
				return 'Teleatendimento'; 
			case '4': 
				return '4=NFC-e em operação com entrega a domicílio'; 
			case '5': 
				return '5=Operação presencial'; 
			case 'f': 
				return 'fora do estabelecimento'; 
			case '9': 
				return '9=Operação não presencial'; 
			case 'o': 
				return 'outros'; 
			default: 
				return null; 
		} 
	} 

	static setConsumidorPresenca(String? consumidorPresenca) { 
		switch (consumidorPresenca) { 
			case '0=Não se aplica': 
				return '0'; 
			case '1=Operação presencial': 
				return '1'; 
			case '2=Operação não presencial': 
				return '2'; 
			case 'pela Internet': 
				return 'p'; 
			case '3=Operação não presencial': 
				return '3'; 
			case 'Teleatendimento': 
				return 'T'; 
			case '4=NFC-e em operação com entrega a domicílio': 
				return '4'; 
			case '5=Operação presencial': 
				return '5'; 
			case 'fora do estabelecimento': 
				return 'f'; 
			case '9=Operação não presencial': 
				return '9'; 
			case 'outros': 
				return 'o'; 
			default: 
				return null; 
		} 
	}

	static getProcessoEmissao(String? processoEmissao) { 
		switch (processoEmissao) { 
			case '': 
			case '0': 
				return '0=Emissão de NF-e com aplicativo do contribuinte'; 
			case '1': 
				return '1=Emissão de NF-e avulsa pelo Fisco'; 
			case '2': 
				return '2=Emissão de NF-e avulsa'; 
			case 'p': 
				return 'pelo contribuinte com seu certificado digital'; 
			case 'a': 
				return 'através do site do Fisco'; 
			case '3': 
				return '3=Emissão NF-e pelo contribuinte com aplicativo fornecido pelo Fisco'; 
			default: 
				return null; 
		} 
	} 

	static setProcessoEmissao(String? processoEmissao) { 
		switch (processoEmissao) { 
			case '0=Emissão de NF-e com aplicativo do contribuinte': 
				return '0'; 
			case '1=Emissão de NF-e avulsa pelo Fisco': 
				return '1'; 
			case '2=Emissão de NF-e avulsa': 
				return '2'; 
			case 'pelo contribuinte com seu certificado digital': 
				return 'p'; 
			case 'através do site do Fisco': 
				return 'a'; 
			case '3=Emissão NF-e pelo contribuinte com aplicativo fornecido pelo Fisco': 
				return '3'; 
			default: 
				return null; 
		} 
	}

	static getRegimeEspecialTributacao(String? regimeEspecialTributacao) { 
		switch (regimeEspecialTributacao) { 
			case '': 
			case '0': 
				return '0=Emissão de NF-e com aplicativo do contribuinte'; 
			case '1': 
				return '1=Microempresa Municipal'; 
			case '2': 
				return '2=Estimativa'; 
			case '3': 
				return '3=Sociedade de Profissionais'; 
			case '4': 
				return '4=Cooperativa'; 
			case '5': 
				return '5=Microempresário Individual (MEI)'; 
			case '6': 
				return '6=Microempresário e Empresa de Pequeno Porte'; 
			default: 
				return null; 
		} 
	} 

	static setRegimeEspecialTributacao(String? regimeEspecialTributacao) { 
		switch (regimeEspecialTributacao) { 
			case '0=Emissão de NF-e com aplicativo do contribuinte': 
				return '0'; 
			case '1=Microempresa Municipal': 
				return '1'; 
			case '2=Estimativa': 
				return '2'; 
			case '3=Sociedade de Profissionais': 
				return '3'; 
			case '4=Cooperativa': 
				return '4'; 
			case '5=Microempresário Individual (MEI)': 
				return '5'; 
			case '6=Microempresário e Empresa de Pequeno Porte': 
				return '6'; 
			default: 
				return null; 
		} 
	}

	static getComexUfEmbarque(String? comexUfEmbarque) { 
		switch (comexUfEmbarque) { 
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

	static setComexUfEmbarque(String? comexUfEmbarque) { 
		switch (comexUfEmbarque) { 
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

	static getStatusNota(String? statusNota) { 
		switch (statusNota) { 
			case '': 
			case '1': 
				return '1-Salva'; 
			case '2': 
				return '2-Validada'; 
			case '3': 
				return '3-Assinada'; 
			case '4': 
				return '4-Autorizada'; 
			case '5': 
				return '5-Inutilizada'; 
			case '6': 
				return '6-Cancelada'; 
			default: 
				return null; 
		} 
	} 

	static setStatusNota(String? statusNota) { 
		switch (statusNota) { 
			case '1-Salva': 
				return '1'; 
			case '2-Validada': 
				return '2'; 
			case '3-Assinada': 
				return '3'; 
			case '4-Autorizada': 
				return '4'; 
			case '5-Inutilizada': 
				return '5'; 
			case '6-Cancelada': 
				return '6'; 
			default: 
				return null; 
		} 
	}

}