/*
 *Yes, this is literally a mission about the crew fighting mecha-hitler and his army of geo-nazis.
 *No, I have no regrets about making this.
 */

/*
 *Mecha Hitler himself
 */

/mob/living/simple_animal/hostile/syndicate/mecha_pilot/roboheil
	name = "Cyborg Hitler"
	icon_state = "roboheil"
	icon_living = "roboheil"
	desc = "No.. it can't be!"
	ranged = 1
	rapid = 1
	maxHealth = 500
	health = 500
	retreat_distance = 5
	minimum_distance = 5
	retreat_chance = 0
	faction = list("german")
	casingtype = /obj/item/ammo_casing/c45nostamina
	projectilesound = 'sound/weapons/Gunshot_smg.ogg'
	deathmessage = "Mecha Hitler's body activates its self-destruct function!"
	loot = list(/obj/effect/gibspawner/robot)
	wanted_objects = list()
	search_objects = 0
	spawn_mecha_type = /obj/mecha/combat/marauder/mauler/roboh

/*
 *Mecha Hitler's Mech
 */

/obj/mecha/combat/marauder/mauler/roboh
	name = "\improper Mecha-Hitler"
	desc = "A heavily modified marauder mech with reinforced reflective plating."
	icon_state = "mauler"
	health = 2000
	deflect_chance = 40
	damage_absorption = list("brute"=0.6,"fire"=0.3,"bullet"=0.7,"laser"=0.4,"energy"=0.5,"bomb"=0.5)
	force = 75
	operation_req_access = list(access_syndicate)
	wreckage = /obj/structure/mecha_wreckage/mauler


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/missile_rack/tier2
	name = "\improper SRM-16 missile rack"
	desc = "A modified version of the SMR-8, equipped with an additional 8 racks and a more powerful missile."
	icon_state = "mecha_missilerack"
	projectile = /obj/item/missile/tier2
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	projectiles = 16
	projectile_energy_cost = 1000
	equip_cooldown = 60

/obj/item/missile/tier2
	throwforce = 25

/obj/item/missile/tier2/throw_impact(atom/hit_atom)
	if(primed)
		explosion(hit_atom, 0, 0, 4, 6, 3)
		qdel(src)
	else
		..()


/obj/mecha/combat/marauder/mauler/roboh/New()
	..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/missile_rack/tier2
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/energy/pulse
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay
	ME.attach(src)
	return

/*
 *Geo-Nazies
 */

/mob/living/simple_animal/hostile/nsoldier
	name = "Geo-Nazi"
	desc = "Generations of fascist ideals combined with futuristic science advancement. Freedom's worst nightmare come true."
	icon_state = "nsoldier"
	icon_living = "nsoldier"
	speak_chance = 0
	turns_per_move = 5
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 0
	stat_attack = 1
	robust_searching = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 10
	melee_damage_lower = 10
	melee_damage_upper = 15
	attacktext = "punches"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = "harm"
	loot = list(/obj/effect/landmark/mobcorpse/syndicatesoldier)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("german")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1

/mob/living/simple_animal/hostile/nsoldier/melee
	name = "Hulking Geo-Nazi"
	desc = "The result severe genetic testing and steriods. Would probably win an arm-wrestling match."
	icon_state = "nsoldierbuff"
	icon_living = "nsoldierbuff"
	stat_attack = 0 //dumb brutes can't tell the difference between unconcious and dead
	speed = 3
	maxHealth = 250
	health = 250
	force_threshold = 15
	harm_intent_damage = 30
	melee_damage_lower = 30
	melee_damage_upper = 40
	environment_smash = 2
	attacktext = "slams"
	deathmessage = "The Geo-Nazi's body collapses in on itself from the strain!"
	loot = list(/obj/effect/gibspawner/human)

/mob/living/simple_animal/hostile/nsoldier/melee/AttackingTarget()
	..()
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(prob(50)) //do not fuck with these guys in CQC
			C.Weaken(3)
			C.adjustBruteLoss(10)
			C.visible_message("<span class='danger'>\The [src] smashes \the [C] into the ground!</span>", \
					"<span class='userdanger'>\The [src] smashes you into the ground!</span>")
			src.say(pick("RAAAAAGGHHHH!!!","AAAARRRGGHHHH!!!","RRRAAUUUGGHH!!!"))


/*
 *Structure-related stuff
 */

/obj/structure/pillar
	name = "pillar"
	desc = "A reaaaaaally tall pillar"
	icon = 'icons/obj/pillar.dmi'
	icon_state = "pillarbottom"
	anchored = 1
	density = 1
	layer = 10

/obj/structure/banner
	name = "banner"
	desc = "A piece of cloth hung up on the wall."
	icon = 'icons/obj/banters/banter.dmi'
	anchored = 1
	density = 0
	layer = 10

/obj/structure/banner/heil
	name = "nazi banner"
	desc = "A banner depicting a rather rude image."
	icon_state = "heil"
