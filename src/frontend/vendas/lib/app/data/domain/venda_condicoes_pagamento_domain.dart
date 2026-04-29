class VendaCondicoesPagamentoDomain {
	VendaCondicoesPagamentoDomain._();

	static getVistaPrazo(String? vistaPrazo) { 
		switch (vistaPrazo) { 
			case '': 
			case '0': 
				return 'A Vista'; 
			case '1': 
				return 'A Prazo'; 
			default: 
				return null; 
		} 
	} 

	static setVistaPrazo(String? vistaPrazo) { 
		switch (vistaPrazo) { 
			case 'A Vista': 
				return '0'; 
			case 'A Prazo': 
				return '1'; 
			default: 
				return null; 
		} 
	}

}