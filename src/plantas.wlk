import wollok.game.*
import toni.*
import pachamama.*
import mercado.*
import configuraciones.*

class Planta {
	var property position
	
	method regar()
	
	method estaListaParaCosechar()
	
	method aptoCeliaco() = false
	
	method valor() = 0

		method serOfrenda() {
		game.removeVisual(self) 
		toni.plantasSembradas().remove(self)
	}
}

class Maiz inherits Planta{
	var property esAdulta = false
//	var property image = "maiz_bebe.png"
	
	override method valor(){ 
		if(pachamama.estaAgradecida()){
			return 180
		}
		else {return 150}	}
	
	override method regar(){
//		self.image("maiz_adulto.png")
		self.esAdulta(true)
	}
	
	override method estaListaParaCosechar(){
		return self.esAdulta()
	}
	
	override method aptoCeliaco() = true

	method image() {
		return if (esAdulta and pachamama.estaAgradecida()) { "maiz-gigante.jpg" } 
		else if (esAdulta) { "maiz_adulto.png" }
		else { "maiz_bebe.png" }
			
	}
}

class Trigo inherits Planta{
//	const property nombreImagen = ["trigo_0.png", "trigo_1.png", "trigo_2.png", "trigo_3.png"]
	var property estadoEvolucion = 0
//	var property image = "trigo_0.png"
	method image() {
	
	if (estadoEvolucion == 0) { return "trigo_0.png" }
	else if (estadoEvolucion == 1) { return "trigo_1.png"  }
	else if (estadoEvolucion == 2) { return "trigo_2.png"  }
	else { return "trigo_3.png"  }
	
	}
	
	override method regar(){
		if (pachamama.estaAgradecida()) { estadoEvolucion = (estadoEvolucion + 2).min(4) }
		else { estadoEvolucion = (estadoEvolucion + 1).min(4) }
	}
	
	override method estaListaParaCosechar(){
		return self.estadoEvolucion() >= 2
	}
	
	override method valor(){
		var valor = 0
		if(self.estadoEvolucion() % 4 == 2){
			valor = 100
		}
		else if(self.estadoEvolucion() % 4 == 3){
			valor = 200
		}
		return valor
	}
	
}

class Tomaco inherits Planta{
	var property image = "tomaco_ok.png"
	
	override method regar(){}
	
	override method estaListaParaCosechar(){
		return true
	}
	
	override method valor(){
		return 80
	}
	
	override method aptoCeliaco() = true


	
	method image() { 
		return if (pachamama.estaAgradecida()) { "tomaco_podrido.png" }
		else { "tomaco_ok.png" }			
	}
}