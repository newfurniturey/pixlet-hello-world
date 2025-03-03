load("cache.star", "cache")
load("encoding/base64.star", "base64")
load("qrcode.star", "qrcode")
load("render.star", "render")

def main(config):
    url = "https://waffles.dev/?utm_source=pixlet_example"
    
    data = cache.get(url)
    if data == None:
        code = qrcode.generate(
            url = url,
            size = "large",
            color = "#fff",
            background = "#000",
        )
        cache.set(url, base64.encode(code), ttl_seconds = 3600)
    else:
        code = base64.decode(data)
    
    return render.Root(
        child = render.Box(
            child = render.Padding(
                child = render.Image(src = code),
                pad = 1,
            ),
        ),
    )
