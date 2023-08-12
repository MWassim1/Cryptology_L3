#! /bin/bash
if [[ $# -ne 2 && $# -ne 0 ]]; then
    echo "Usage   nettoie <fichier_à_nettoyer> <fichier_nettoyé>"
    echo "ou      nettoie <<< \"<chaîne à nettoyer>\""
    exit 1
fi

if [[ $# -eq 2 ]]; then

    if file $1 | grep -q -F 'UTF-8'
    then enc="UTF8"
    elif file $1 | grep -q -F 'ISO-8859'
    then enc="ISO88591"
    elif file $1 | grep -q -F 'ASCII'
    then enc="ascii"
    else echo "Encodage inconnu"; exit 1
    fi
    iconv -f $enc -t ascii//TRANSLIT $1 | tr 'a-z' 'A-Z' | tr -d -c 'A-Z' > $2
    
else
    iconv -t ascii//TRANSLIT | tr 'a-z' 'A-Z' | tr -d -c 'A-Z'
fi
