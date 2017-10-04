/datum/species/pod
	// A mutation caused by a human being ressurected in a revival pod. These regain health in light, and begin to wither in darkness.
	name = "Podperson"
	id = "pod"
	default_color = "59CE00"
	species_traits = list(MUTCOLORS,EYECOLOR)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	burnmod = 1.25
	heatmod = 1.55
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/plant
	disliked_food = NONE
	liked_food = NONE
	toxic_food = NONE
	roundstart = TRUE


/datum/species/pod/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	C.faction |= "plants"
	C.faction |= "vines"

/datum/species/pod/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.faction -= "plants"
	C.faction -= "vines"

/datum/species/pod/spec_life(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return
	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		light_amount = min(1,T.get_lumcount()) - 0.5
		H.nutrition += light_amount * 10
		if(H.nutrition > NUTRITION_LEVEL_FULL)
			H.nutrition = NUTRITION_LEVEL_FULL
		if(light_amount > 0.2) //if there's enough light, heal
<<<<<<< HEAD
<<<<<<< HEAD
			H.heal_overall_damage(0.6)
			H.adjustOxyLoss(-0.5)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 55)
		H.adjustOxyLoss(5)//eat in order to stop
=======
			H.heal_overall_damage(0.05,0)
			H.adjustOxyLoss(-0.5)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 55)
		H.adjustOxyLoss(5) //can eat to negate this unfortunately
		H.adjustToxLoss(3)
>>>>>>> 42cfb61f42d5c7ee08f2cf7b2fde54e9b7c46e54
=======
			H.heal_overall_damage(0.05,0)
			H.adjustOxyLoss(-0.5)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 55)
		H.adjustOxyLoss(5) //can eat to negate this unfortunately
		H.adjustToxLoss(3)
>>>>>>> 42cfb61f42d5c7ee08f2cf7b2fde54e9b7c46e54


/datum/species/pod/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.id == "plantbgone")
		H.adjustToxLoss(5)
		H.reagents.remove_reagent(chem.id, REAGENTS_METABOLISM)
		H.confused = max(H.confused, 1)
		return TRUE


/datum/species/pod/on_hit(obj/item/projectile/P, mob/living/carbon/human/H)
	switch(P.type)
		if(/obj/item/projectile/energy/floramut)
			if(prob(15))
				H.rad_act(rand(30,80))
				H.Knockdown(100)
				H.visible_message("<span class='warning'>[H] writhes in pain as [H.p_their()] vacuoles boil.</span>", "<span class='userdanger'>You writhe in pain as your vacuoles boil!</span>", "<span class='italics'>You hear the crunching of leaves.</span>")
				if(prob(80))
					H.randmutb()
				else
					H.randmutg()
				H.domutcheck()
			else
				H.adjustFireLoss(rand(5,15))
				H.show_message("<span class='userdanger'>The radiation beam singes you!</span>")
		if(/obj/item/projectile/energy/florayield)
			H.nutrition = min(H.nutrition+30, NUTRITION_LEVEL_FULL)
