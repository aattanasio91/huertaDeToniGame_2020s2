import wollok.game.*
import toni.*
import pachamama.*
import mercado.*
import configuraciones.*

class Planta {
	var property position
	
	const property tipo = "Planta"
	
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
	
	override method valor(){ 
		if(pachamama.estaAgradecida()){
			return 180
		}
		else {return 150}	}
	
	override method regar(){
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
	var property estadoEvolucion = 0
	var property imagenes = ["trigo_0.png", "trigo_1.png", "trigo_2.png", "trigo_3.png"]
	
	method image() {
		return imagenes.get(estadoEvolucion)
	}

	method pachaAgradecida(){
		var valor = 0
		if(pachamama.estaAgradecida()){
			valor = 1
		}
		return 0
	}
		
	override method regar(){
		if(pachamama.estaAgradecida()){
			self.estadoEvolucion((self.estadoEvolucion() + 2).min(3))
		}
		else{
			self.estadoEvolucion((self.estadoEvolucion() + 1).min(3))
		}
	}
	
	override method estaListaParaCosechar(){
		return self.estadoEvolucion() >= 2
	}
	
	override method valor(){
		var valor = 0
		if(self.estadoEvolucion() == 2){
			valor = 100
		}
		else if(self.estadoEvolucion() == 3){
			valor = 200
		}
		return valor
	}
	
}

class Tomaco inherits Planta{
	var property image = "tomaco_ok.png"
	
	override method regar(){}
	
	override method estaListaParaCosechar(){
		return not pachamama.estaAgradecida() 
	}
	
	override method valor(){
		return 80
	}
	
	override method aptoCeliaco() = true
	
	method image() {
		var imagen = "" 
		if (pachamama.estaAgradecida()) {
			 imagen = "tomaco_podrido.png"
		}
		else {
			imagen = "tomaco_ok.png"
		}
		return imagen
	}	
}