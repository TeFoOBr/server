local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)          npcHandler:onCreatureAppear(cid)               end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)  npcHandler:onCreatureSay(cid, type, msg)       end

local lastSound = 0

function onThink()
	if lastSound < os.time() then
		lastSound = (os.time() + 5)
		if math.random(100) < 25 then
			Npc():say('Passages to Thais, Carlin, Ab\'Dendriel, Port Hope, Edron, Darashia, Liberty Bay, Svargrond, Gray Island, Yalahar and Ankrahmun.', TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

-- Travel
local function addTravelKeyword(keyword, cost, destination)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to ' .. keyword:titleCase() .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, cost = cost, discount = 'postman', destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
end

addTravelKeyword('thais', 170, Position(32310, 32210, 6))
addTravelKeyword('carlin', 130, Position(32387, 31820, 6))
addTravelKeyword('gray island', 150, Position(33196, 31984, 7))
addTravelKeyword('ab\'dendriel', 90, Position(32734, 31668, 6))
addTravelKeyword('edron', 40, Position(33173, 31764, 6))
addTravelKeyword('port hope', 160, Position(32527, 32784, 6))
addTravelKeyword('svargrond', 150, Position(32341, 31108, 6))
addTravelKeyword('liberty bay', 180, Position(32285, 32892, 6))
addTravelKeyword('yalahar', 185, Position(32816, 31272, 6))
addTravelKeyword('ankrahmun', 150, Position(33092, 32883, 6))

-- Darashia
local travelNode = keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to Darashia for |TRAVELCOST|?', cost = 60, discount = 'postman'})
	local childTravelNode = travelNode:addChildKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, text = 'I warn you! This route is haunted by a ghostship. Do you really want to go there?'})
		childTravelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, cost = 60, discount = 'postman', destination = function(player) return math.random(10) == 1 and Position(33324, 32173, 6) or Position(33289, 32481, 6) end})
		childTravelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, reset = true, text = 'We would like to serve you some time.'})
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, reset = true, text = 'We would like to serve you some time.'})

keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Thais}, {Carlin}, {Ab\'Dendriel}, {Port Hope}, {Edron}, {Darashia}, {Liberty Bay}, {Svargrond}, {Yalahar}, {Gray Island} or {Ankrahmun}?'})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Thais}, {Carlin}, {Ab\'Dendriel}, {Port Hope}, {Edron}, {Darashia}, {Liberty Bay}, {Svargrond}, {Yalahar}, {Gray Island} or {Ankrahmun}?'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this ship.'})
keywordHandler:addKeyword({'captain'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this ship.'})
keywordHandler:addKeyword({'venore'}, StdModule.say, {npcHandler = npcHandler, text = 'This is Venore. Where do you want to go?'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'My name is Captain Fearless from the Royal Tibia Line.'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome on board, |PLAYERNAME|. Where can I {sail} you today?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye. Recommend us if you were satisfied with our service.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')

npcHandler:addModule(FocusModule:new())
