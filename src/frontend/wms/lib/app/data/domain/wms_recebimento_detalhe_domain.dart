class WmsRecebimentoDetalheDomain {
	WmsRecebimentoDetalheDomain._();

	static getDestino(String? destino) { 
		switch (destino) { 
			case '': 
			case 'A': 
				return 'Armazenamento'; 
			case 'E': 
				return 'Expedição'; 
			case 'P': 
				return 'Produção'; 
			default: 
				return null; 
		} 
	} 

	static setDestino(String? destino) { 
		switch (destino) { 
			case 'Armazenamento': 
				return 'A'; 
			case 'Expedição': 
				return 'E'; 
			case 'Produção': 
				return 'P'; 
			default: 
				return null; 
		} 
	}

}