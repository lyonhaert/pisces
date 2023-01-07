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
	
	static RegisterSprite = function (firstCardInst, frontSpriteIndex, backSpriteIndex = 0) {
		if !(instance_exists(firstCardInst) && firstCardInst.object_index == obj_card) return false
		
		if !sprite_exists(frontSpriteIndex) return false
		
		if backSpriteIndex && !sprite_exists(backSpriteIndex) return false
		
		cardNameToFrontSprite[$ firstCardInst.name] = frontSpriteIndex
		
		var fSprIdxStr = string(frontSpriteIndex)
		
		var cardIntancesLookup = frontSpriteToCardInstances[$ fSprIdxStr]
		if cardInstancesLookup == undefined {
			cardInstancesLookup = {}
			frontSpriteToCardInstances[$ fSprIdxStr] = cardInstancesLookup
		}
		
		cardInstancesLookup[$ string(firstCardInst.id)] = true
		
		frontSpriteToBackSprite[$ fSprIdxStr] = backSpriteIndex
		
		return true
	}
	
	static UnregisterSpriteUser = function (cardInst) {
		if !(instance_exists(cardInst) && cardInst.object_index == obj_card) return false
		
		var frontSpriteIndex = cardNameToFrontSprite[$ cardInst.name]
		
		if frontSpriteIndex == undefined return false
		var fSprIdxStr = string(frontSpriteIndex)
		
		var cardInstancesLookup = frontSpriteToCardInstances[$ fSprIdxStr]

		variable_struct_remove(cardInstancesLookup, fSprIdxStr)
		
		if 0 == variable_struct_names_count(cardInstancesLookup) {
			variable_struct_remove(cardNameToFrontSprite, cardInst.name)
			
			if sprite_exists(frontSpriteIndex) sprite_delete(frontSpriteIndex)
			
			var backSpriteIndex = frontSpriteToBackSprite[$ fSprIdxStr]
			if backSpriteIndex && sprite_exists(backSpriteIndex) sprite_delete(backSpriteIndex)
		}
		
		return true
	}
	
	static RegisterCardGetSprites = function (cardInst) {
		if !(instance_exists(cardInst) && cardInst.object_index == obj_card) return undefined
		
		var frontSpriteIndex = cardNameToFrontSprite[$ cardInst.name]

		if frontSpriteIndex == undefined return undefined
		var fSprIdxStr = string(frontSpriteIndex)
		
		var cardInstancesLookup = frontSpriteToCardInstances[$ fSprIdxStr]
		
		cardInstancesLookup[$ string(cardInst.id)] = true
		
		var backSpriteIndex = frontSpriteToBackSprite[$ fSprIdxStr]
		
		return {
			frontSpriteIdx: frontSpriteIndex,
			backSpriteIdx: backSpriteIndex
		}
	}
}