import wollok.game.*
import plantas.*
import mercado.*
import configuraciones.*

object toni {
	const property image = "toni.png"
	var property position = game.at(3, 3)
	var property plantasSembradas = []
	var property plantasCosechadas = []
	var property posicionesDePlantas = [] 
	var property oro = 0
	const property tipo = "Persona"
	
	method moverArriba(){
		if(self.position().y() != game.height() - 1){
			self.position(self.position().up(1))
		}else{
			self.position(new Position(x=self.position().x(), y=0))
		}
	}
	
	method moverAbajo(){
		if(self.position().y() != 0){
			self.position(self.position().down(1))
		}else{
			self.position(new Position(x=self.position().x(), y=game.height() - 1))
		}
	}
	
	method moverIzq(){
		if(self.position().x() != 0){
			self.position(self.position().left(1))
		}else{
			self.position(new Position(x=game.width() - 1, y=self.position().y()))
		}
	}
	
	method moverDer(){
		if(self.position().x() != game.width() - 1){
			self.position(self.position().right(1))
		}else{
			self.position(new Position(x=0, y=self.position().y()))
		}		
	}
	
	method sembrar(unaPlanta){
		if(!posicionesDePlantas.contains(self.position())){
			plantasSembradas.add(unaPlanta)
			posicionesDePlantas.add(self.position())
			game.addVisualIn(unaPlanta, self.position())
		}else{
			self.error("Ya existe una planta en esta posicion")
		}
	}
	
	method regarLasPlantas(){
		plantasSembradas.forEach({planta => planta.regar()})
	}
	
	method regarPlanta(){
		game.colliders(self).forEach({planta => planta.regar()})
	}
	
	method plantasListasParaCosechar(){
		return plantasSembradas.filter({planta => planta.estaListaParaCosechar()})
	}
	
	method cosecharTodo(){
		
		self.plantasListasParaCosechar().forEach({planta => 
			self.position(planta.position())
			self.cosechar()
		})
		game.say(self,"Cosechadas " + plantasCosechadas.size().toString() + " plantas en total")
	}
	
	method cosechar(){
		if(game.colliders(self) != []){
			const planta = game.uniqueCollider(self)
			if(planta.estaListaParaCosechar()){
				plantasCosechadas.add(planta)
				game.removeVisual(planta)
				plantasSembradas.remove(planta)
				posicionesDePlantas.remove(self.position())
			}
			else{
				self.error("No está lista para cosechar")
			}
		}
		else{
			self.error("No se encuentra planta para cosechar")
		}
	}		
	
	method venderPlanta(unaPlanta){
		if(self.plantasCosechadas().contains(unaPlanta)){
			self.plantasCosechadas().remove(unaPlanta)
			self.oro(self.oro() + unaPlanta.valor())	
		}
	}
	
	method venderCosecha(){
		self.plantasCosechadas().forEach({planta => self.venderPlanta(planta)})
		oro += self.valorCosechaActual()
		plantasCosechadas.clear()
	}
	
	method estaEnMercado(){
		var estaEnMercado = false
		if(game.colliders(self) != [] and game.colliders(self).get(0).tipo() == "Mercado"){
			estaEnMercado = true
		}
		return estaEnMercado
	}

	method venderEnMercado() {
		if(self.estaEnMercado()){
			if(self.plantasCosechadas() != []){
				game.uniqueCollider(self).aceptarCompra()
				self.venderCosecha()
			}else{
				self.error("No tengo nada para vender")
			}
		}else{
			self.error("No estoy en el mercado")
		}
	}
	
	method valorCosechaActual(){
		return self.plantasCosechadas().sum({planta => planta.valor()})
	}
	
	method paraCuantosDiasLeAlcanza(){
		return (self.oro() + self.valorCosechaActual()) / 200
	}
	
	method cuantoHayParaCeliacos(){
		return self.plantasSembradas().count({planta => planta.aptoCeliaco()})
	}
	
	method convieneRegar(){
		return self.plantasSembradas().any({planta => !planta.estaListaParaCosechar()})
	}

	method ofrenda(unaPlanta){
		game.removeVisual(unaPlanta)
		plantasSembradas.remove(unaPlanta)
		self.posicionesDePlantas().remove(unaPlanta.position())	
	}
	
	method hacerOfrenda() { 
		self.ofrenda(plantasSembradas.anyOne())
	}
}

