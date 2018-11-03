if ngx.status == 305 then
    ngx.ctx.authenticated = true
    ngx.status = ngx.HTTP_OK
elseif ngx.status == 401 then
    ngx.status = ngx.HTTP_MOVED_TEMPORARILY
end