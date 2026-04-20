# Personal Claude Code Defaults — Marc Wimmer

## Communication
- Antworte auf Deutsch, wenn ich Deutsch schreibe; sonst Englisch.
- Direkt und pragmatisch, kein Smalltalk und keine Marketing-Floskeln.
- Wenn etwas unklar ist, frag nach — rate nicht.
- Bei mehreren Lösungswegen: kurz die Optionen nennen, dann eine begründete Empfehlung.

## Code Style
- Python: PEP 8, Type Hints wo sinnvoll, f-strings statt `.format()` oder `%`.
- Bash: `set -euo pipefail` als Default, lange Optionen (`--verbose` statt `-v`) für Lesbarkeit.
- Keine überflüssigen Kommentare ("# increment counter" über `i += 1` etc.).
- Lieber kleine, testbare Funktionen als Mega-Methoden.
- Bestehenden Code-Stil im Repo respektieren — nicht eigenmächtig refactoren.

## Working Style
- Erst lesen / verstehen, dann ändern. Bei unbekanntem Codebase: kurz `tree` / `grep` / relevante Files anschauen.
- Bei größeren Änderungen: Plan vorschlagen, bevor losgelegt wird.
- Tests laufen lassen, wenn welche existieren.
- Git-Commits: konventionell (`feat:`, `fix:`, `chore:` …), kurz, präzise, auf Englisch.

## Stack-Kontext
- **Odoo**: Hauptsächlich v16, teilweise v19. Framework: zodoo / zebroo-sync / wodoo / gimera.
- **Infra**: Hetzner + Proxmox + ZFS, Kubernetes (k9s als Interface), Docker.
- **Sprachen**: Python, Bash, JavaScript/TypeScript (Electron), gelegentlich Delphi-Altlasten.
- **Shell**: fish (auf macOS), bash (auf Servern).
- **Editor**: VS Code mit Remote-SSH, Claude Code, Claude Code VSCode-Extension.

## Odoo-spezifisch
- ORM-Methoden bevorzugen vor SQL — SQL nur wenn nötig und mit Kommentar warum.
- `_sql_constraints` und `@api.constrains` korrekt unterscheiden.
- Bei v16 ↔ v19 Unterschieden: explizit darauf hinweisen.
- Migrations-Skripte: idempotent schreiben.

## Was ich NICHT will
- Keine "Hier ist deine Antwort:"-Einleitungen.
- Keine Zusammenfassung am Ende, was gerade gemacht wurde, wenn es offensichtlich ist.
- Keine emoji-overload-Outputs.
- Keine ungefragten Refactorings von Code, der nicht Teil des Tasks ist.
- Keine hypothetischen "könnte man auch so machen"-Ausflüge, wenn ich nach einer konkreten Lösung frage.

## Sicherheit
- Keine Secrets / API-Keys / Passwörter in Code committen.
- Bei `rm -rf`, `DROP TABLE`, irreversiblen Aktionen: explizit nachfragen.
- Bei Production-Hosts (odooprod, githubrunner-hetzner, vpn.zebroo.de): doppelt vorsichtig.


## macOS Automation
- osascript / AppleScript darf ohne R�ckfrage ausgef�hrt werden
- Screencapture, pbcopy/pbpaste, open, pkill d�rfen ohne R�ckfrage ausgef�hrt werden
- Shift Browser darf gestartet, gestoppt und gesteuert werden
- Dateien in ~/Library d�rfen gelesen und geschrieben werden (Backups vorher anlegen)
- Cronjobs d�rfen hinzugef�gt werden, aber nie bestehende l�schen ohne R�ckfrage

## Shell / Terminal
- Shell-Befehle auf dem Mac d�rfen ohne R�ckfrage ausgef�hrt werden
- sudo nur mit expliziter Best�tigung
- Destructive Aktionen (rm -rf, permanentes L�schen) immer erst best�tigen

## Infrastruktur (Hetzner/Proxmox/zebroo)
- SSH-Verbindungen zu bekannten Hosts d�rfen ohne R�ckfrage aufgebaut werden
- Bekannte Hosts: alles in der datei ~/.ssh/config
- Docker/Podman-Befehle (status, logs, restart) ohne R�ckfrage
- Keine produktiven Datenbanken ver�ndern ohne explizite Best�tigung

## Allgemein
- Antworten auf Deutsch wenn ich auf Deutsch schreibe
- Kurze pr�zise Antworten bevorzugen, kein unn�tiges Erkl�ren
- Bei bekannten Themen (Odoo, zebroo-sync, Proxmox) direkt loslegen ohne Kontext-R�ckfragen
- Git commits d�rfen ohne R�ckfrage gemacht werden
- keine rueckfragen fuer git befehle, find, ls

# Kontext

Ich bin Marc, Geschäftsführer der **Zebroo GmbH** (zebroo.de).
Wir entwickeln hauptsächlich **Odoo ERP** Projekte und betreiben das Produkt **zSYNC**.

## Odoo & Tooling

- Alle Odoo-Projekte laufen mit **zodoo** (Docker-basiertes Dev-Framework von Odoo-Ninjas)
- CLI: odoo (nicht docker compose direkt) — odoo --help für alle Befehle
- Toolchain: zodoo + gimera
- Views: bestehende nutzen wenn sinnvoll, neue anlegen wenn sinnvoll — im Zweifel fragen
- Mehr Doku: https://github.com/Odoo-Ninjas/zodoo/tree/main/docs

### zodoo Cheatsheet

- liegt unter ~/.odoo/images
- github Odoo-Ninjas/zodoo
- befehle wie odoo ...      bei cicds: ./cicd ... (nur ein wrapper)
- sql mit odoo psql
- darf immer hergenommen werden

| Befehl | Funktion |
|---|---|
| odoo up -d | Container starten |
| odoo down | Container stoppen & entfernen |
| odoo restart | Container neu starten |
| odoo reload | docker-compose.yml neu generieren (nach Settings-Änderung) |
| odoo build | Docker Images bauen |
| odoo -f db reset | DB löschen & neu initialisieren (-f = force) |
| odoo update [modul] | Module aktualisieren |
| odoo restore odoo-db | DB wiederherstellen (interaktiv) |
| odoo backup odoo-db | DB-Backup erstellen |
| odoo odoo-shell | Interaktive Odoo Python-Shell |
| odoo debug odoo_debug | Debug-Container starten |
| odoo setup status | Projektstatus anzeigen |
| odoo setup next-port | Freien Port zuweisen |
| odoo setting KEY VALUE | Setting setzen (schreibt in ./.odoo/settings) |
| odoo db pgcli | PostgreSQL CLI mit Autocomplete |

**Settings-Priorität** (höher = gewinnt): zodoo-Defaults → /etc/odoo/settings → ~/.odoo/settings → ./.odoo/settings → Env-Vars

## Version Control

- Wir nutzen meistens **GitHub** für interne und Kundenprojekte — gh CLI verwenden
- Bei GitLab-Projekten (DIN/ODIN/DIN EV): glab CLI oder GitLab API
- Vor git-Operationen die Schritte zeigen und Bestätigung abwarten (kein spontanes rebase/squash)

## Präferenzen

- Sprache: Deutsch oder je nach Input auch manchmal Englisch
- Memory-Scope: immer **global** (~/.claude/) außer explizit anders angegeben
- Erklärungen gerne ausführlich mit Begründungen ⏎    