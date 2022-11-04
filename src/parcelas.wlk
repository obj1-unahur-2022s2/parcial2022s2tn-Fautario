/*
 * El método seAsociaBienCon() no quedo bien. Tiene un if que no debería estar y que se puede solucionar herencia o polimorficamente con los objetos de parcela que creaste
 * Con Herencia deberías haber creado dos sub clases de Parcela y dentro de esas clases sobreescribir el método seAsociaBienCon() porque convenia dejarlo como asbstracto.
 * La solución polimórfica es delegar el tipo el tipo de parcela. seAsociaBienCon(unaParcela, unaPlanta)
 * Invertí la lógica del plantar para no usar else. Recordá que lanzar una excepcion corta la flujo del método
 */
import plantas.*

class Parcela {
	const ancho
	const largo
	var horasSolPorDia
	const plantasQueTiene = []
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
		if (not self.puedePlantar(unaPlanta)) {
			self.error("La planta no puede ser agregada a esta parcela")
		}
		plantasQueTiene.add(unaPlanta)
	}
	method puedePlantar(planta) = plantasQueTiene.size()+1 <= self.cantidadMaximaPlantas() and horasSolPorDia <= planta.horasSolQueTolera()+2
	method seAsociaBienCon(unaPlanta) {
		return tipoParcela.seAsociaBienCon(self, unaPlanta)
	}
	method porcentajePlantasBienAsociadas() = (self.plantasBienAsociadas().size() / plantasQueTiene.size()) * 100
	method plantasBienAsociadas() = plantasQueTiene.filter({p => p.seAsociaBien(self)})
	
}

object ecologica {
	method seAsociaBienCon(unaParcela, unaPlanta){
		return not unaParcela.tieneComplicaciones() and unaPlanta.esParcelaIdeal(unaParcela)
	}
}
object industrial {
	method seAsociaBienCon(unaParcela, unaPlanta){
		return unaParcela.plantasQueTiene().size() <= 2 and unaPlanta.esFuerte()
	}
}