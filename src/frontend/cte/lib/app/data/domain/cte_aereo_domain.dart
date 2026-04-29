class CteAereoDomain {
	CteAereoDomain._();

	static getTarifaClasse(String? tarifaClasse) { 
		switch (tarifaClasse) { 
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

	static setTarifaClasse(String? tarifaClasse) { 
		switch (tarifaClasse) { 
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

	static getCargaInformacaoManuseio(String? cargaInformacaoManuseio) { 
		switch (cargaInformacaoManuseio) { 
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

	static setCargaInformacaoManuseio(String? cargaInformacaoManuseio) { 
		switch (cargaInformacaoManuseio) { 
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

	static getCargaEspecial(String? cargaEspecial) { 
		switch (cargaEspecial) { 
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

	static setCargaEspecial(String? cargaEspecial) { 
		switch (cargaEspecial) { 
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