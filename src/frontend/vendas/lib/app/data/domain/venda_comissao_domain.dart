class VendaComissaoDomain {
	VendaComissaoDomain._();

	static getTipoContabil(String? tipoContabil) { 
		switch (tipoContabil) { 
			case '': 
			case 'C': 
				return 'Crédito'; 
			case 'D': 
				return 'Débido'; 
			default: 
				return null; 
		} 
	} 

	static setTipoContabil(String? tipoContabil) { 
		switch (tipoContabil) { 
			case 'Crédito': 
				return 'C'; 
			case 'Débido': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

	static getSituacao(String? situacao) { 
		switch (situacao) { 
			case '': 
			case 'A': 
				return 'Aberto'; 
			case 'Q': 
				return 'Quitado'; 
			default: 
				return null; 
		} 
	} 

	static setSituacao(String? situacao) { 
		switch (situacao) { 
			case 'Aberto': 
				return 'A'; 
			case 'Quitado': 
				return 'Q'; 
			default: 
				return null; 
		} 
	}

}