function nFX.getPlayersByGroupLevel(group,level,activeonly,notbusy)
    if group and level then
        local cb = {}
        for src,data in pairs(nFX.players) do
            if data.haveGroupLevel(group,level,activeonly) then   
                if notbusy ~= nil then
                    if notbusy and (not data.isGroupBusy(group)) then
                        cb[src] = data.player_id
                    end
                else
                    cb[src] = data.player_id
                end
            end
        end
        return cb
    end
end
function nFX.getPlayersByGroup(group,activeonly,notbusy)
    if group and level then
        local cb = {}
        for src,data in pairs(nFX.players) do 
            if data.isInGroup(group,activeonly) then
                if notbusy ~= nil then
                    if notbusy and (not data.isGroupBusy(group)) then
                        cb[src] = data.player_id
                    end
                else
                    cb[src] = data.player_id
                end
            end
        end
        return cb
    end
end
function nFX.getPlayersByGroups(groups,activeonly,notbusy)
    local cb = {}
    for src,data in pairs(nFX.players) do
        for _,group in ipairs(groups) do
            if (type(group) == "table") then
                if group.name and group.level then 
                    if data.haveGroupLevel(group.name,group.level,activeonly) then
                        if notbusy ~= nil then
                            if notbusy and (not data.isGroupBusy(group)) then
                                cb[src] = data.player_id
                            end
                        else
                            cb[src] = data.player_id
                        end
                    end            
                end
            else
                if data.isInGroup(group) then
                    if notbusy ~= nil then
                        if notbusy and (not data.isGroupBusy(group)) then
                            cb[src] = data.player_id
                        end
                    else
                        cb[src] = data.player_id
                    end
                end
            end            
        end
    end
    return cb
end