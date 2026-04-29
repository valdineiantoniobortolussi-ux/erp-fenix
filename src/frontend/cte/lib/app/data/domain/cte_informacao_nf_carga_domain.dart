class CteInformacaoNfCargaDomain {
	CteInformacaoNfCargaDomain._();

	static getTipoUnidadeCarga(String? tipoUnidadeCarga) { 
		switch (tipoUnidadeCarga) { 
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

	static setTipoUnidadeCarga(String? tipoUnidadeCarga) { 
		switch (tipoUnidadeCarga) { 
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