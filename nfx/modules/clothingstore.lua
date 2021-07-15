if cfg["clothingstore"].active then

    local function parse_part(key)
        if type(key) == "string" and string.sub(key,1,1) == "p" then
            return true,tonumber(string.sub(key,2))
        else
            return false,tonumber(key)
        end
    end

    function nFX.openSkinshop(parts,src)
        local source = src or source
        local playertable = nFX.getPlayer(source)
        if playertable then

            local old_custom = nFXcli.getClothes(source)
            old_custom.modelhash = nil

            local menudata = { name = "Loja de Roupas" }

            local drawables = {}
            local textures = {}
            
            local ontexture = function(player,choice)
                
                local texture = textures[choice]
                texture[1] = texture[1]+1
                if texture[1] >= texture[2] then
                    texture[1] = 0
                end

                local custom = {}
                custom[parts[choice]] = { drawables[choice][1],texture[1] }
                nFXcli._setClothes(source,custom)

            end

            local ondrawable = function(player, choice, mod)
                
                if mod == 0 then
                    ontexture(player,choice)
                else
                    local isprop, index = parse_part(parts[choice])
                    local drawable = drawables[choice]
                    drawable[1] = drawable[1]+mod

                    if isprop then
                        if drawable[1] >= drawable[2] then
                            drawable[1] = -1
                        elseif drawable[1] < -1 then
                            drawable[1] = drawable[2]-1
                        end 
                    else
                        if drawable[1] >= drawable[2] then
                            drawable[1] = 0
                        elseif drawable[1] < 0 then
                            drawable[1] = drawable[2]
                        end 
                    end

                    local custom = {}
                    custom[parts[choice]] = { drawable[1],textures[choice][1] }
                    nFXcli.setClothes(source,custom)

                    local n = nFXcli.getDrawableTextures(source,parts[choice],drawable[1])
                    textures[choice][2] = n

                    if textures[choice][1] >= n then
                        textures[choice][1] = 0
                    end
                end
            end

            for k,v in pairs(parts) do
                drawables[k] = { 0,0 }
                textures[k] = { 0,0 }

                local old_part = old_custom[v]
                if old_part then
                    drawables[k][1] = old_part[1]
                    textures[k][1] = old_part[2]
                end

                async(function()
                    drawables[k][2] = nFXcli.getDrawables(source,v)
                    textures[k][2] = nFXcli.getDrawableTextures(source,v,drawables[k][1])
                end)
                menudata[k] = { ondrawable }
            end

            menudata.onclose = function(player)
                local custom = nFXcli.getClothes(source)
                local price = 0
                custom.modelhash = nil
                for k,v in pairs(custom) do
                    local old = old_custom[k]
                    if v[1] ~= old[1] then
                        price = price + 20
                    end
                    if v[2] ~= old[2] then
                        price = price + 5
                    end
                end

                if playertable.tryPayment(price) then
                    if price > 0 then
                        TriggerClientEvent("Notify",source,"success","Comprou <b>$"..parseInt(price).."</b> em roupas e acessórios.")
                    end
                else
                    TriggerClientEvent("Notify",source,"deny","Dinheiro insuficiente.")
                    nFXcli._setClothes(source,old_custom)
                end
            end

            nFX.openMenu(source,menudata)

        end
    end

    nFXsrv.openSkinshop = nFX.openSkinshop

    AddEventHandler("nFX:playerSpawned",function()
        nFXcli.initClothesShop(source,cfg["clothingstore"].skinshops)
    end)
end