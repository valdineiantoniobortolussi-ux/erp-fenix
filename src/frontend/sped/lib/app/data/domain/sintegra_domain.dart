class SintegraDomain {
	SintegraDomain._();

	static getCodigoConvenio(String? codigoConvenio) { 
		switch (codigoConvenio) { 
			case '': 
			case '5': 
				return '57/95'; 
			default: 
				return null; 
		} 
	} 

	static setCodigoConvenio(String? codigoConvenio) { 
		switch (codigoConvenio) { 
			case '57/95': 
				return '5'; 
			default: 
				return null; 
		} 
	}

	static getInventario(String? inventario) { 
		switch (inventario) { 
			case '': 
			case '0': 
				return '00-Sem Inventário'; 
			case '1': 
				return '01-No final do período'; 
			case '2': 
				return '02-Na mudança da forma de tributação da mercadoria (ICMS)'; 
			case '3': 
				return '03-Na solicitação da baixa cadastral paralisação temporária e outras situações'; 
			case '4': 
				return '04-Na alteração do regime de pagamento - condição do contribuite'; 
			case '5': 
				return '05-Por determinação dos fiscos'; 
			default: 
				return null; 
		} 
	} 

	static setInventario(String? inventario) { 
		switch (inventario) { 
			case '00-Sem Inventário': 
				return '0'; 
			case '01-No final do período': 
				return '1'; 
			case '02-Na mudança da forma de tributação da mercadoria (ICMS)': 
				return '2'; 
			case '03-Na solicitação da baixa cadastral paralisação temporária e outras situações': 
				return '3'; 
			case '04-Na alteração do regime de pagamento - condição do contribuite': 
				return '4'; 
			case '05-Por determinação dos fiscos': 
				return '5'; 
			default: 
				return null; 
		} 
	}

}