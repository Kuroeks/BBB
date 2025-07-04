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
    pos = { x = 9 },
    nominal = 8,
    face_nominal = 0.05,
    face = true,
    shorthand = bbb_lang.english_names and 'Knv' or 'F',
    next = { 'BBB_Knight' },
    loc_txt = { name = bbb_lang.english_names and 'Knave' or 'Fante' },
    in_pool = allow_suits
}

-- Cavallo
SMODS.Rank {
    key = 'Knight',
    card_key = 'C',
    pos = { x = 10 },
    nominal = 9,
    face_nominal = 0.1,
    face = true,
    shorthand = bbb_lang.english_names and 'Knt' or 'C',
    next = { 'BBB_King' },
    loc_txt = { name = bbb_lang.english_names and 'Knight' or 'Cavallo' },
    in_pool = allow_suits
}

-- Re
SMODS.Rank {
    key = 'King',
    card_key = 'R',
    pos = { x = 11 },
    nominal = 10,
    face_nominal = 0.15,
    face = true,
    shorthand = bbb_lang.english_names and 'Ki' or 'R',
    next = { 'BBB_Ace' },
    loc_txt = { name = bbb_lang.english_names and 'King' or 'Re' },
    in_pool = allow_suits
}

-- Asso
SMODS.Rank {
    key = 'Ace',
    card_key = 'Ac',
    pos = { x = 12 },
    nominal = 1,
    face_nominal = 0.2,
    face = false,
    shorthand = bbb_lang.english_names and 'Ac' or 'As',
    straight_edge = true,
    next = { '2' },
    loc_txt = { name = bbb_lang.english_names and 'Ace' or 'Asso' },
    in_pool = allow_suits
}

-- Deck

SMODS.Back {
    key = "scopa",
    atlas = 'Decks',
    pos = { x = 0, y = 0 },
    apply = function(self)

-- Erase Faces
	G.E_MANAGER:add_event(Event({
	    func = function()
	        for i = #G.playing_cards, 1, -1 do
	            local id = G.playing_cards[i]:get_id()
	            if id == 11 or id == 12 or id == 13 then
	                G.playing_cards[i]:start_dissolve(nil, true)
	            end
	        end
	        return true
	    end
}))

-- Conversion
    G.E_MANAGER:add_event(Event({
    	delay = 0.5,
        func = function()
            for k, v in pairs(G.playing_cards) do
                -- Suit
                local s = v.base.suit
                local target_suit = ({
                    Spades = "BBB_Swords",
                    Hearts = "BBB_Cups",
                    Diamonds = "BBB_Coins",
                    Clubs = "BBB_Staves"
                })[s]
                if target_suit then
                    v:change_suit(target_suit)
                end

                -- Rank
                local id = v:get_id()
                if id == 8 then
                    SMODS.change_base(v, nil, "BBB_Knave")
                elseif id == 9 then
                    SMODS.change_base(v, nil, "BBB_Knight")
                elseif id == 10 then
                    SMODS.change_base(v, nil, "BBB_King")
                    elseif id == 14 then
                    SMODS.change_base(v, nil, "BBB_Ace")
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
