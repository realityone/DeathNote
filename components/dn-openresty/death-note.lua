local http = require "resty.http"
local json = require "cjson"

local etcd_url = os.getenv('ETCD_URL')
local etcd_api_prefix = "/v2/keys"
local containers_dir = "/death-note/v1/containers/"

local duration = 1;

local function etcd_client()
    if etcd_url == nil then
      ngx.log(ngx.ERR, "environment ETCD_URL is missed.")
      ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
    else
      ngx.log(ngx.ERR, "ETCD_URL: " .. etcd_url)
    end

    local c = http:new()

    c:set_timeout(60000)
    return c
end

local function etcd_api_path(resource_path)
    return etcd_url .. etcd_api_prefix .. resource_path
end

local function ttl_data(duration)
    return "ttl=" .. duration
end

local function request_etcd()
    local container_uri = etcd_api_path(containers_dir .. ngx.var.container_id) 
    ngx.log(ngx.ERR, container_path)
    
    local etcdc = etcd_client() 
    local resp, err = etcdc:request_uri(container_uri, {method="GET"})
    if resp.status == 404 then
        local resp, err = etcdc:request_uri(container_uri, {method="PUT", body=ttl_data(duration), headers={["Content-Type"]="application/x-www-form-urlencoded"}})
        ngx.log(ngx.ERR, "Container Id not exist")
    else
       local resp_data = json.decode(resp.body)
       local node = resp_data["node"]
       if node["ttl"] ~= nil then
           node["ttl"] = tonumber(node["ttl"]) + duration 
       end
       local ttl = tostring(node["ttl"])
       local resp, err = etcdc:request_uri(container_uri, {method="PUT", body=ttl_data(ttl), headers={["Content-Type"]="application/x-www-form-urlencoded"}})
    end 
    ngx.log(ngx.ERR, container_uri)
end

request_etcd()
