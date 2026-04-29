class NfseCabecalhoDomain {
	NfseCabecalhoDomain._();

	static getNaturezaOperacao(String? naturezaOperacao) { 
		switch (naturezaOperacao) { 
			case '': 
			case '1': 
				return '1=Tributação no município'; 
			case '2': 
				return '2=Tributação fora do município'; 
			case '3': 
				return '3=Isenção'; 
			case '4': 
				return '4=Imune'; 
			case '5': 
				return '5=Exigibilidade suspensa por decisão judicial'; 
			case '6': 
				return '6=Exigibilidade suspensa por procedimento administrativo'; 
			default: 
				return null; 
		} 
	} 

	static setNaturezaOperacao(String? naturezaOperacao) { 
		switch (naturezaOperacao) { 
			case '1=Tributação no município': 
				return '1'; 
			case '2=Tributação fora do município': 
				return '2'; 
			case '3=Isenção': 
				return '3'; 
			case '4=Imune': 
				return '4'; 
			case '5=Exigibilidade suspensa por decisão judicial': 
				return '5'; 
			case '6=Exigibilidade suspensa por procedimento administrativo': 
				return '6'; 
			default: 
				return null; 
		} 
	}

	static getRegimeEspecialTributacao(String? regimeEspecialTributacao) { 
		switch (regimeEspecialTributacao) { 
			case '': 
			case '1': 
				return '1=Microempresa Municipal'; 
			case '2': 
				return '2=Estimativa'; 
			case '3': 
				return '3=Sociedade de Profissionais'; 
			case '4': 
				return '4=Cooperativa'; 
			default: 
				return null; 
		} 
	} 

	static setRegimeEspecialTributacao(String? regimeEspecialTributacao) { 
		switch (regimeEspecialTributacao) { 
			case '1=Microempresa Municipal': 
				return '1'; 
			case '2=Estimativa': 
				return '2'; 
			case '3=Sociedade de Profissionais': 
				return '3'; 
			case '4=Cooperativa': 
				return '4'; 
			default: 
				return null; 
		} 
	}

	static getOptanteSimplesNacional(String? optanteSimplesNacional) { 
		switch (optanteSimplesNacional) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setOptanteSimplesNacional(String? optanteSimplesNacional) { 
		switch (optanteSimplesNacional) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getIncentivadorCultural(String? incentivadorCultural) { 
		switch (incentivadorCultural) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setIncentivadorCultural(String? incentivadorCultural) { 
		switch (incentivadorCultural) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getTipoRps(String? tipoRps) { 
		switch (tipoRps) { 
			case '': 
			case '1': 
				return '1=Recibo Provisório de Serviços'; 
			case '2': 
				return '2=RPS  Nota Fiscal Conjugada (Mista)'; 
			case '3': 
				return '3=Cupom'; 
			default: 
				return null; 
		} 
	} 

	static setTipoRps(String? tipoRps) { 
		switch (tipoRps) { 
			case '1=Recibo Provisório de Serviços': 
				return '1'; 
			case '2=RPS  Nota Fiscal Conjugada (Mista)': 
				return '2'; 
			case '3=Cupom': 
				return '3'; 
			default: 
				return null; 
		} 
	}

}