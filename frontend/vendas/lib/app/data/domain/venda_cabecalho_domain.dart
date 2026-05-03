class VendaCabecalhoDomain {
	VendaCabecalhoDomain._();

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
			case '0': 
				return 'A Vista'; 
			case '1': 
				return 'A Prazo'; 
			case '2': 
				return 'Outros'; 
			default: 
				return null; 
		} 
	} 

	static setFormaPagamento(String? formaPagamento) { 
		switch (formaPagamento) { 
			case 'A Vista': 
				return '0'; 
			case 'A Prazo': 
				return '1'; 
			case 'Outros': 
				return '2'; 
			default: 
				return null; 
		} 
	}

	static getSituacao(String? situacao) { 
		switch (situacao) { 
			case '': 
			case '0': 
				return 'Digitação'; 
			case '1': 
				return 'Produção'; 
			case '2': 
				return 'Expedição'; 
			case '3': 
				return 'Faturado'; 
			case '4': 
				return 'Entregue'; 
			case '5': 
				return 'Devolução'; 
			default: 
				return null; 
		} 
	} 

	static setSituacao(String? situacao) { 
		switch (situacao) { 
			case 'Digitação': 
				return '0'; 
			case 'Produção': 
				return '1'; 
			case 'Expedição': 
				return '2'; 
			case 'Faturado': 
				return '3'; 
			case 'Entregue': 
				return '4'; 
			case 'Devolução': 
				return '5'; 
			default: 
				return null; 
		} 
	}

}