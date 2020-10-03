
object casaDePepeYJulian {

	var property viveres = 50
	var property montoReparaciones = 0 // Expresividad
	var cuenta = cuentaCorriente
	var estrategiaDeAhorro = full
	

	// ¿Lo guardo o lo calculo? - Problemas de pre-cálculo
	//	var viveresSuficientes = true
	method hayViveresSuficientes(){
		return viveres > 40
	}

	method necesitaReparaciones(){
		return montoReparaciones > 0
	}

	method enOrden(){
		return self.hayViveresSuficientes() and !self.necesitaReparaciones() 
	}

	method gastar(cantidad){
		cuenta.extraer(cantidad)
	}

	method estrategiaDeAhorro(estrategia){
		estrategiaDeAhorro = estrategia
	}
	
	method hacerMantenimiento(estrategia){
		estrategiaDeAhorro.mantenimiento(self)
	}
	
	method comprarViveres(cantidad, calidad) {
		self.gastar(cantidad * calidad)
		self.aumentarViveres(cantidad)
	}
	
	method dineroRestanteAlHacerReparaciones() {
		return cuenta.saldo() - montoReparaciones
	}
	
	method arreglarse() {
		self.gastar(montoReparaciones)
		montoReparaciones = 0
	}
	

	method romper(cantidad){
		montoReparaciones += cantidad
	}
	
	method aumentarViveres(cantidad) {
		viveres += cantidad
	}
	
	method saldo(){
		return cuenta.saldo()
	}

	method cuenta(_cuenta){
		cuenta = _cuenta
	}

	method viveres(cantidad){
		viveres = cantidad
	}

	method depositar(cantidad){
		cuenta.depositar(cantidad)
	}
}








object cuentaCorriente{

	var property saldo = 0

	method depositar(cantidad){
		saldo += cantidad
	}
	method extraer(cantidad){
		saldo -= cantidad
	}
}

object cuentaConGastos {

	var property saldo = 0
	var costoPorOperacion = 0

	method depositar(cantidad){
		saldo += cantidad - costoPorOperacion
	}
	method extraer(cantidad){
		saldo -= saldo
	}
	method costoPorOperacion(costo){
		costoPorOperacion = costo
	}
}

object cuentaCombinada {
	var primaria = cuentaConGastos
	var secundaria = cuentaCorriente

	method primaria(cuenta){
		primaria = cuenta
	}
	method secundaria(cuenta){
		secundaria = cuenta
	}
	
	
	method saldo(){
		return primaria.saldo() + secundaria.saldo()
	}
	
	
	method depositar(cantidad){
		primaria.depositar(cantidad)
	}
	
	method extraer(cantidad){
		if(primaria.saldo() >= cantidad){
			primaria.extraer(cantidad)
		} else {
			secundaria.extraer(cantidad)
		}
	}
}




object minimoEIndispensable {

	var calidad = 5

	method calidad(cantidad){
		calidad = cantidad
	}
	
	method mantenimiento(casa){	
		if(!casa.hayViveresSuficientes()){
			casa.comprarViveres(40 - casa.viveres(), calidad)
		}
	}
	
}


object full{
	const calidad = 5
	
	method mantenimiento(casa){ 
		self.comprarViveres(casa)
		self.reparar(casa)
	}
	
	method comprarViveres(casa) {
		const cantidad = self.viveresAComprar(casa)
		casa.comprarViveres(cantidad, calidad)
	}
	
	method viveresAComprar(casa) {
		return if (casa.enOrden()) {
			100 - casa.viveres()
		} else {
			40
		}
	}
	
	method reparar(casa) {
		if(casa.dineroRestanteAlHacerReparaciones() > 1000) {
			casa.arreglarse()
		}
	}
}


object casaPepita {
	method hayViveresSuficientes() { return false }
	method enOrden() { return true }
	method comprarViveres(cantidad, calidad) {  }
	method dineroRestanteAlHacerReparaciones() { return 0 }
	method arreglarse() { }
}
