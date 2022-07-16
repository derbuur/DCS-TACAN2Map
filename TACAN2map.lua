-- TACAN2map by buur. This script prints the position and frequencies of the mobile TACAN on the map.


--trigger.action.outText(mist.utils.tableShow(myTACANS,';'), 100, false)

function getTableSize(t)
    local count = 0
    for _, __ in pairs(t) do
        count = count + 1
    end
    return count
end 

for i = 0, 2, 1 do
	local myCoalition= {[0]= "neutral", [1]= "red", [2] = "blue"}
	local myTACANS = mist.getUnitsByAttribute({typeName = 'TACAN_beacon', coalition = myCoalition[i]}, 2, false) --, coalition = "blue"

	for ke,val in pairs(myTACANS) 
			do
			--trigger.action.outText(val, 100, false)
			--trigger.action.outText(mist.utils.tableShow(Unit.getByName(val):getPoint()), 100, false)
			local id_table = world.getMarkPanels( )

			local size_id_table = getTableSize(id_table)
			
			--local actualTACAN = val:getGroup():getName()
			local actualTACAN_group = Unit.getByName(val):getGroup():getName()
			
			
			
			local t=mist.getGroupRoute( actualTACAN_group , true )[1]["task"]["params"]["tasks"]

			for key,value in pairs(t) 
					do
						if t[key]["id"] == "WrappedAction" then
							if t[key]["params"]["action"]["params"]["channel"] 
								then TCN_channel = t[key]["params"]["action"]["params"]["channel"] 
								else TCN_channel = "N/A" 
							end
						
							if t[key]["params"]["action"]["params"]["modeChannel"] 
								then TCN_modeChannel = t[key]["params"]["action"]["params"]["modeChannel"] 
								else TCN_modeChannel = "N/A" 
							end
						
							if t[key]["params"]["action"]["params"]["callsign"] 
								then TCN_callsign = t[key]["params"]["action"]["params"]["callsign"] 
								else TCN_callsign = "N/A" 
							end
							msgstr = "TCN: "..TCN_channel..TCN_modeChannel.." "..TCN_callsign
						else
							msgstr = "no information"
						end
					end
						
			
			
			
			
			trigger.action.textToAll(
			i,
			size_id_table + ke,
			Unit.getByName(val):getPoint(),
			{0,0,0, 1},
			{0.8,0.8,0.8,1},
			11,
			true,
			"©"..msgstr--..v["callsignStr"]
			)
		
		end
end