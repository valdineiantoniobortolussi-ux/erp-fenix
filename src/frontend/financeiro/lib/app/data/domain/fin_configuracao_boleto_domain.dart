class FinConfiguracaoBoletoDomain {
	FinConfiguracaoBoletoDomain._();

	static getLayoutRemessa(String? layoutRemessa) { 
		switch (layoutRemessa) { 
			case '': 
			case '0': 
				return 'CNAB 240'; 
			case '1': 
				return 'CNAB 400'; 
			default: 
				return null; 
		} 
	} 

	static setLayoutRemessa(String? layoutRemessa) { 
		switch (layoutRemessa) { 
			case 'CNAB 240': 
				return '0'; 
			case 'CNAB 400': 
				return '1'; 
			default: 
				return null; 
		} 
	}

	static getAceite(String? aceite) { 
		switch (aceite) { 
			case '': 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	} 

	static setAceite(String? aceite) { 
		switch (aceite) { 
			case 'S': 
				return 'S'; 
			case 'N': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getEspecie(String? especie) { 
		switch (especie) { 
			case '': 
			case '0': 
				return 'DM-Duplicata Mercantil'; 
			case '1': 
				return 'DS-Duplicata de Serviços'; 
			case '2': 
				return 'RC-Recibo'; 
			case '3': 
				return 'NP-Nota Promissória'; 
			default: 
				return null; 
		} 
	} 

	static setEspecie(String? especie) { 
		switch (especie) { 
			case 'DM-Duplicata Mercantil': 
				return '0'; 
			case 'DS-Duplicata de Serviços': 
				return '1'; 
			case 'RC-Recibo': 
				return '2'; 
			case 'NP-Nota Promissória': 
				return '3'; 
			default: 
				return null; 
		} 
	}

}