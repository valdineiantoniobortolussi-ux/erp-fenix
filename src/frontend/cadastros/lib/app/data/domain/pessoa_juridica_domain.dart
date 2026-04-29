class PessoaJuridicaDomain {
	PessoaJuridicaDomain._();

	static getTipoRegime(String? tipoRegime) { 
		switch (tipoRegime) { 
			case '': 
			case '1': 
				return '1-Lucro Real'; 
			case '2': 
				return '2-Lucro Presumido'; 
			case '3': 
				return '3-Simples Nacional'; 
			default: 
				return null; 
		} 
	} 

	static setTipoRegime(String? tipoRegime) { 
		switch (tipoRegime) { 
			case '1-Lucro Real': 
				return '1'; 
			case '2-Lucro Presumido': 
				return '2'; 
			case '3-Simples Nacional': 
				return '3'; 
			default: 
				return null; 
		} 
	}

	static getCrt(String? crt) { 
		switch (crt) { 
			case '': 
			case '1': 
				return '1-Simples Nacional'; 
			case '2': 
				return '2-Simples Nacional-Excesso'; 
			case '3': 
				return '3-Regime Normal'; 
			default: 
				return null; 
		} 
	} 

	static setCrt(String? crt) { 
		switch (crt) { 
			case '1-Simples Nacional': 
				return '1'; 
			case '2-Simples Nacional-Excesso': 
				return '2'; 
			case '3-Regime Normal': 
				return '3'; 
			default: 
				return null; 
		} 
	}

}