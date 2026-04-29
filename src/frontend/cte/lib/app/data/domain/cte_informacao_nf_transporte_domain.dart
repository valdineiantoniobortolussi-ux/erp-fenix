class CteInformacaoNfTransporteDomain {
	CteInformacaoNfTransporteDomain._();

	static getTipoUnidadeTransporte(String? tipoUnidadeTransporte) { 
		switch (tipoUnidadeTransporte) { 
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

	static setTipoUnidadeTransporte(String? tipoUnidadeTransporte) { 
		switch (tipoUnidadeTransporte) { 
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