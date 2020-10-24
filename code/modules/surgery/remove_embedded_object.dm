/datum/surgery/embedded_removal
	name = "Removal of embedded objects"
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/remove_object,
				/datum/surgery_step/close)
	possible_locs = ALL_BODYPARTS //skyrat edit

/datum/surgery_step/remove_object
	name = "Remove embedded objects"
	time = 32
	accept_hand = 1
	var/obj/item/bodypart/L = null

/datum/surgery_step/remove_object/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	L = surgery.operated_bodypart
	if(L)
		display_results(user, target, "<span class='notice'>You look for objects embedded in [target]'s [parse_zone(user.zone_selected)]...</span>",
			"[user] looks for objects embedded in [target]'s [parse_zone(user.zone_selected)].",
			"[user] looks for something in [target]'s [parse_zone(user.zone_selected)].")
	else
		user.visible_message("[user] looks for [target]'s [parse_zone(user.zone_selected)].", "<span class='notice'>You look for [target]'s [parse_zone(user.zone_selected)]...</span>")

/datum/surgery_step/remove_object/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(L)
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/objects = 0
			for(var/obj/item/I in L.embedded_objects)
				objects++
				H.remove_embedded_object(I)

			if(objects > 0)
				display_results(user, target, "<span class='notice'>You successfully remove [objects] objects from [H]'s [L.name].</span>",
					"[user] successfully removes [objects] objects from [H]'s [L]!",
					"[user] successfully removes [objects] objects from [H]'s [L]!")
			else
				to_chat(user, "<span class='warning'>You find no objects embedded in [H]'s [L]!</span>")

	else
		to_chat(user, "<span class='warning'>You can't find [target]'s [parse_zone(user.zone_selected)], let alone any objects embedded in it!</span>")
	return 1