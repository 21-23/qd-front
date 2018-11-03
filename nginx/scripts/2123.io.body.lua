if ngx.ctx.authenticated == true then
    local headers = ngx.resp.get_headers()
    local location = headers["Location"]
    local base = os.getenv("2123_STATICS_PATH")

    local file = io.open(base .. location)
    local content = file:read("*all")
    file:close()

    ngx.arg[1] = content
    ngx.arg[2] = true
end
