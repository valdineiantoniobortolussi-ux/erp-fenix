class CompraPedidoDomain {
	CompraPedidoDomain._();

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

	static getFormaPagamento(String? formaPagamento) { 
		switch (formaPagamento) { 
			case '': 
			case 'V': 
				return 'Vista'; 
			case 'P': 
				return 'Prazo'; 
			case 'O': 
				return 'Outros'; 
			default: 
				return null; 
		} 
	} 

	static setFormaPagamento(String? formaPagamento) { 
		switch (formaPagamento) { 
			case 'Vista': 
				return 'V'; 
			case 'Prazo': 
				return 'P'; 
			case 'Outros': 
				return 'O'; 
			default: 
				return null; 
		} 
	}

}