# Use case en opleverchecklist: time

## Use case

- **Voor wie:** elke medewerker die in de chat iets met een datum of een termijn vraagt.
- **Wat:** de assistent kan de datum en tijd van nu opvragen en ermee rekenen, bijvoorbeeld "welke datum is het over zes weken?".
- **Waarom een app:** een taalmodel weet niet welke dag het is en rekent onbetrouwbaar met datums.

## Testdata

Geen. De app gebruikt alleen de klok van de pod.

Testvraag: "Hoe laat is het nu in Amsterdam, en welke datum is het over 45 dagen?"

## Controles

| Controle | Wat ze aantoont | Hoe |
|---|---|---|
| `aanwezig` | De app draait en de server meldt vijf tools | `controles/aanwezig.sh [namespace]` |
| `afwezig` | Zonder de app draait er niets van: geen pod, geen Service, geen regel in de chat | `controles/afwezig.sh [namespace]` |
| Met de hand | De testvraag in de chat: het antwoord toont een toolaanroep | alleen met een model dat tools kan aanroepen |

## Korte check

| Vraag | Antwoord |
|---|---|
| Verwerkt de app persoonsgegevens? | Nee |
| Gaat er iets naar een externe dienst of een ander taalmodel? | Nee. De pod mag geen verbinding naar buiten maken |
| Bewaart de app iets? | Nee |
| Welke Secrets zijn nodig? | Geen |
| Wat ziet het taalmodel van de app? | De namen en beschrijvingen van vijf tools, en hun antwoorden |
| Van wie is de server? | Een klein communityproject. Het image staat vast op een digest |

## Bewijs

| Versie | Datum | `aanwezig` | `afwezig` | In de chat |
|---|---|---|---|---|
| 1.0.0 | 27 november 2026 | nog niet afgerond | nog niet afgerond | niet getest: het stubmodel kan geen tools aanroepen |
