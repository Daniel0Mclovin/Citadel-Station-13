
/obj/item/clothing/accessory/vibrator
	name = "Vibrator"
	desc = "Concealed carry license not required."
	icon = 'code/citadel/icons/misc.dmi'
	icon_state = "vibrator"
	slot_flags = SLOT_ICLOTHING			//owo
	var/on = FALSE
	var/power = 1						//Fastprocessing!
	var/min_power = 1
	var/max_power = 3
	var/last_msg = 0					//No spamming.
	var/msg_cd = 50
	var/lastloc							//cache to save processing time.
	var/mob/lasttarget					//^

/obj/item/clothing/accessory/vibrator/proc/get_affected_mob()
	if(lastloc == loc)
		return lasttarget
	if(ismob(loc))
		var/mob/M = loc
		if(M.w_uniform == src)
			lasttarget = M
			lastloc = loc
			return M
	else if(istype(loc, /obj/item/clothing/under))
		var/obj/item/clothing/under/U = loc
		if(ismob(U.loc))
			var/mob/M = U.loc
			if(M.w_uniform == U)
				lasttarget = M
				lastloc = loc
				return M
	lasttarget = null
	lastloc = loc

/obj/item/clothing/accessory/vibrator/Initialize()
	START_PROCESSING(SSfastprocess, src)
	return ..()

/obj/item/clothing/accessory/vibrator/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	lastloc = null
	lasttarget = null
	return ..()

/obj/item/clothing/accessory/vibrator/proc/can_be_affected(mob/M)
	if(!istype(M))
		return FALSE
	if(!M.canbearoused)
		return FALSE
	return TRUE

/obj/item/clothing/accessory/vibrator/process()
	if(!on)
		return
	var/mob/M = get_affected_mob()
	if(!istype(M))
		return
	vibrator_message(M)
	if(!can_be_affected(M))
		return

/obj/item/clothing/accessory/vibrator/proc/vibrator_message(mob/M)
	if(!istype(M) || (lastmsg > (world.time - msg_cd)))
		return


/obj/item/clothing/accessory/vibrator/proc/toggle(mob/M)
	on = !on
	if(istype(M))
		to_chat(M, "<span class='alertalien'>You toggle \the [src] [on? "on":"off"]...</span>")	//pinktext when?
	var/mob/M2 = get_affected_mob()
	if(istype(M2))
		to_chat(M, "<span class='alertalien'>You feel [src] [on? "start":"stop"] vibrating...</span>")
	if(!can_be_affected(M2))
		return
