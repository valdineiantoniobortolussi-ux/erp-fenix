class VendaOrcamentoCabecalhoDomain {
	VendaOrcamentoCabecalhoDomain._();

	static getTipoFrete(String? tipoFrete) { 
		switch (tipoFrete) { 
			case '': 
			case 'C': 
				return 'CIF'; 
			case 'F': 
				return 'FOB'; 
			default: 
				return null; 
		} 
	} 

	static setTipoFrete(String? tipoFrete) { 
		switch (tipoFrete) { 
			case 'CIF': 
				return 'C'; 
			case 'FOB': 
				return 'F'; 
			default: 
				return null; 
		} 
	}

}