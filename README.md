# Agribot 2.0 — publiczne materiały źródłowe

**Pełny oczyszczony materiał z 45 aktywnych repozytoriów:** [wydanie źródłowe 2026-10-27](https://github.com/panpawelchmiel/agribot/releases/tag/source-publication-2026-10-27).

Paczka zawiera katalogi źródłowe, oczyszczone historie Git, manifest wersji i instrukcję odtworzenia. Jest kompletnym wybranym materiałem również wtedy, gdy limit tworzenia repozytoriów GitHub opóźnia publikację części osobnych repozytoriów. W takiej sytuacji klonowanie wszystkich submodułów bezpośrednio z GitHuba może być jeszcze niedostępne; skorzystaj z paczki wydania.

Wkład projektu udostępniono na **Apache-2.0**; cudze komponenty zachowują własne warunki — patrz [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). Dane dostępowe i wskazane pakiety dostawców nie są dołączone. Trzy repozytoria deprecated zachowano w oryginalnym archiwum poza tą publikacją. Szczegóły: [PUBLICATION.md](PUBLICATION.md).

---

## Source agribot

```
source agribot/configs/setup.bash
```

## Repository initialization

```
agribot_workspace_init.sh
```

## Build all repositories 

```
agribot_workspace_build.sh
```

## Start robot software in simulation

```
agribot_start.sh simulation
```

## Start robot software on agribot hardware

```
agribot_start.sh
```