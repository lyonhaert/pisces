function CardDataMgr() constructor {
	cardDataLookup = {}
	
	static AddCardData = function (card_data) {
		cardDataLookup[$ card_data.name] = card_data
	}
	
	static GetCardData = function (name) {
		return cardDataLookup[$ name]
	}
	
	static GetCardSprite = function (name) {
		var cd = cardDataLookup[$ name]
		if cd != undefined return cd.sprite_idx
	}
}

//do i need a separate mgr for card sprites? probably
function SpriteMgr() constructor {
	cardNameToFrontSprite = {}
	frontSpriteToCardInstances = {}
	frontSpriteToBackSprite = {}
	
	static RegisterSprites = function (cardName, frontSpriteIndex, backSpriteIndex = -1) {
		if !sprite_exists(frontSpriteIndex) return false
		
		if backSpriteIndex > 0 && !sprite_exists(backSpriteIndex) return false
		
		cardNameToFrontSprite[$ cardName] = frontSpriteIndex
		
		var fSprIdxStr = string(frontSpriteIndex)
		
		var cardInstancesLookup = frontSpriteToCardInstances[$ fSprIdxStr]
		if cardInstancesLookup == undefined {
			cardInstancesLookup = {}
			frontSpriteToCardInstances[$ fSprIdxStr] = cardInstancesLookup
		}
		
		if backSpriteIndex > 0 {
			frontSpriteToBackSprite[$ fSprIdxStr] = backSpriteIndex
			show_debug_message("mgr registered sprites " + fSprIdxStr + ":" + string(backSpriteIndex))
		} else {
			show_debug_message("mgr registered sprites " + fSprIdxStr + ":")
		}
		
		return true
	}
	
	static UnregisterSpriteUser = function (cardInst) {
		if !(instance_exists(cardInst) && cardInst.object_index == obj_card) return false
		
		var frontSpriteIndex = cardNameToFrontSprite[$ cardInst.name]
		
		if frontSpriteIndex == undefined return false
		var fSprIdxStr = string(frontSpriteIndex)
		
		var cardInstancesLookup = frontSpriteToCardInstances[$ fSprIdxStr]

		variable_struct_remove(cardInstancesLookup, string(cardInst.id))
		
		show_debug_message("mgr unregistered user " + string(cardInst.id) + " for front " + fSprIdxStr +
			", usercount: " + string(variable_struct_names_count(cardInstancesLookup)))
			
		if 0 == variable_struct_names_count(cardInstancesLookup) {
			variable_struct_remove(cardNameToFrontSprite, cardInst.name)
			
			if sprite_exists(frontSpriteIndex) {
				sprite_delete(frontSpriteIndex)
				show_debug_message("mgr unloaded front sprite " + fSprIdxStr)
			}
			
			var backSpriteIndex = frontSpriteToBackSprite[$ fSprIdxStr]
			if backSpriteIndex > 0 && sprite_exists(backSpriteIndex) {
				sprite_delete(backSpriteIndex)
				show_debug_message("mgr unloaded back sprite " + string(backSpriteIndex))
			}
		}
		
		return true
	}
	
	static RegisterCardSpriteUser = function (cardInst) {
		if !(instance_exists(cardInst) && cardInst.object_index == obj_card) return undefined
		
		var frontSpriteIndex = cardNameToFrontSprite[$ cardInst.name]

		var fSprIdxStr = string(frontSpriteIndex)
		
		var cardInstancesLookup = frontSpriteToCardInstances[$ fSprIdxStr]
		
		cardInstancesLookup[$ string(cardInst.id)] = true
		
		show_debug_message("mgr registered user " + string(cardInst.id) + " for front " + fSprIdxStr +
			", usercount: " + string(variable_struct_names_count(cardInstancesLookup)))
	}
	
	static GetCardSpriteByName = function (cardName, getBackFace = false) {
		var frontSpriteIndex = cardNameToFrontSprite[$ cardName]
		
		if !getBackFace return frontSpriteIndex
		
		return frontSpriteToBackSprite[$ string(frontSpriteIndex)]
	}
}

function gRegisterSprites(cardName, frontSpriteIndex, backSpriteIndex) {
	return obj_options.SpriteMgr.RegisterSprites(cardName, frontSpriteIndex, backSpriteIndex)
}
function gUnregisterSpriteUser(cardInst) {
	return obj_options.SpriteMgr.UnregisterSpriteUser(cardInst)
}
function gRegisterCardSpriteUser(cardInst) {
	return obj_options.SpriteMgr.RegisterCardSpriteUser(cardInst)
}
function gGetCardSpriteByName(cardName, getBackFace = false) {
	return obj_options.SpriteMgr.GetCardSpriteByName(cardName, getBackFace)
}