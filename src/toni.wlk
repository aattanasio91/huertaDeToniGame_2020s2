import wollok.game.*
import plantas.*

object toni {
	const property image = "toni.png"
	var property position = game.at(3, 3)
	var property plantasSembradas = []
	var property plantasCosechadas = []
	var property posicionesDePlantas = [] 
	var property oro = 0
	
	method moverArriba(){
		self.position(self.position().up(1))
	}
	
	method moverAbajo(){
		self.position(self.position().down(1))
	}
	
	method moverIzq(){
		self.position(self.position().left(1))
	}
	
	method moverDer(){
		self.position(self.position().right(1))
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
	}
	
	method cosechar(){
		const planta = game.uniqueCollider(self)
		if(planta.estaListaParaCosechar()){
			plantasSembradas.add(planta)
			game.removeVisual(planta)
			plantasSembradas.remove(planta)
			posicionesDePlantas.remove(self.position())
		}
		else{
			self.error("La planta no se encuentra sembrada")
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
}