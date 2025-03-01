load("render.star", "render")
load("http.star", "http")

COINDESK_PRICE_URL = "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD"

def main():
    rep = http.get(COINDESK_PRICE_URL)
    if rep.status_code != 200:
        fail("Coindesk request failed with status %d", rep.status_code)
       
    rate = rep.json()["USD"]
    
    return render.Root(
        child = render.Text("BTC: %d USD" % rate)
    )
