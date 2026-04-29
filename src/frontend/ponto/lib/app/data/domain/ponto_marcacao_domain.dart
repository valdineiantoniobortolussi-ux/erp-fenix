class PontoMarcacaoDomain {
	PontoMarcacaoDomain._();

	static getTipoMarcacao(String? tipoMarcacao) { 
		switch (tipoMarcacao) { 
			case '': 
			case 'E': 
				return 'Entrada'; 
			case 'S': 
				return 'Saída'; 
			case 'D': 
				return 'Desconsiderar'; 
			default: 
				return null; 
		} 
	} 

	static setTipoMarcacao(String? tipoMarcacao) { 
		switch (tipoMarcacao) { 
			case 'Entrada': 
				return 'E'; 
			case 'Saída': 
				return 'S'; 
			case 'Desconsiderar': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

	static getTipoRegistro(String? tipoRegistro) { 
		switch (tipoRegistro) { 
			case '': 
			case '0': 
				return ''; 
			default: 
				return null; 
		} 
	} 

	static setTipoRegistro(String? tipoRegistro) { 
		switch (tipoRegistro) { 
			case '': 
				return '0'; 
			default: 
				return null; 
		} 
	}

	static getParEntradaSaida(String? parEntradaSaida) { 
		switch (parEntradaSaida) { 
			case '': 
			case '0': 
				return 'AAA'; 
			case '1': 
				return 'BBB'; 
			case '2': 
				return 'CCC'; 
			default: 
				return null; 
		} 
	} 

	static setParEntradaSaida(String? parEntradaSaida) { 
		switch (parEntradaSaida) { 
			case 'AAA': 
				return '0'; 
			case 'BBB': 
				return '1'; 
			case 'CCC': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}