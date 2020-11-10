import wollok.game.*
import toni.*
import plantas.*
import mercado.*
import pachamama.*

object juego {
	
	method configTeclado(){
		keyboard.up().onPressDo{toni.moverArriba()}
		keyboard.down().onPressDo{toni.moverAbajo()}
		keyboard.left().onPressDo{toni.moverIzq()}
		keyboard.right().onPressDo{toni.moverDer()}
		keyboard.m().onPressDo{toni.sembrar(new Maiz(position = toni.position()))}
		keyboard.t().onPressDo{toni.sembrar(new Trigo(position = toni.position()))}
		keyboard.o().onPressDo{toni.sembrar(new Tomaco(position = toni.position()))}
		keyboard.r().onPressDo{toni.regarPlanta()}
		keyboard.a().onPressDo{toni.regarLasPlantas()}
		keyboard.x().onPressDo{toni.cosecharTodo()}
		keyboard.c().onPressDo{toni.cosechar()}
		keyboard.v().onPressDo{toni.venderEnMercado()}
		keyboard.space().onPressDo{
			game.say(toni,"Tengo " + toni.oro().toString() + " monedas de oro " + 
			" y quedan " + toni.plantasCosechadas().size().toString() + " plantas por vender")
		}
		keyboard.f().onPressDo({ pachamama.fumigar() })
		keyboard.l().onPressDo({ pachamama.llover() })	
	
	}
	
	
	method configPersonajes_Y_Terreno(){
		game.title("La huerta de Toni")
		game.width(15)
		game.height(15)
		game.ground("tierra.png")

		const supermercado = new Mercado(reservaOro=2000,position=game.at(13,7),image="supermarket.jpg") 
		const mercadito = new Mercado(reservaOro=500,position=game.at(13,13),image="mercado1.jpg")
		
		game.addVisual(toni)
		game.addVisual(pachamama);
		game.addVisual(supermercado)
		game.addVisual(mercadito)
		
		
		game.onCollideDo(pachamama, { t =>
		if(toni.plantasSembradas()!= []){
			toni.hacerOfrenda()
			pachamama.recibirOfrenda()
			toni.plantasSembradas().forEach({planta => planta.regar()})
			self.rotar(pachamama)
		}else{
			pachamama.error("No tienes nada que ofrecer!!!")
		}
		})
	}
	
	method rotar(personaje){
		game.removeVisual(personaje)
		personaje.position(new Position(x=personaje.position().x()+1, y=personaje.position().y()))
		game.addVisualIn(personaje, game.at(personaje.position().x(), personaje.position().y()));
	}
}


