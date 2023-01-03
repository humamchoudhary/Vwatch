rl = "https://anime-db.p.rapidapi.com/anime"

    querystring = {"page":"1","size":"10","search":"Fullmetal","genres":"Fantasy,Drama","sortBy":"ranking","sortOrder":"asc"}

    headers = {
        "X-RapidAPI-Key": "5b11e8593fmshab74d27adfcb675p191bcajsn8b872311e950",
        "X-RapidAPI-Host": "anime-db.p.rapidapi.com"
    }

    response = requests.request("GET", url, headers=headers, params=querystring)

    print(response.text)