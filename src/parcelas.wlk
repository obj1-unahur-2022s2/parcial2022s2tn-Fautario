import plantas.*

class Parcela {
	const ancho
	const largo
	var horasSolPorDia
	var plantasQueTiene = []
	var tipoParcela
	
	method horasSolPorDia() = horasSolPorDia
	method plantasQueTiene() = plantasQueTiene
	method superficie() = ancho * largo
	method cantidadMaximaPlantas() {
		var cantidad
		
		if (ancho > largo) {
			cantidad = self.superficie() / 5
		} else {
			cantidad = self.superficie() / 3 + largo
		}
		return cantidad
	}
	method tieneComplicaciones() = plantasQueTiene.any({p => p.horasSolQueTolera() < horasSolPorDia})
	method plantar(unaPlanta) {
		if (self.puedePlantar(unaPlanta)) {
			plantasQueTiene.add(unaPlanta)
		} else {
			self.error("La planta no puede ser agregada a esta parcela")
		}
	}
	method puedePlantar(planta) = plantasQueTiene.size()+1 <= self.cantidadMaximaPlantas() and horasSolPorDia <= planta.horasSolQueTolera()+2
	method seAsociaBienCon(unaPlanta) {
		var seAsociaBien
		
		if (tipoParcela == ecologica) {
			seAsociaBien = not self.tieneComplicaciones() and unaPlanta.esParcelaIdeal(self)
		} else if (tipoParcela == industrial) {
			seAsociaBien = plantasQueTiene.size() <= 2 and unaPlanta.esFuerte()
		}
		return seAsociaBien
	}
	method porcentajePlantasBienAsociadas() = (self.plantasBienAsociadas().size() / plantasQueTiene.size()) * 100
	method plantasBienAsociadas() = plantasQueTiene.filter({p => p.seAsociaBien(self)})
}

object ecologica {}
object industrial {}