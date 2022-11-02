object inta {
	var parcelas = []
	
	method promedioPlantasPorParcela() = self.cantidadPlantasEnParcelas() / self.cantidadParcelas()
	method cantidadPlantasEnParcelas() = parcelas.sum({p => p.plantasQueTiene().size()})
	method cantidadParcelas() = parcelas.size()
	method parcelaMasSustentable() {
		self.parcelaMas4Plantas().max({p => p.porcentajePlantasBienAsociadas()})
	}
	
	method parcelaMas4Plantas() = parcelas.filter({p => p.plantasQueTiene().size() > 4})
}