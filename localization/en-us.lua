return {
	["misc"] = {
		["suits_plural"] = {
			["BBB_Swords"] = bbb_lang.english_names and "Swords" or "Spade",
			["BBB_Cups"] = bbb_lang.english_names and "Cups" or "Coppe",
			["BBB_Coins"] = bbb_lang.english_names and "Coins" or "Denari",
			["BBB_Staves"] = bbb_lang.english_names and "Staves" or "Bastoni",
		},

		["suits_singular"] = {
			["BBB_Swords"] = bbb_lang.english_names and "Sword" or "Spada",
			["BBB_Cups"] = bbb_lang.english_names and "Cup" or "Coppa",
			["BBB_Coins"] = bbb_lang.english_names and "Coin" or "Denaro",
			["BBB_Staves"] = bbb_lang.english_names and "Staff" or "Bastone",
		},
	},

	["descriptions"] = {
		["Back"] = {
			["b_BBB_scopa"] = {
				["name"] = "Scopa Deck",
				["text"] = {
					"Start the run with",
					"{C:red,E:1,S:1.1}" .. (bbb_lang.english_names and "Cups" or "Coppe") .. "{}, " ..
					"{C:blue,E:1,S:1.1}" .. (bbb_lang.english_names and "Swords" or "Spade") .. "{}," ,
					"{C:attention,E:1,S:1.1}" .. (bbb_lang.english_names and "Coins" or "Denari") .. "{} and " ..
					"{C:green,E:1,S:1.1}" .. (bbb_lang.english_names and "Staves" or "Bastoni") .. "{} suits.",
				},
			},
		},
	},
}