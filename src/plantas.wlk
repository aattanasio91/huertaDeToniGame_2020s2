class Planta {
	var property position
	
	method regar()
	
	method estaListaParaCosechar()
	
	method aptoCeliaco() = false
	
	method valor() = 0
}

class Maiz inherits Planta{
	var property esAdulta = false
	var property image = "maiz_bebe.png"
	
	override method valor(){
		return 150
	}
	
	override method regar(){
		self.image("maiz_adulto.png")
		self.esAdulta(true)
	}
	
	override method estaListaParaCosechar(){
		return self.esAdulta()
	}
	
	override method aptoCeliaco() = true
}

class Trigo inherits Planta{
	const property nombreImagen = ["trigo_0.png", "trigo_1.png", "trigo_2.png", "trigo_3.png"]
	var property estadoEvolucion = 0
	var property image = "trigo_0.png"
	
	method image() {
		 return nombreImagen.get(self.estadoEvolucion() % 4)
	}
	
	override method regar(){
		if(estadoEvolucion % 4 != 3){
			estadoEvolucion++
		}
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
}