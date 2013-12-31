-- ProbablyEngine Rotation Packager
-- Custom Restoration Shaman Rotation
-- Created on Dec 24th 2013 8:27 am
ProbablyEngine.library.register('coreHealing', {
   needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

ProbablyEngine.rotation.register_custom(264, "Seds Resto shamy", {

--Buffs for teh lazy
--{ "51730", "!player.enchant.mainhand" },
--{ "52127", "!player.buff(52127)" },

--Lets target something
{ "!/targetenemy [noharm]", {"player.glyph(55453)", "!target.alive", "!target.enemy", "!target.exists"}},

--Lightning bolt son
--{ "403", {"player.mana <= 60", "!target.range > 40"}},

-------------
--Key binds--
-------------

--Healing Tide Totem
{"108280", "modifier.lshift", "ground"},

--Healing rain
{"73680", "modifier.lcontrol"},
{"73920", "modifier.lcontrol", "ground"}, 

--Totemic projection
{"108287", "modifier.lalt", "ground"},

--Spiritwalker's Grace
{"79206", "modifier.ralt"},

--Spirit link
{"98008", "modifier.rshift", "ground"},

--Hero
{"2825", "modifier.rcontrol"},
-------------
--Key binds--
-------------

--Buffs for teh lazy
{ "51730", "!player.enchant.mainhand" },
{ "52127", "!player.buff(52127)" },

--Storm lash
{"120668", "player.buff(2825)"},

--Recalling totems
{ "36936", { "player.totem(5394)", "player.totem(5394).duration < 2" }},
{"36936", { "player.totem(108280)", "player.totem(108280).duration < 2"}},

--Mana tide totem
{ "16190", {"player.mana < 80" }, "player" },

--Def cd
{"108271", "player.health < 50"},
{"98008", "player.health < 40"},

-----------------
--Oh fuck heals--
-----------------
--Ancestral Swiftness
{ "16188", {"lowest.health < 35", "!lowest.range > 40"}, "lowest" },

--Greater Healing wave
{ "77472", {"player.buff(16188)", "lowest.health < 35", "!lowest.range > 40"}, "lowest" },

---------------
--Aoe healing--
---------------
--Healing Stream Totem
{ "5394", {"@coreHealing.needsHealing(90, 3)",}},

--Healing Tide Totem
{ "108280", {"@coreHealing.needsHealing(60, 4)"}},

--Chain heal(90% vs 3)
{ "1064", {"@coreHealing.needsHealing(90, 3)", "!lowest.range > 30"}, "lowest" },


--Auto res
--{"2008", {"lowest.health = 0", "!lowest.range > 40"}, "lowest"},

--Healing surge
{ "8004", {"lowest.health < 35", "!lowest.range > 40", "!modifier.last(8004)"}, "lowest" },

--Greater Healing Wave
{ "77472", {"lowest.health < 60", "player.buff(53390)",  "!lowest.range > 40", "!modifier.last(77472)"}, "lowest" },

--Healing Wave
{"331", {"tank.health < 90", "player.buff(53390)", "!lowest.range > 40", "!modifier.last(331)"}, "lowest" },
{"331", {"lowest.health < 85", "player.buff(53390)", "lowest.range > 40", "!modifier.last(331)"}, "lowest" },

--Riptide
{ "61295", {"!lowest.buff(Riptide)", "lowest.spell(Riptide).range", "lowest.health < 80"}, "lowest"},
-------------------
--Tank shit Below--
-------------------

--Earth shield
{ "974", {"!tank.buff(974)", "!tank.range > 40"}, "tank" },

--Riptide
{ "61295", {"!tank.buff(Riptide)", "tank.buff(Riptide).duration < 2", "!tank.range > 40"}, "tank" },

--Tank surge
{"8004", {"tank.health <= 40", "lowest.range", "!modifier.last(8004)"}, "lowest" },

--------
--Mana--
--------

--lightning bolt
{"403", "player.glyph(55453)"},

}, {

-------
--ooc--
-------

--Riptide
{ "61295", {"!tank.buff(Riptide)", "tank.buff(Riptide).duration <= 2", "!tank.range > 40"}, "tank" },

--Healing surge
{ "8004", {"lowest.health <= 50", "!lowest.range > 40", "!modifier.?last(Healing Surge)"}, "lowest" },

--Earth shield
{ "974", {"!tank.buff(974)", "!tank.range > 40"}, "tank" },

--Buffs for teh lazy
{ "51730", "!player.enchant.mainhand" },
{ "52127", "!player.buff(52127)" },

})