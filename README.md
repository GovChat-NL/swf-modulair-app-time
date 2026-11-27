> # ⚠️ LET OP: tijdelijke naam
> Deze repository heet nu `modulair-app-time` omdat dit een pilot is voor een modulaire GovChat,
> gestart door Súdwest-Fryslân met toestemming van GovChat-NL. Werkt de pilot en is iedereen
> het eens, dan kan de naam in de toekomst `GovChat-NL-app-time` worden.

# modulair-app-time

De proefapp van de modulaire GovChat: vijf tools voor datums en tijden, zodat een assistent
weet welke dag het is. De app is klein gehouden om de hele route te beproeven: repository,
versie, samenstellen en uitrol. Het is ook het voorbeeld van hoe een app eruitziet.

De server is [`mcp-time`](https://github.com/TheoBrigitte/mcp-time), een klein
communityproject. Het is bedoeld om de route te beproeven, niet als productkeuze.

Dit is één van vier repositories die bij elkaar horen:

| Repository | Wat |
|---|---|
| [`modulair-kern`](https://github.com/GovChat-NL/modulair-kern) | de kale chat |
| [`modulair-app-time`](https://github.com/GovChat-NL/modulair-app-time) | de proefapp, en het voorbeeld van hoe een app eruitziet |
| [`modulair-manager`](https://github.com/GovChat-NL/modulair-manager) | de app-manager, die de uitrol samenstelt; hier staat ook het appcontract |
| [`modulair-deploy-template`](https://github.com/GovChat-NL/modulair-deploy-template) | de uitrolbasis waar een organisatie één keer een eigen repository van maakt |

## Wat erin zit

| Waar | Wat |
|---|---|
| `app.yaml` | Wat de app is en wat hij nodig heeft, volgens het [appcontract](https://github.com/GovChat-NL/modulair-manager/blob/main/CONTRACT.md) |
| `chart/` | De Helm-chart: een Deployment, een Service en een NetworkPolicy |
| `USECASE.md` | De use case, de testdata, de korte check en het bewijs |
| `controles/aanwezig.sh` | Toont aan dat de app draait en zijn vijf tools meldt |
| `controles/afwezig.sh` | Toont aan dat er zonder de app niets van draait |

## Gebruiken

Zet het adres en de versie in de lijst van je uitrolrepository en stel opnieuw samen:

```yaml
# stacks/<omgeving>.yaml
apps:
  - url: https://github.com/GovChat-NL/modulair-app-time
    version: v1.0.0
```

Er is niets in te stellen en er is geen Secret nodig.

## Gegevens

De app bewaart niets en maakt geen verbinding naar buiten. De NetworkPolicy laat alleen
LibreChat toe. De beschrijvingen van de vijf tools gaan bij elke vraag mee naar het
taalmodel (ongeveer 2.200 tokens).

## Versies

| Wat | Nu |
|---|---|
| De app | `1.0.0` |
| Het image | `docker.io/theo01/mcp-time:0.4.0`, vastgezet op de digest |

## Herkomst

Gevuld vanuit `apps/mcp-time` van de branch `swf/modulairKern` van
`GovChat-NL/GovChat-NL`, commit `7e2474d` (20 november 2026), en omgezet naar een
Helm-chart. De licentie is nog niet gekozen; het voorstel is EUPL-1.2 en het besluit ligt
bij de maintainers van GovChat-NL.
