class FrotaVeiculoDomain {
	FrotaVeiculoDomain._();

	static getIpvaMesVencimento(String? ipvaMesVencimento) { 
		switch (ipvaMesVencimento) { 
			case '': 
			case '0': 
				return '01'; 
			case '1': 
				return '02'; 
			case '2': 
				return '03'; 
			case '3': 
				return '04'; 
			case '4': 
				return '05'; 
			case '5': 
				return '06'; 
			case '6': 
				return '07'; 
			case '7': 
				return '08'; 
			case '8': 
				return '09'; 
			case '9': 
				return '10'; 
			case '10': 
				return '11'; 
			case '11': 
				return '12'; 
			default: 
				return null; 
		} 
	} 

	static setIpvaMesVencimento(String? ipvaMesVencimento) { 
		switch (ipvaMesVencimento) { 
			case '01': 
				return '0'; 
			case '02': 
				return '1'; 
			case '03': 
				return '2'; 
			case '04': 
				return '3'; 
			case '05': 
				return '4'; 
			case '06': 
				return '5'; 
			case '07': 
				return '6'; 
			case '08': 
				return '7'; 
			case '09': 
				return '8'; 
			case '10': 
				return '9'; 
			case '11': 
				return '10'; 
			case '12': 
				return '11'; 
			default: 
				return null; 
		} 
	}

	static getDpvatMesVencimento(String? dpvatMesVencimento) { 
		switch (dpvatMesVencimento) { 
			case '': 
			case '0': 
				return '01'; 
			case '1': 
				return '02'; 
			case '2': 
				return '03'; 
			case '3': 
				return '04'; 
			case '4': 
				return '05'; 
			case '5': 
				return '06'; 
			case '6': 
				return '07'; 
			case '7': 
				return '08'; 
			case '8': 
				return '09'; 
			case '9': 
				return '10'; 
			case '10': 
				return '11'; 
			case '11': 
				return '12'; 
			default: 
				return null; 
		} 
	} 

	static setDpvatMesVencimento(String? dpvatMesVencimento) { 
		switch (dpvatMesVencimento) { 
			case '01': 
				return '0'; 
			case '02': 
				return '1'; 
			case '03': 
				return '2'; 
			case '04': 
				return '3'; 
			case '05': 
				return '4'; 
			case '06': 
				return '5'; 
			case '07': 
				return '6'; 
			case '08': 
				return '7'; 
			case '09': 
				return '8'; 
			case '10': 
				return '9'; 
			case '11': 
				return '10'; 
			case '12': 
				return '11'; 
			default: 
				return null; 
		} 
	}

}