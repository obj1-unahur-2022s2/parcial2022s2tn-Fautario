/*
 * Quizás la mejor opcion era tener el método seAsociaBien(unaPlanta) en la parcial y no tenerlo en la planta
 */
class Planta {
	const property anioObtencion
	var altura
	
	method altura() = altura
	method horasSolQueTolera()
	method esFuerte() = self.horasSolQueTolera() > 10
	method daNuevasSemillas() = self.esFuerte()
	method espacioOcupado()
	method esParcelaIdeal(unaParcela)
	method seAsociaBien(parcela) = parcela.seAsociaBienCon(self)
}

class Menta inherits Planta {
	
	override method horasSolQueTolera() = 6
	override method daNuevasSemillas() = super() or altura > 0.4
	override method espacioOcupado() = altura * 3
	override method esParcelaIdeal(unaParcela) = unaParcela.superficie() > 6
	
}

class Soja inherits Planta {
	
	override method horasSolQueTolera() {
		var horas
		
		if (altura < 0.5) {
			horas = 5
		} else if (altura > 1) {
			horas = 9
		} else horas = 7
		return horas
	}
	override method daNuevasSemillas() = super() or (anioObtencion > 2007 and altura > 1)
	override method espacioOcupado() = altura / 2
	override method esParcelaIdeal(unaParcela) = unaParcela.horasSolPorDia() == self.horasSolQueTolera()
	
}

class Quinoa inherits Planta {
	var horasSolQueTolera
	
	override method horasSolQueTolera() = horasSolQueTolera
	override method daNuevasSemillas() = super() or anioObtencion < 2005
	override method espacioOcupado() = 0.5
	override method esParcelaIdeal(unaParcela) = unaParcela.plantasQueTiene().all({p => p.altura() < 1.5})
	
}

class SojaTransgenica inherits Soja {
	
	override method daNuevasSemillas() = false
	override method esParcelaIdeal(unaParcela) = unaParcela.cantidadMaximaPlantas() == 1
}

class HierbaBuena inherits Menta {
	
	override method espacioOcupado() = super() * 2
}