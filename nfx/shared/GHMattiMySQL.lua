if IsDuplicityVersion() then
   
    local API = exports["ghmattimysql"]

    if (not API) then
        error("exports of GHMattiMySQL not found!")
    end

    local queries = {}
    return { 
        prepare = function(name,query)
            if (type(name) ~= "string") then
                error("invalid prepare [name] => string expected, got "..type(name))
                return
            end
            if (type(query) ~= "string") then
                error("invalid prepare [query]  => string expected, got "..type(name))
                return
            end
            queries[name] = query
        end,
        query = function(name,params)
            local query = queries[name]
            if query then

                local r = async()
                API:execute(query,params or {},function(result)
                    r(result)
                end)
                return r:wait()
                
            else
                error("invalid query detected! => "..tostring(name))
            end
        end,
        execute = function(name,params)
            local query = queries[name]
            if query then

                local r = async()
                API:execute(query,params or {},function(result)
                    r(result)
                end)
                return r:wait()

            else
                error("invalid query detected! => "..tostring(name))
            end
        end,
        scalar = function(name,params)
            local query = queries[name]
            if query then

                local r = async()
                API:scalar(query,params or {},function(result)
                    r(result)
                end)
                return r:wait()

            else
                error("invalid query detected! => "..tostring(name))
            end
        end,
    }
else
    error("this module (shared/GHMattiMySQL) is not available on the client!")
end