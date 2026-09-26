-- config.lua

local Config = {}

-- Constants
Config.PLAYER_RANGES = {
  starting = { start = 1, count = 11 }, -- Players 1-11
  subres = { start = 12, count = 9 }    -- Players 12-19
}

Config.FORMATION_POSITIONS = {
  formation19 = { -- 4-3-3
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 50, left = 250 },     -- Head6: Right midfielder
    { top = 50, left = 0 },       -- Head7: Central midfielder
    { top = 50, left = -250 },    -- Head8: Left midfielder
    { top = -50, left = 300 },    -- Head9: Right winger
    { top = -100, left = 0 },      -- Head10: Striker
    { top = -50, left = -270 }    -- Head11: Left winger
  },
  formation21 = { -- 4-4-1-1
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 50, left = 300 },     -- Head6: Right midfielder
    { top = 50, left = 100 },     -- Head7: Central midfielder right
    { top = 50, left = -100 },    -- Head8: Central midfielder left
    { top = 50, left = -300 },    -- Head9: Left midfielder
    { top = -20, left = 0 },      -- Head10: Attacking midfielder
    { top = -100, left = 0 }      -- Head11: Striker
  },
  formation23 = { -- 4-4-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 50, left = 300 },     -- Head6: Right midfielder
    { top = 50, left = 100 },     -- Head7: Central midfielder right
    { top = 50, left = -100 },    -- Head8: Central midfielder left
    { top = 50, left = -300 },    -- Head9: Left midfielder
    { top = -20, left = 150 },    -- Head10: Striker right
    { top = -20, left = -150 }    -- Head11: Striker left
  },
  formation25 = { -- 4-5-1
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 50, left = 300 },     -- Head6: Right midfielder
    { top = 50, left = 150 },     -- Head7: Central midfielder right
    { top = 50, left = 0 },       -- Head8: Central midfielder
    { top = 50, left = -150 },    -- Head9: Central midfielder left
    { top = 50, left = -300 },    -- Head10: Left midfielder
    { top = -20, left = 0 }       -- Head11: Striker
  },
  formation27 = { -- 5-2-1-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right wing-back
    { top = 150, left = 150 },    -- Head3: Center-back right
    { top = 150, left = 0 },      -- Head4: Center-back
    { top = 150, left = -150 },   -- Head5: Center-back left
    { top = 150, left = -300 },   -- Head6: Left wing-back
    { top = 50, left = 150 },     -- Head7: Central midfielder right
    { top = 50, left = -150 },    -- Head8: Central midfielder left
    { top = -20, left = 0 },      -- Head9: Attacking midfielder
    { top = -100, left = 150 },   -- Head10: Striker right
    { top = -100, left = -150 }   -- Head11: Striker left
  },
  formation29 = { -- 5-2-2-1
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right wing-back
    { top = 150, left = 150 },    -- Head3: Center-back right
    { top = 150, left = 0 },      -- Head4: Center-back
    { top = 150, left = -150 },   -- Head5: Center-back left
    { top = 150, left = -300 },   -- Head6: Left wing-back
    { top = 50, left = 150 },     -- Head7: Central midfielder right
    { top = 50, left = -150 },    -- Head8: Central midfielder left
    { top = -20, left = 200 },    -- Head9: Attacking midfielder right
    { top = -20, left = -200 },   -- Head10: Attacking midfielder left
    { top = -100, left = 0 }      -- Head11: Striker
  },
  formation31 = { -- 5-3-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right wing-back
    { top = 150, left = 150 },    -- Head3: Center-back right
    { top = 150, left = 0 },      -- Head4: Center-back
    { top = 150, left = -150 },   -- Head5: Center-back left
    { top = 150, left = -300 },   -- Head6: Left wing-back
    { top = 50, left = 250 },     -- Head7: Central midfielder right
    { top = 50, left = 0 },       -- Head8: Central midfielder
    { top = 50, left = -250 },    -- Head9: Central midfielder left
    { top = -20, left = 150 },    -- Head10: Striker right
    { top = -20, left = -150 }    -- Head11: Striker left
  },
  formation33 = { -- 5-4-1
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right wing-back
    { top = 150, left = 150 },    -- Head3: Center-back right
    { top = 150, left = 0 },      -- Head4: Center-back
    { top = 150, left = -150 },   -- Head5: Center-back left
    { top = 150, left = -300 },   -- Head6: Left wing-back
    { top = 50, left = 300 },     -- Head7: Right midfielder
    { top = 50, left = 150 },     -- Head8: Central midfielder right
    { top = 50, left = -150 },    -- Head9: Central midfielder left
    { top = 50, left = -300 },    -- Head10: Left midfielder
    { top = -20, left = 0 }       -- Head11: Striker
  },
  formation41 = { -- 4-1-4-1
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 100, left = 0 },      -- Head6: Defensive midfielder
    { top = 50, left = 300 },     -- Head7: Right midfielder
    { top = 50, left = 150 },     -- Head8: Central midfielder right
    { top = 50, left = -150 },    -- Head9: Central midfielder left
    { top = 50, left = -300 },    -- Head10: Left midfielder
    { top = -20, left = 0 }       -- Head11: Striker
  },
  formation43 = { -- 4-1-3-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 100, left = 0 },      -- Head6: Defensive midfielder
    { top = 50, left = 250 },     -- Head7: Central midfielder right
    { top = 50, left = 0 },       -- Head8: Central midfielder
    { top = 50, left = -250 },    -- Head9: Central midfielder left
    { top = -20, left = 150 },    -- Head10: Striker right
    { top = -20, left = -150 }    -- Head11: Striker left
  },
  formation61 = { -- 3-5-1-1
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 150 },    -- Head2: Center-back right
    { top = 150, left = 0 },      -- Head3: Center-back
    { top = 150, left = -150 },   -- Head4: Center-back left
    { top = 50, left = 300 },     -- Head5: Right wing-back
    { top = 50, left = 150 },     -- Head6: Central midfielder right
    { top = 50, left = 0 },       -- Head7: Central midfielder
    { top = 50, left = -150 },    -- Head8: Central midfielder left
    { top = 50, left = -300 },    -- Head9: Left wing-back
    { top = -20, left = 0 },      -- Head10: Attacking midfielder
    { top = -100, left = 0 }      -- Head11: Striker
  },
  formation63 = { -- 3-1-4-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 150 },    -- Head2: Center-back right
    { top = 150, left = 0 },      -- Head3: Center-back
    { top = 150, left = -150 },   -- Head4: Center-back left
    { top = 60, left = 0 },      -- Head5: Defensive midfielder
    { top = 30, left = 300 },     -- Head6: Right midfielder
    { top = 30, left = 150 },     -- Head7: Central midfielder right
    { top = 30, left = -150 },    -- Head8: Central midfielder left
    { top = 30, left = -300 },    -- Head9: Left midfielder
    { top = -100, left = 100 },    -- Head10: Striker right
    { top = -100, left = -100 }    -- Head11: Striker left
  },
  formation65 = { -- 4-2-4
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 50, left = 150 },     -- Head6: Central midfielder right
    { top = 50, left = -150 },    -- Head7: Central midfielder left
    { top = -20, left = 300 },    -- Head8: Right winger
    { top = -20, left = 150 },    -- Head9: Striker right
    { top = -20, left = -150 },   -- Head10: Striker left
    { top = -20, left = -300 }    -- Head11: Left winger
  },
  formation1 = { -- 3-4-1-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 150 },    -- Head2: Center-back right
    { top = 150, left = 0 },      -- Head3: Center-back
    { top = 150, left = -150 },   -- Head4: Center-back left
    { top = 50, left = 300 },     -- Head5: Right midfielder
    { top = 50, left = 150 },     -- Head6: Central midfielder right
    { top = 50, left = -150 },    -- Head7: Central midfielder left
    { top = 50, left = -300 },    -- Head8: Left midfielder
    { top = -20, left = 0 },      -- Head9: Attacking midfielder
    { top = -100, left = 150 },   -- Head10: Striker right
    { top = -100, left = -150 }   -- Head11: Striker left
  },
  formation3 = { -- 3-4-2-1
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 150 },    -- Head2: Center-back right
    { top = 150, left = 0 },      -- Head3: Center-back
    { top = 150, left = -150 },   -- Head4: Center-back left
    { top = 50, left = 300 },     -- Head5: Right midfielder
    { top = 50, left = 150 },     -- Head6: Central midfielder right
    { top = 50, left = -150 },    -- Head7: Central midfielder left
    { top = 50, left = -300 },    -- Head8: Left midfielder
    { top = -20, left = 200 },    -- Head9: Attacking midfielder right
    { top = -20, left = -200 },   -- Head10: Attacking midfielder left
    { top = -100, left = 0 }      -- Head11: Striker
  },
  formation5 = { -- 3-4-3
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 150 },    -- Head2: Center-back right
    { top = 150, left = 0 },      -- Head3: Center-back
    { top = 150, left = -150 },   -- Head4: Center-back left
    { top = 50, left = 300 },     -- Head5: Right midfielder
    { top = 50, left = 150 },     -- Head6: Central midfielder right
    { top = 50, left = -150 },    -- Head7: Central midfielder left
    { top = 50, left = -300 },    -- Head8: Left midfielder
    { top = -20, left = 300 },    -- Head9: Right winger
    { top = -20, left = 0 },      -- Head10: Striker
    { top = -20, left = -300 }    -- Head11: Left winger
  },
  formation7 = { -- 3-5-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 150 },    -- Head2: Center-back right
    { top = 150, left = 0 },      -- Head3: Center-back
    { top = 150, left = -150 },   -- Head4: Center-back left
    { top = 50, left = 300 },     -- Head5: Right wing-back
    { top = 50, left = 150 },     -- Head6: Central midfielder right
    { top = 50, left = 0 },       -- Head7: Central midfielder
    { top = 50, left = -150 },    -- Head8: Central midfielder left
    { top = 50, left = -300 },    -- Head9: Left wing-back
    { top = -20, left = 150 },    -- Head10: Striker right
    { top = -20, left = -150 }    -- Head11: Striker left
  },
  formation9 = { -- 4-1-2-1-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 100, left = 0 },      -- Head6: Defensive midfielder
    { top = 50, left = 150 },     -- Head7: Central midfielder right
    { top = 50, left = -150 },    -- Head8: Central midfielder left
    { top = -20, left = 0 },      -- Head9: Attacking midfielder
    { top = -100, left = 150 },   -- Head10: Striker right
    { top = -100, left = -150 }   -- Head11: Striker left
  },
  formation11 = { -- 4-2-3-1
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 50, left = 150 },     -- Head6: Central midfielder right
    { top = 50, left = -150 },    -- Head7: Central midfielder left
    { top = -20, left = 300 },    -- Head8: Right winger
    { top = -20, left = 0 },      -- Head9: Attacking midfielder
    { top = -20, left = -300 },   -- Head10: Left winger
    { top = -100, left = 0 }      -- Head11: Striker
  },
  formation13 = { -- 4-2-2-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 50, left = 150 },     -- Head6: Central midfielder right
    { top = 50, left = -150 },    -- Head7: Central midfielder left
    { top = -20, left = 200 },    -- Head8: Attacking midfielder right
    { top = -20, left = -200 },   -- Head9: Attacking midfielder left
    { top = -100, left = 150 },   -- Head10: Striker right
    { top = -100, left = -150 }   -- Head11: Striker left
  },
  formation15 = { -- 4-3-1-2
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 50, left = 250 },     -- Head6: Central midfielder right
    { top = 50, left = 0 },       -- Head7: Central midfielder
    { top = 50, left = -250 },    -- Head8: Central midfielder left
    { top = -20, left = 0 },      -- Head9: Attacking midfielder
    { top = -100, left = 150 },   -- Head10: Striker right
    { top = -100, left = -150 }   -- Head11: Striker left
  },
  formation17 = { -- 4-3-2-1
    { top = 250, left = 0 },      -- Head1: Goalkeeper
    { top = 150, left = 300 },    -- Head2: Right-back
    { top = 150, left = 100 },    -- Head3: Center-back right
    { top = 150, left = -100 },   -- Head4: Center-back left
    { top = 150, left = -300 },   -- Head5: Left-back
    { top = 50, left = 250 },     -- Head6: Central midfielder right
    { top = 50, left = 0 },       -- Head7: Central midfielder
    { top = 50, left = -250 },    -- Head8: Central midfielder left
    { top = -20, left = 200 },    -- Head9: Attacking midfielder right
    { top = -20, left = -200 },   -- Head10: Attacking midfielder left
    { top = -100, left = 0 }      -- Head11: Striker
  }
}

return Config