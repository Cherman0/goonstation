ABSTRACT_TYPE(/datum/material)
	var/atom/owner = null //the atom this material is on
	var/name = "Material" //material name
	var/desc = "Abstract material parent" //material description
	//properties scale from 1 to 9 when present, 0 can represent lack of a property (ie radioactive 0 means non radioactive)
	var/electrical = 5 //electrical conductivity
	var/thermal = 5 //thermal conductivity
	var/hard = 5 //how hard is it
	var/dense = 5 //how dense is it
	var/chemical = 5 //how chemically active is it
	var/radioactive = 0 //how radioactive is it
	var/neutron = 0 //how neutron radioactive is it
	//boolean properties
	var/edible = FALSE //whether you can eat it or not
	var/flammable = FALSE //whether it burns or not
	//unique appearence handling
	var/texture = null //if not null, texture to apply to things with this material
	var/texture_blend = BLEND_ADD //how to handle applying texture
	//normal appearence handling
	var/applyColor = TRUE //Whether it should color things made of it
	var/color = "#FFFFFF" //hex value of the material color to apply to things
	var/alpha = 255 //value from 0 to 255 representing transparency, with 255 being fully opaque

	//Lists of datums containing procs to activate in certain contditions.
	var/list/triggersTemp = list() // Called when exposed to temperatures.
	var/list/triggersChem = list() // Called when exposed to chemicals.
	var/list/triggersPickup = list() // Called when owning object is picked up.
	var/list/triggersDrop = list() // Called when owning object is dropped.
	var/list/triggersExp = list() // Called when exposed to explosions.
	var/list/triggersOnAdd = list() // Called when the material is added to an object
	var/list/triggersOnRemove = list() // Called when the material is removed from an object
	var/list/triggersOnLife = list() // Called when the life proc of a mob that has the owning item equipped runs.
	var/list/triggersOnAttack = list() // Called when the owning object is used to attack something or someone.
	var/list/triggersOnAttacked = list() // Called when a mob wearing the owning object is attacked.
	var/list/triggersOnBullet = list() // Called when a mob wearing the owning object is shot.
	var/list/triggersOnEntered = list() // Called when *something* enters a turf with the material assigned. Also called on all objects on the turf with a material.
	var/list/triggersOnEat = list() // Called when someone eats a thing with this material assigned.
	var/list/triggersOnBlobHit = list() // Called when blob hits something with this material assigned.
	var/list/triggersOnHit = list() // Called when an obj hits something with this material assigned.

	//procs to be called externally that in turn call everything that should trigger from that condition.
	proc/triggerOnEntered(var/atom/owner, var/atom/entering)
		for(var/datum/materialProc/X in triggersOnEntered)
			X.execute(owner, entering)
		return

	proc/triggerOnAttacked(var/obj/item/owner, var/mob/attacker, var/mob/attacked, var/atom/weapon)
		for(var/datum/materialProc/X in triggersOnAttacked)
			X.execute(owner, attacker, attacked, weapon)
		return

	proc/triggerOnBullet(var/obj/item/owner, var/atom/attacked, var/obj/projectile/projectile)
		for(var/datum/materialProc/X in triggersOnBullet)
			X.execute(owner, attacked, projectile)
		return

	proc/triggerOnAttack(var/obj/item/owner, var/mob/attacker, var/mob/attacked)
		for(var/datum/materialProc/X in triggersOnAttack)
			X.execute(owner, attacker, attacked)
		return

	proc/triggerOnLife(var/mob/M, var/obj/item/I, mult)
		for(var/datum/materialProc/X in triggersOnLife)
			X.execute(M, I, mult)
		return

	proc/triggerOnAdd(var/location)
		for(var/datum/materialProc/X in triggersOnAdd)
			X.execute(location)
		return

	proc/triggerOnRemove(var/location)
		for(var/datum/materialProc/X in triggersOnRemove)
			X.execute(location)
		return

	proc/triggerChem(var/location, var/chem, var/amount)
		for(var/datum/materialProc/X in triggersChem)
			X.execute(location, chem, amount)
		return

	proc/triggerPickup(var/mob/M, var/obj/item/I)
		for(var/datum/materialProc/X in triggersPickup)
			X.execute(M, I)
		return

	proc/triggerDrop(var/mob/M, var/obj/item/I)
		for(var/datum/materialProc/X in triggersDrop)
			X.execute(M, I)
		return

	proc/triggerTemp(var/location, var/temp)
		for(var/datum/materialProc/X in triggersTemp)
			X.execute(location, temp)
		return

	proc/triggerExp(var/location, var/sev)
		for(var/datum/materialProc/X in triggersExp)
			X.execute(location, sev)
		return

	proc/triggerEat(var/mob/M, var/obj/item/I)
		for(var/datum/materialProc/X in triggersOnEat)
			X.execute(M, I)
		return

	proc/triggerOnBlobHit(var/atom/owner, var/blobPower)
		for(var/datum/materialProc/X in triggersOnBlobHit)
			X.execute(owner, blobPower)
		return

	proc/triggerOnHit(var/atom/owner, var/obj/attackobj, var/mob/attacker, var/meleeorthrow)
		for(var/datum/materialProc/X in triggersOnHit)
			X.execute(owner, attackobj, attacker, meleeorthrow)
		return

ABSTRACT_TYPE(datum/material/metal)
/datum/material/metal
	name = "Metal"
	desc = "Abstract metal parent"
	color = "#8C8C8C"
	electrical = 6
	thermal = 6

ABSTRACT_TYPE(datum/material/stone)
/datum/material/stone
	name = "Stone"
	desc = "Abstract stone parent"
	color = "#ACACAC"
	electrical = 2
	thermal = 4

ABSTRACT_TYPE(datum/material/crystal)
/datum/material/crystal
	name = "Crystal"
	desc = "Abstract crystal parent"
	color = "#A3DCFF"
	electrical = 2
	thermal = 7

ABSTRACT_TYPE(/datum/material/fabric)
/datum/material/fabric
	name = "Fabric"
	desc = "Abstract fabric parent"
	color = "#FFFFFF"
	thermal = 2
	hard = 2
	dense = 2

ABSTRACT_TYPE(/datum/material/gooey) //fleshy or blobby stuff
/datum/material/gooey
	name = "Gooey"
	desc = "Abstract gooey parent"
	color = "#574846"
	thermal = 2
	dense = 3
	hard = 1
	edible = TRUE

ABSTRACT_TYPE(/datum/material/rubber)
/datum/material/rubber
	name = "Rubber"
	desc = "Abstract rubber parent"
	color = "#FF0000"
	thermal = 2
	electrical = 1
	hard = 3
	dense = 4

ABSTRACT_TYPE(/datum/material/wood)
/datum/material/woody
	name = "Woody"
	desc = "Abstract woody parent"
	color = "#331f16"
	thermal = 3
	electrical = 1
	hard = 4
	dense = 4
	flammable = TRUE

