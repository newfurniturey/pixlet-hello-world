load("render.star", "render")
load("http.star", "http")
load("encoding/base64.star", "base64")

COINDESK_PRICE_URL = "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD"

# Load Bitcoin icon from base64 encoded data
BTC_ICON = base64.decode("""
iVBORw0KGgoAAAANSUhEUgAAABEAAAARCAYAAAA7bUf6AAAAlklEQVQ4T2NkwAH+H2T/jy7FaP+
TEZtyDEG4Zi0TTPXXzoDF0A1DMQRsADbN6MZdO4NiENwQbAbERh1lWLzMmgFGo5iFZBDYEFwuwG
sISCPUIKyGgDRjAyBXYXMNIz5XgDQga8TpLboYgux8DO/AwoUuLiEqTLBFMcmxQ7V0gssgklIsL
AYozjsoBoE45OZi5DRBSnkCAMLhlPBiQGHlAAAAAElFTkSuQmCC
""")

def main():
    rep = http.get(COINDESK_PRICE_URL, ttl_seconds = 240)
    if rep.status_code != 200:
        fail("Coindesk request failed with status %d", rep.status_code)
       
    rate = rep.json()["USD"]
    
    # for dev purposes only!
    if rep.headers.get("Tidbyt-Cache-Status") == "HIT":
        print("Hit! Displaying cached data.")
    else:
        print("Miss! Calling CoinDesk API.")
    
    return render.Root(
        child = render.Box(
            render.Row(
                expanded=True,
                main_align="space_evenly",
                cross_align="center",
                children = [
                    render.Image(src=BTC_ICON),
                    render.Text("$%d" % rate),
                ],
            )
        )
    )
