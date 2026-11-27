> # ⚠️ NOTE: temporary name
> This repository has the name `swf-modulair-app-time` because this is a pilot for a modular
> GovChat. Súdwest-Fryslân started the pilot with the approval of GovChat-NL. If the pilot
> is a success and all parties agree, the name can become `GovChat-NL-app-time`.

# swf-modulair-app-time

The trial app of the modular GovChat. It gives the assistant five tools for dates and
times. Thus the assistant knows the date of today and can calculate with dates.

The app is small on purpose. It is the example of an app: the full app is one file,
`app.yaml`.

The server is [`mcp-time`](https://github.com/TheoBrigitte/mcp-time), a small community
project. It is here to test the procedure. It is not a product decision.

This is one of four repositories that belong together:

| Repository | Function |
|---|---|
| [`swf-modulair-kern`](https://github.com/GovChat-NL/swf-modulair-kern) | The basic chat. |
| **`swf-modulair-app-time`** | The trial app, and the example of an app (this repository). |
| [`swf-modulair-manager`](https://github.com/GovChat-NL/swf-modulair-manager) | The `govchat` command, and the rules for an app. |
| [`swf-modulair-deploy-template`](https://github.com/GovChat-NL/swf-modulair-deploy-template) | The start point for the deploy repository of an organisation. |

## The files

| File | Function |
|---|---|
| `app.yaml` | Tells GovChat what the app is: the name, the version and the container image. |
| `README.md` | This document, with the use case and the short check. |

There is no Helm chart. The `govchat` command makes the Kubernetes files from `app.yaml`.

## Install the app

In the deploy repository of your organisation:

```sh
./govchat app add time --env acceptatie
```

Then commit, open a pull request, and let a second person merge. There are no settings
and no Secrets.

To remove the app:

```sh
./govchat app remove time --env acceptatie
```

## Use case

- **For whom:** each employee who asks a question about a date or a time limit.
- **What:** the assistant can get the current date and time and calculate with them. Example: "Which date is it in six weeks?"
- **Why an app:** a language model does not know the date of today, and it makes errors in date calculations.

Test question: "Hoe laat is het nu in Amsterdam, en welke datum is het over 45 dagen?"

Test data: none. The app uses only the clock of the pod.

## Short check

| Question | Answer |
|---|---|
| Does the app process personal data? | No. |
| Does data go to an external service or to a different language model? | No. The pod cannot connect to other systems. |
| Does the app keep data? | No. |
| Which Secrets are necessary? | None. |
| What does the language model see of the app? | The names and descriptions of five tools (approximately 2,200 tokens for each question), and their answers. |
| Who owns the server? | A small community project. The image is fixed with a digest. |

## Versions

| Part | Now |
|---|---|
| The app | `2.0.0` |
| The image | `docker.io/theo01/mcp-time:0.4.0`, fixed with a digest |

Version 1.0.0 had a Helm chart and was made for the first tool (the app manager).
Version 2.0.0 is for the `govchat` command. The server is the same.

## Proof

See the section "Tests" in the README of
[`swf-modulair-manager`](https://github.com/GovChat-NL/swf-modulair-manager).

## Origin

The content comes from `apps/mcp-time` of the branch `swf/modulairKern` of
`GovChat-NL/GovChat-NL`, commit `7e2474d` (20 November 2026). The licence is not chosen
yet. The proposal is EUPL-1.2. The maintainers of GovChat-NL make the decision.
