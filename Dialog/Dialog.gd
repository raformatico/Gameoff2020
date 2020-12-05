extends Control

signal show_dialog
signal hide_dialog
signal start_action

const ACTION = "ACTION"
const OBJECT = "OBJECT"
const NEXT_STATE = "NEXT_STATE"
enum SIDE {LEFT, RIGHT}

var tardis_portrait = "res://Dialog/assets/Tardi-dia.png"
var alex_portrait = "res://Dialog/assets/Player-dia.png"
var item_used = null
var inventory = load("res://Inventory/inventory.tres")
var character_talking : int = SIDE.LEFT
var current_character := "Alex"
var current_dialog : Array
var current_object
var text_count := 0



var dialog_dictionary = {
	"Statue" : {
		"start" : [["Alex","It reminds me of the photo from last Christmas that they took of my brother and me at the mall."],["Tardis","It must remember something very important so that it is in the center of this room."],[NEXT_STATE,"Statue","read1"]],
		"read1" : [["Tardis", "We must be missing something."],["Alex", "Here's something written ... First brother on the moon ... 1969 ..."],["Tardis","That seems like a date"],[NEXT_STATE,"Statue","read2"]],
		"read2" : [["Alex", "What was the date it was written here?"],["Tardis", "1969..."]]
	},
	"Wax1" : {
		"start" : [["Alex","I had the same waxes at home. I keep them!"], ["Tardis", "Be careful that they are quite soft and can melt in your pocket."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","Another wax! To the collection!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","You are going to leave the floor much cleaner."], ["Alex","I have a collector's soul"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax2" : {
		"start" : [["Alex","I had the same waxes at home. I keep them!"], ["Tardis", "Be careful that they are quite soft and can melt in your pocket."],  ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","Another wax! To the collection!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","You are going to leave the floor much cleaner."], ["Alex","I have a collector's soul"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax3" : {
		"start" : [["Alex","I had the same waxes at home. I keep them!"], ["Tardis", "Be careful that they are quite soft and can melt in your pocket."],  ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","Another wax! To the collection!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","You are going to leave the floor much cleaner."], ["Alex","I have a collector's soul"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax4" : {
		"start" : [["Alex","I had the same waxes at home. I keep them!"], ["Tardis", "Be careful that they are quite soft and can melt in your pocket."],  ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","Another wax! To the collection!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","You are going to leave the floor much cleaner."], ["Alex","I have a collector's soul"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax5" : {
		"start" : [["Alex","I had the same waxes at home. I keep them!"], ["Tardis", "Be careful that they are quite soft and can melt in your pocket."],  ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked"]],
		"picked1" : [["Alex","Another wax! To the collection!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked"]],
		"picked2" : [["Tardis","You are going to leave the floor much cleaner."], ["Alex","I have a collector's soul"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked"]],
		"picked" : []
	},
	"Cup" : {
		"start" : [["Alex", "Look, a cup. I keep this one ..."],["Tardis", "I can't contain the excitement."],["Alex","*&@$#/°s"],[OBJECT, inventory.cup], [ACTION, "current", "hide"],[NEXT_STATE, "Cup", "picked"]],
		"picked" : []
	},
	"McMoon" : {
		"start" : [["Alex", "My father sat in front of one of these all day."],["Tardis", "Hope yours worked ..."]]
	},
	"Vitrina1" : {
		"start" : [["Alex", "I don't really know what this will be."]]
	},
	"Vitrina2" : {
		"start" : [["Alex", "I don't really know what this will be."]]
	},
	"Cube027" : {
		"start" : [["Alex", "I don't really know what this will be."]]
	},
	"Cuadro1" : {
		"start" : [["Tardis", "Wow, look these pictures! What bad taste."]]
	},
	"Cuadro2" : {
		"start" : [["Tardis", "Wow, look these pictures! What bad taste."]]
	},
	"Cuadro3" : {
		"start" : [["Tardis", "Wow, look these pictures! What bad taste."]]
	},
	"Window" : {
		"start" : [["Tardis", "Why are you looking like this?"],["Alex", "From here you can see the Earth and I miss it a lot ..."],[NEXT_STATE,"Window","start2"]],
		"start2" : [["Alex", "Enough of the wailing, let's get out of here!"],["Tardis", "That's the attitude, count on me"]]
	},
	"DownFloor" : {
		"start" : [["Tardis", "DownFloor"],["Alex", "Ok, ok, OOOKKKKK"]]
	},
	"InterruptorBox" : {
		"start" : [["Alex", "This panel does not work, it gives an error message ..."],["Tardis", "I think some components are missing, if we find them we can surely open this door."],[ACTION,"current","panel"],[NEXT_STATE,"InterruptorBox","start2"]],
		"start2" : [[ACTION,"current","panel"]],
		"opendoor" : [["Alex", "We did it, the door is open!"],["Tardis","I would not be very happy knowing what awaits you in that room."],[ACTION,"current","endgame"]]
	},
	"Lever" : {
		"start" : [["Tardis", "And there was light..."],["Alex", "What a bad roll about the place."],[ACTION, "current", "lighton"],[NEXT_STATE,"Lever", "poweron"]],
		"poweron" : [["Tardis", "Luces fuera"],["Alex", "Bonitas vistas. Echo de menos la tierra"],[ACTION, "current", "lightoff"],[NEXT_STATE,"Lever", "poweroff"]],
		"poweroff" : [["Alex", "Dejemos las luces encendidas."],["Tardis", "Sí, más vale que veamos por dónde vamos."],[ACTION, "current", "lighton"],[NEXT_STATE,"Lever", "poweron"]]
	},
	"Door" : {
		"start" : [["Alex","It seems we need a 4 digit code"],["Tardis", "I think I've seen some numbers somewhere ..."],[ACTION, "current", "code"]],
		"opened" : [["Alex","Open door!"],["Tardis", "I hope you're still safe crossing it ..."]]
	},
	"Pump" : {
		"start" : [["Alex","I'm getting a little thirsty."],["Tardis", "I think you can only pour some liquid, not extract it ..."]],
		"cupcoffee" : [["Alex","I'm going to try diluting some coffee in the tank."],["Tardis", "As long as you don't drink it ..."],[NEXT_STATE,"Key","coffe"],[ACTION,"cupcoffee","use"], [NEXT_STATE,"Plant","grownup"]]
	},
	"Audrey" : {
		"start" : [["Alex",""],["Tardis", ""],["Alex",""],["Tardis", ""]]
	},
	"Key" : {
		"start" : [["Alex","Uff it was hard for me to open this key."],["Tardis", "Maybe you should do more weights."],["Alex","Look! we have opened the irrigation flow. Although the plant does not seem to care too much"],["Tardis", "Only with water you will not be able to revive that big one."]],
		"coffe" : [["Tardis", "That's right, a little coffee in the morning helps anyone get up."],[ACTION,"plant","goingup"]]
	},
	"Key2" : {
		"start" : [["Alex","It turns easily! Oh, I think it doesn't spin anymore."],[ACTION,"Aspiradora","opened"],["Tardis", "You broke it ... In fact there is water in the cafeteria."],["Alex","Ups"],[NEXT_STATE,"Key2","opened"],[NEXT_STATE,"Aspiradora","cafeteria"],[NEXT_STATE,"AspiradoraHall","opened"]],
		"opened" : [["Tardis", "Do not try that this key no longer returns to its place ..."]]
	},
	"Plant" : {
		"start" : [["Alex","What a curious plant."],["Tardis", "Watch out! I think it's carnivorous ... I'm kidding"],["Alex","It's not funny, maybe I can use it to go up."]],
		"grownup" : [["Tardis", "It looks way better like this."]]
	},
	"Lamp" : {
		"start" : [["Alex","I have to try to get up there."],["Tardis", "Maybe you will grow wings ..."]],
		"plant" : [["Tardis", "Eso es, tira un poco más, ya falta poco."],["Alex","Me caig..."],["Tardis", "¿Estás bien?"], ["Alex","Sí, gracias por tu ayuda."],["Tardis","¡Oye… genero luz y oxígeno, pero no me pidas que sostenga 40 kilos de imberbe terrestre!"]],
		"down" : [["Alex","Surely here is something that can help us"],["Tardis", "Do you really like to rummage through the garbage or is it me?"],["Alex","It was worth it! I have found a cable!"],["Tardis","Well, if you wanted a cable, you could have asked for it ..."], [OBJECT,inventory.wire]]
	},
	"Wire" : {
		"start" : [["Alex","Surely here is something that can help us"],["Tardis", "Do you really like to rummage through the garbage or is it me?"],["Alex","It was worth it! I have found a cable!"],["Tardis","Well, if you wanted a cable, you could have asked for it ..."], [OBJECT,inventory.wire], [NEXT_STATE,"wire","picked"]],
		"picked" : [["Alex","There is nothing to see here"]]
	},
	"Gofrera" : {
		"start" : [["Alex","This is hot, it could cook something."],["Tardis", "Hope you know what you're doing ... that machine hasn't been used for a while."]],
		"wax_incomplete" : [["Alex","With this number of waxes there is not enough for this mold ..."],["Tardis","Well, look for more! At least you will need 4 in total."], [NEXT_STATE,"Gofrera","start"]],
		"wax" : [["Tardis", "What dirty are you doing?"],["Alex","Hush, I think it can work."],["Tardis", "I hope you don't think about eating that circular thing."], [ACTION,"wax","use"], [OBJECT,inventory.gear]]
	},
	"AspiradoraHall" : {
		"start" : [["Alex","Look what a beautiful robot cleaner. Cuchi, cuchi ..."],["Tardis", "Back off! They become very territorial when they don't have a job, that area is off limits."]],
		"opened" : []
	},
	"Aspiradora" : {
		"start" : [["Alex","Look what a beautiful robot cleaner. Cuchi, cuchi ..."],["Tardis", "Back off! They become very territorial when they don't have a job, that area is off limits."]],
		"cafeteria" : [["Tardis","Now it seems that he doesn't care much about you"],["Alex", "Yes, but it gives good pushes and there is no way to check if it has something that suits us ..."], ["Tardis","Sorry, you're talking about a living being."]],
		"end" : [["Alex","Go look! It has a chip that is sure to be good for us."],["Tardis","Loot dead! You're horrible ... Well, what can you do? Rest in peace"], [OBJECT,inventory.chip]]
	},
	"Cafetera" : {
		"start" : [["Alex","This still works"],["Tardis", "You are going to burn"],["Alex","You're right"], [NEXT_STATE,"Cafetera","start2"]],
		"start2" : [["Alex","Maybe if we can find something to serve coffee."]],
		"cup" : [["Tardis", "I wouldn't drink that even if they paid me."],["Alex","Surely it can be useful to us."],["Tardis", "That is definitely concentrated energy!"],[ACTION,"cup","use"], [OBJECT,inventory.cupcoffee],[NEXT_STATE,"Cafetera","end"]],
		"end" : [["Tardis","I think that we have done with the coffee machine"]]
	},
	"Radio" : {
		"start" : [["Alex","This radio is not working quite right but I think I can fix it"],["Tardis", "Try it I love music"],[ACTION,"current","minigame"],[NEXT_STATE,"Radio","start"]],
		"middle" : [["Alex","Look, the cleaner robot likes this melody"],["Tardis", "I'd swear you're trying to dance ... to a lousy beat, by the way! "],[NEXT_STATE,"Radio","start"]],
		"end" : [["Tardis", "I think it's going crazy."],["Alex", "Watch out, it's going to explode!"],[NEXT_STATE,"Aspiradora","end"],[NEXT_STATE,"Radio","end2"],[ACTION,"current","endDjGame"]],
		"end2" : [["Tardis", "You have finished here, but there is always time to play!"]]
	},
	"chip" : {
		"start" : [["Alex","I don't know where we are going to get a next-generation chip, which is clearly what is missing from this panel."],["Tardis","You seem to know everything."]],
		"chip" : [["Alex","It fits!"],["Tardis","It is a last generation chip."],[ACTION,"chip","use"],[NEXT_STATE,"chip","connected"],[ACTION,"chip","is_everything_connected"]],
		"connected" : [["Tardis", "What else do you want is already in place!"]]
	},
	"gear" : {
		"start" : [["Alex","What a strange shape, it seems that a gear or some circular piece is missing"],["Tardis","Well, keep looking ..."]],
		"gear" : [["Alex","This is very extrange"],["Tardis","It works so don't ask yourself why"],[ACTION,"gear","use"],[NEXT_STATE,"gear","connected"],[ACTION,"gear","is_everything_connected"]],
		"connected" : [["Tardis", "What else do you want is already in place!"]]
	},
	"wire" : {
		"start" : [["Alex","A cable would fit here."],["Tardis","Smart boy."]],
		"wire" : [["Alex","This cable connects perfectly. One less thing."],[ACTION,"wire","use"],[NEXT_STATE,"wire","connected"],[ACTION,"wire","is_everything_connected"]],
		"connected" : [["Tardis", "What else do you want is already in place!"]]
	},
	"Error" : {
		"start" : [["Alex","I don't think I can use that here"],["Tardis","It was your idea, not mine ..."], [NEXT_STATE, "Error","start2"]],
		"start2" : [["Tardis","This is testing for testing, right?"],[NEXT_STATE, "Error", "start"]]
	}
}

var dialog_dictionary_spa = {
	"Statue" : {
		"start" : [["Alex","Me recuerda a la foto de la navidad pasada que nos hicieron a mi hermano y a mi en el centro comercial."],["Tardis","Debe de rememorar algo muy importante para que esté en el centro de esta sala."],[NEXT_STATE,"Statue","read1"]],
		"read1" : [["Tardis", "Seguro que se nos pasa algo por alto."],["Alex", "Aquí hay algo escrito... Primer hermano en la luna... 1969..."],["Tardis","Eso parece una fecha"],[NEXT_STATE,"Statue","read2"]],
		"potion" : [["Alex", "He usado la poción con la estatua!"],[NEXT_STATE,"Statue","read2"], [ACTION,"potion","use"]],
		"read2" : [["Alex", "¿Cuál era la fecha que ponía aquí?"],["Tardis", "1969..."]]
	},
	"Wax1" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax2" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax3" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax4" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked"], [NEXT_STATE, "Wax5", "picked2"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked"], [NEXT_STATE, "Wax5", "picked1"]],
		"picked" : []
	},
	"Wax5" : {
		"start" : [["Alex","Tenía unas ceras iguales en casa. ¡Me las quedo!"], ["Tardis", "Ten cuidado que son bastante blandas y se te pueden derretir en el bolsillo."], ["Alex","Ok boomer"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked"]],
		"picked1" : [["Alex","¡Otra cera! ¡A la colección!"], [OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked2"], [NEXT_STATE, "Wax2", "picked2"], [NEXT_STATE, "Wax3", "picked2"], [NEXT_STATE, "Wax4", "picked2"], [NEXT_STATE, "Wax5", "picked"]],
		"picked2" : [["Tardis","Vas a dejar el suelo mucho más limpio."], ["Alex","Tengo alma de coleccionista"],[OBJECT, inventory.wax], [ACTION, "current", "hide"], [NEXT_STATE, "Wax1", "picked1"], [NEXT_STATE, "Wax2", "picked1"], [NEXT_STATE, "Wax3", "picked1"], [NEXT_STATE, "Wax4", "picked1"], [NEXT_STATE, "Wax5", "picked"]],
		"picked" : []
	},
	"Cup" : {
		"start" : [["Alex", "Mira, una taza. Esta me la quedo..."],["Tardis", "No puedo contener la emoción."],["Alex","*&@$#/°s"],[OBJECT, inventory.cup], [ACTION, "current", "hide"],[NEXT_STATE, "Cup", "picked"]],
		"picked" : []
	},
	"McMoon" : {
		"start" : [["Alex", "Mi padre se pasaba el día sentado frente a uno de estos."],["Tardis", "Espero que el suyo funcionase..."]]
	},
	"Vitrina1" : {
		"start" : [["Alex", "No sé muy bien qué será esto."]]
	},
	"Vitrina2" : {
		"start" : [["Alex", "No sé muy bien qué será esto."]]
	},
	"Cube027" : {
		"start" : [["Alex", "No sé muy bien qué será esto."]]
	},
	"Cuadro1" : {
		"start" : [["Tardis", "Vaya cuadros más frikis. Qué mal gusto."]]
	},
	"Cuadro2" : {
		"start" : [["Tardis", "Vaya cuadros más frikis. Qué mal gusto."]]
	},
	"Cuadro3" : {
		"start" : [["Tardis", "Vaya cuadros más frikis. Qué mal gusto."]]
	},
	"Window" : {
		"start" : [["Tardis", "¿Por qué miras así?"],["Alex", "Desde aquí se ve La Tierra y la echo mucho de menos..."],[NEXT_STATE,"Window","start2"]],
		"start2" : [["Alex", "Basta de lamentos, vamos a salir de aquí!"],["Tardis", "Esa es la actitud, cuenta conmigo"]]
	},
	"DownFloor" : {
		"start" : [["Tardis", "DownFloor"],["Alex", "Que sí pesado!"]]
	},
	"InterruptorBox" : {
		"start" : [["Alex", "Este panel no funciona, da un mensaje de error..."],["Tardis", "Creo que faltan algunos componentes, si los encontramos seguro que podemos abrir esta puerta."],[ACTION,"current","panel"],[NEXT_STATE,"InterruptorBox","start2"]],
		"start2" : [[ACTION,"current","panel"]],
		"opendoor" : [["Alex", "¡Lo hemos conseguido, la puerta está abierta!"],["Tardis","Yo no estaría muy contento sabiendo lo que te espera en esa habitación."]]
	},
	"Lever" : {
		"start" : [["Tardis", "Y se hizo la luz..."],["Alex", "Qué mal rollo de sitio."],[ACTION, "current", "lighton"],[NEXT_STATE,"Lever", "poweron"]],
		"poweron" : [["Tardis", "Luces fuera"],["Alex", "Bonitas vistas. Echo de menos la tierra"],[ACTION, "current", "lightoff"],[NEXT_STATE,"Lever", "poweroff"]],
		"poweroff" : [["Alex", "Dejemos las luces encendidas."],["Tardis", "Sí, más vale que veamos por dónde vamos."],[ACTION, "current", "lighton"],[NEXT_STATE,"Lever", "poweron"]]
	},
	"Door" : {
		"start" : [["Alex","Parece que necesitamos un código de 4 dígitos"],["Tardis", "Creo que he visto unos números en algún lado..."],[ACTION, "current", "code"]],
		"opened" : [["Alex","¡Puerta abierta!"],["Tardis", "Espero que sigas a salvo al cruzarla..."]]
	},
	"Pump" : {
		"start" : [["Alex","Me está entrando algo de sed."],["Tardis", "Creo que sólo puedes verter algún líquido, no extraerlo..."]],
		"cupcoffee" : [["Alex","Voy a probar a diluir  un poco de café en el depósito."],["Tardis", "Mientras no te lo bebas tú..."],[NEXT_STATE,"Key","coffe"],[ACTION,"cupcoffee","use"]]
	},
	"Audrey" : {
		"start" : [["Alex",""],["Tardis", ""],["Alex",""],["Tardis", ""]]
	},
	"Key" : {
		"start" : [["Alex","Uff me ha costado abrir esta llave."],["Tardis", "Quizá deberías hacer más pesas."],["Alex","¡Mira! hemos abierto el caudal de regadío. Aunque a la planta no parece importarle demasiado"],["Tardis", "Solamente con agua no vas a conseguir reanimar a esa grandullona."]],
		"coffe" : [["Tardis", "Eso es, un poco de café por la mañana ayuda a cualquiera a levantarse."],[ACTION,"plant","goingup"]]
	},
	"Key2" : {
		"start" : [["Alex","Gira fácil! Uy yo creo que ya no gira más."],[ACTION,"Aspiradora","opened"],["Tardis", "La has roto... De hecho suena agua en la cafetería."],["Alex","Ups"],[NEXT_STATE,"Key2","opened"],[NEXT_STATE,"Aspiradora","cafeteria"],[NEXT_STATE,"AspiradoraHall","opened"]],
		"opened" : [["Tardis", "No lo intentes que esta llave ya no vuelve a su sitio..."]]
	},
	"Plant" : {
		"start" : [["Alex","Qué planta más curiosa."],["Tardis", "¡Cuidado! creo que es carnívora...Estoy bromeando"],["Alex","No es gracioso, quizá pueda usarla para subir."]],
		"goingup" : [["Tardis", "Ya puedes subir."],["Alex","¿Un poco obvio no?"]]
	},
	"Lamp" : {
		"start" : [["Alex","Tengo que intentar llegar allí arriba."],["Tardis", "Quizá te salgan alas..."]],
		"plant" : [["Tardis", "Eso es, tira un poco más, ya falta poco."],["Alex","Me caig..."],["Tardis", "¿Estás bien?"], ["Alex","Sí, gracias por tu ayuda."],["Tardis","¡Oye… genero luz y oxígeno, pero no me pidas que sostenga 40 kilos de imberbe terrestre!"]],
		"down" : [["Alex","Seguro que aquí hay algo que nos puede ayudar"],["Tardis", "Te gusta mucho rebuscar en la basura o soy yo?"],["Alex","Mereció la pena! He encontrado un cable!"],["Tardis","Pues si querías un cable podrías haberlo pedido..."],[OBJECT,inventory.wire]]
	},
	"Wire" : {
		"start" : [["Alex","Creo que esto me va a servir."],["Tardis", "Ten cuidado, no vaya a tener que salvarte de nuevo."]],
		"picked" : []
	},
	"Gofrera" : {
		"start" : [["Alex","Esto está caliente, podría cocinar algo."],["Tardis", "Espero que sepas lo que estás haciendo...esa máquina lleva tiempo sin usarse."]],
		"wax_incomplete" : [["Alex","Con este número de ceras no hay suficiente para este molde..."],["Tardis","Pues a buscar más! Por lo menos vas a necesitar 4 en total."], [NEXT_STATE,"Gofrera","start"]],
		"wax" : [["Tardis", "¿Qué guarrería estás haciendo?"],["Alex","Calla, creo que puede funcionar."],["Tardis", "Espero que no pienses en comerte esa cosa circular."], [ACTION,"wax","use"], [OBJECT,inventory.gear]]
	},
	"AspiradoraHall" : {
		"start" : [["Alex","Mira qué robot limpiador más bonito. Cuchi, cuchi..."],["Tardis", "¡Retrocede! Se vuelven muy territoriales cuando no tienen trabajo, esa zona está vedada."]],
		"opened" : []
	},
	"Aspiradora" : {
		"start" : [["Alex","Mira qué robot limpiador más bonito. Cuchi, cuchi..."],["Tardis", "¡Retrocede! Se vuelven muy territoriales cuando no tienen trabajo, esa zona está vedada."]],
		"cafeteria" : [["Tardis","Ahora parece que no se preocupa mucho de ti"],["Alex", "Sí, pero da buenos empujones y no hay manera de revisar si tiene algo que nos venga bien..."], ["Tardis","Perdona, estás hablando de un ser vivo."]],
		"end" : [["Alex","Anda mira! Tiene un chip que seguro que nos viene bien."],["Tardis","Saquea muertos! Eres horrible... Bueno qué se le va a hacer. Descanse en paz"], [OBJECT,inventory.chip]]
	},
	"Cafetera" : {
		"start" : [["Alex","Esto aún funciona"],["Tardis", "Te vas a quemar"],["Alex","Tienes razón"], [NEXT_STATE,"Cafetera","start2"]],
		"start2" : [["Alex","Quizá si encontrásemos algo donde servir el café."]],
		"cup" : [["Tardis", "No me bebería eso ni aunque me pagaran."],["Alex","Seguro que puede sernos de utilidad."],["Tardis", "Sin duda eso es energía concentrada!"],[ACTION,"cup","use"], [OBJECT,inventory.cupcoffee],[NEXT_STATE,"Cafetera","end"]],
		"end" : [["Tardis","Yo creo que con la cafetera has terminado"]]
	},
	"Radio" : {
		"start" : [["Alex","Esta radio no funciona del todo bien pero creo que puedo arreglarla"],["Tardis", "Inténtalo que me encanta la música"],[ACTION,"current","minigame"]],
		"middle" : [["Alex","Mira, le gusta esta melodía"],["Tardis", "Juraría que está intentando bailar... ¡con un ritmo pésimo, por cierto! "]],
		"end" : [["Tardis", "Creo que se está volviendo loca."],["Alex", "Cuidado ¡va a estallar!"],[NEXT_STATE,"Aspiradora","end"],[ACTION,"current","breakMoonba"]]
	},
	"chip" : {
		"start" : [["Alex","No sé de donde vamos a sacar un chip de última generación, que claramente es lo que falta en este panel."],["Tardis","Parece que lo sabes todo."]],
		"chip" : [["Alex","¡Encaja!"],["Tardis","Es que es un chip de última generación."],[ACTION,"chip","use"],[NEXT_STATE,"chip","connected"],[ACTION,"chip","is_everything_connected"]],
		"connected" : [["Tardis", "Qué mas quieres ya está en su sitio!"]]
	},
	"gear" : {
		"start" : [["Alex","Qué forma más extraña, parece que falta un engranaje o alguna pieza circular"],["Tardis","Pues a seguir buscando..."]],
		"gear" : [["Alex","Esto es muy raro"],["Tardis","Funciona, así que no te preguntes por qué"],[ACTION,"gear","use"],[NEXT_STATE,"gear","connected"],[ACTION,"gear","is_everything_connected"]],
		"connected" : [["Tardis", "Qué mas quieres ya está en su sitio!"]]
	},
	"wire" : {
		"start" : [["Alex","Aquí encajaría un cable."],["Tardis","Chico listo."]],
		"wire" : [["Alex","Este cable conecta perfecto. Una cosa menos."],[ACTION,"wire","use"],[NEXT_STATE,"wire","connected"],[ACTION,"wire","is_everything_connected"]],
		"connected" : [["Tardis", "Qué mas quieres ya está en su sitio!"]]
	},
	"Error" : {
		"start" : [["Alex","No creo que pueda usar eso aquí"],["Tardis","Era tu idea, no la mía..."], [NEXT_STATE, "Error","start2"]],
		"start2" : [["Tardis","Esto es probar por probar, ¿verdad?"],[NEXT_STATE, "Error", "start"]]
	}
}

onready var left_portrait: = $text_box/left_portrait
onready var right_portrait: = $text_box/right_portrait
onready var right_background := $background_right
onready var left_background := $background_left
onready var rich_text := $text_box/text

func _ready() -> void:
	Global.connect("start_dialog",self,"start_dialog")
	Global.connect("start_dialog_item",self,"start_dialog_item")
	connect("start_action",Global,"_on_start_action")


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("next_dialog"):
		next_dialog()

func start_dialog_item(object, status, item_selected, interact_with) -> void:
	item_used = item_selected
	#Show generic misselection of item
	var new_object
	if object is String:
		new_object = {"name" : object}
	else:
		new_object = object
	if new_object.name != interact_with:
		current_dialog = dialog_dictionary["Error"][Global.status["Error"]]
		show_dialog()
		next_dialog()
	#Else show correct dialog
	else:
		if item_selected == "wax":
			var quantity = 0
			var max_stack = 0
			for item in inventory.inventory:
				if item.name == "wax":
					quantity = item.quantity
					max_stack = item.max_stack
			if quantity < max_stack:
				Global.status[new_object.name] = "wax_incomplete"
			else:
				Global.status[new_object.name] = item_selected
		else:
			Global.status[new_object.name] = item_selected
		start_dialog(new_object, Global.status[new_object.name])
	#Deselect item
	inventory.emit_signal("deselect_all")
	

func start_dialog(object, status) -> void:
	if object is String:
		current_dialog = dialog_dictionary[object][status]
	else:
		current_dialog = dialog_dictionary[object.name][status]
	current_object = object
	show_dialog()
	next_dialog()

func get_status(node_label : String) -> String:
	return "without_keys"
	
	
func next_dialog() -> void:
	if text_count == current_dialog.size():
		hide_dialog()
		return

	var current_text_to_show : Array = current_dialog[text_count]
	var i
	if current_text_to_show[0] == OBJECT:
		inventory.add_item(current_text_to_show[1])
		text_count += 1
	elif current_text_to_show[0] == ACTION:
		if current_text_to_show[1] == "current":
			emit_signal("start_action", current_object, current_text_to_show[2])
		else:
			emit_signal("start_action", current_text_to_show[1], current_text_to_show[2])
		text_count += 1
	elif current_text_to_show[0] == NEXT_STATE:
		set_status(current_text_to_show[1],current_text_to_show[2])
		text_count += 1
	else:
		var previous_character = current_character
		current_character = current_text_to_show[0]
		if current_character != previous_character:
			change_character()
		change_text(current_text_to_show[1])
		text_count += 1
		return
	if text_count == current_dialog.size():
		hide_dialog()
	else:
		next_dialog()

func set_status(object : String, new_status : String) -> void:
	if Global.status[object] != "picked":
		Global.status[object] = new_status


func change_character() -> void:
	if character_talking == SIDE.LEFT:
		left_portrait.visible = false
		left_background.visible = false
		right_portrait.visible = true
		right_background.visible = true
		character_talking = SIDE.RIGHT
	else:
		left_portrait.visible = true
		left_background.visible = true
		right_portrait.visible = false
		right_background.visible = false
		character_talking = SIDE.LEFT


func change_text(new_text : String) -> void:
	rich_text.text = new_text


func hide_dialog() -> void:
	visible = false
	text_count = 0
	emit_signal("hide_dialog")


func show_dialog() -> void:
	right_portrait.visible = false
	var label = current_dialog[0][0]
	if label == "Alex":
		left_portrait.flip_h = false
		left_portrait.texture = load(alex_portrait)
		right_portrait.flip_h = false
		right_portrait.texture = load(tardis_portrait)
		current_character = "Alex"
	elif label == "Tardis":
		left_portrait.flip_h = true
		left_portrait.texture = load(tardis_portrait)
		right_portrait.flip_h = true
		right_portrait.texture = load(alex_portrait)
		current_character = "Tardis"
	character_talking = SIDE.LEFT
	left_portrait.visible = true
	visible = true
	emit_signal("show_dialog")
		
		
func _on_Dialog_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		next_dialog()



func _on_back_pressed() -> void:
	pass # Replace with function body.
