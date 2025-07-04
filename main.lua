-- sprites
SMODS.Atlas { key = 'lc_cards', path = '8BitDeck.png', px = 71, py = 95 }
SMODS.Atlas { key = 'hc_cards', path = '8BitDeck_opt2.png', px = 71, py = 95 }
SMODS.Atlas { key = 'lc_ui', path = 'ui_assets.png', px = 18, py = 18 }
SMODS.Atlas { key = 'hc_ui', path = 'ui_assets_opt2.png', px = 18, py = 18 }
SMODS.Atlas { key = 'Decks', path = 'Decks.png', px = 71, py = 95 }


local bbb_mod = SMODS.current_mod

--english toggle
bbb_lang = bbb_mod.config
function bbb_mod.reload_localization()
	SMODS.handle_loc_file(bbb_mod.path)
	return init_localization()
end
--allow suit
local function allow_suits(self, args)
    if args and args.initial_deck then
        return bbb_mod.config.allow_all_suits
    end
    return true
end

-- suits

local cups_suit = SMODS.Suit {  
    key = 'Cups',  
    card_key = 'COP',  
    hc_atlas = 'hc_cards',  
    lc_atlas = 'lc_cards',  
    hc_ui_atlas = 'hc_ui',  
    lc_ui_atlas = 'lc_ui',  
    pos = { y = 0 },  
    ui_pos = { x = 3, y = 0 }, 
    hc_colour = HEX('C00000'), -- red
    lc_colour = HEX('C00000'),  
    in_pool = allow_suits  
}  

local staves_suit = SMODS.Suit {  
    key = 'Staves',  
    card_key = 'BAS',  
    hc_atlas = 'hc_cards',  
    lc_atlas = 'lc_cards',  
    hc_ui_atlas = 'hc_ui',  
    lc_ui_atlas = 'lc_ui',  
    pos = { y = 1 },  
    ui_pos = { x = 2, y = 0 }, 
    hc_colour = HEX('00A550'), -- green
    lc_colour = HEX('00A550'),  
    in_pool = allow_suits  
}  

local coins_suit = SMODS.Suit {  
    key = 'Coins',  
    card_key = 'DEN',  
    hc_atlas = 'hc_cards',  
    lc_atlas = 'lc_cards',  
    hc_ui_atlas = 'hc_ui',  
    lc_ui_atlas = 'lc_ui',  
    pos = { y = 2 },  
    ui_pos = { x = 1, y = 0 }, 
    hc_colour = HEX('FFCC00'), -- yellow
    lc_colour = HEX('FFCC00'),  
    in_pool = allow_suits  
}  

local swords_suit = SMODS.Suit {  
    key = 'Swords',  
    card_key = 'SPA',  
    hc_atlas = 'hc_cards',  
    lc_atlas = 'lc_cards',  
    hc_ui_atlas = 'hc_ui',  
    lc_ui_atlas = 'lc_ui',  
    pos = { y = 3 },  
    ui_pos = { x = 0, y = 0 },   
    hc_colour = HEX('0070C0'), -- blue
    lc_colour = HEX('0070C0'),  
    in_pool = allow_suits  
}

--ranks

-- Fante
SMODS.Rank {
    key = 'Knave',
    card_key = 'F',
    pos = { x = 6 },
    nominal = 8,
    face_nominal = 0.05,
    face = true,
    shorthand = bbb_lang.english_name and 'Knv' or 'F',
    next = { 'Knight' },
    loc_txt = { name = bbb_lang.english_name and 'Knave' or 'Fante' },
    in_pool = allow_suits
}

-- Cavallo
SMODS.Rank {
    key = 'Knight',
    card_key = 'C',
    pos = { x = 7 },
    nominal = 9,
    face_nominal = 0.1,
    face = true,
    shorthand = bbb_lang.english_name and 'Knt' or 'C',
    next = { 'King' },
    loc_txt = { name = bbb_lang.english_name and 'Knight' or 'Cavallo' },
    in_pool = allow_suits
}

-- Re
SMODS.Rank {
    key = 'King',
    card_key = 'R',
    pos = { x = 8 },
    nominal = 10,
    face_nominal = 0.15,
    face = true,
    shorthand = bbb_lang.english_name and 'Ki' or 'R',
    next = { 'Ace' },
    loc_txt = { name = bbb_lang.english_name and 'King' or 'Re' },
    in_pool = allow_suits
}

-- Asso
SMODS.Rank {
    key = 'Ace',
    card_key = 'Ac',
    pos = { x = 9 },
    nominal = 1,
    face_nominal = 0.2,
    face = false,
    shorthand = bbb_lang.english_name and 'Ac' or 'As',
    straight_edge = true,
    next = { '2' },
    loc_txt = { name = bbb_lang.english_name and 'Ace' or 'Asso' },
    in_pool = allow_suits
}

-- deck

SMODS.Back {
    key = "scopa",
    atlas = 'Decks',
    pos = { x = 0, y = 0 },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Spades' then
                        v:change_suit("BBB_Swords")
                    elseif v.base.suit == 'Hearts' then
                        v:change_suit("BBB_Cups")
                    elseif v.base.suit == 'Diamonds' then
                        v:change_suit("BBB_Coins")
                    elseif v.base.suit == 'Clubs' then
                        v:change_suit("BBB_Staves")
                    end
                end
                G.GAME.starting_params.scopa_Deck = true
                return true
            end
        }))
    end,
}

bbb_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {align = "m", r = 0.1, padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 6}, nodes = {
        {n = G.UIT.R, config = {align = "cl", padding = 0, minh = 0.1}, nodes = {}},

        -- Toggle Allow All Suits
        {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = bbb_mod.config, ref_value = "allow_all_suits" },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "Allow All Suits ", scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},

-- Toggle English Ranks
        {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = bbb_mod.config, ref_value = "english_names", callback = bbb_mod.reload_localization },
            }},
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "Use English Names for Ranks/Suits", scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
        }},
    }
}
end

logo = "balatro.png"

SMODS.Atlas {
		key = "balatro",
		path = logo,
		px = 530,
		py = 230,
		prefix_config = { key = false }
	}
----------------------------------------------
------------MOD CODE END---------------------