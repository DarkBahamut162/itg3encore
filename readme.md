# In The Groove 3 Encore

The following project has been in-officially taken over by me (DarkBahamut162).

It's sources have being displayed down below.

---

[In The Groove 3 (OpenITG)](https://github.com/openitg/itg3theme)
---

**Description:** Theme by Lightning designed as a tribute to the best rhythm game Konami killed.

**Date:** Mar 27th 2011 - Jun 18th 2018

---

[In The Groove 3 (StepMania 5)](https://github.com/JoseVarelaP/itg3-sm5-revival)
---

**Description:** A revival of the ITG3 theme for StepMania 5 

**Date:** Mar 27th 2011 - Jan 20th 2021

---

[In The Groove 3 Encore (OpenITG)](https://www.indiedb.com/games/in-the-groove-3/downloads/in-the-groove-3-r35)
---

**Description:** In The Groove is a dance and rhythm video game, it enters the simulation category inspired by Dance Dance Revolution. Add new forms of games, skins, options, etc.

**Date:**  Jan 7th 2018

---
I could have actually forked it from the SM5's github but I didn't. My reasoning was that it wasn't ITG3 anymore but it was being turned into ITG3Encore (something else while using the same code).

What has been fixed so far:

* All **cmd()** transformed to **function(self)**
* Removed **D-Pad** Modifier since it breaks other Modifiers (like SM5's new SpeedMod)
* Better and sorted **ScreenPlayerOptions**
* Actually fixed **Course Mode** (Battle, Marathon & Survival Mode)
  * Better **Song List**
  * Display **_panes** & **StepArtists** and correctly calculate their difficulty color
  * Fixed **LifeMeterBar/LifeMeterTime** *(except for Marathon Mode?)*
  * Fixed **Rounds/Songs Display**
* Fixed **PeakComboAward** & **StageAward**

The following has been re-introduced from OpenITG's ITG3Encore Theme:
* Added back rotation to **Judgments** & **Holds** during GamePlay
* **BPM Display** *(Disabled in Battle Mode)*
* **Full Combo Splash Animation**
* **CustomMods** and **ScreenFilter**
* **Encore Folders**
* **OptionsList** *(Not yet fully functional)*

* Re-Added stuff in **Course Mode**
  * **Song Time** & **HAS MODS**
    * Introduced **HAS LUA**
  * **RemainingTime** & **DeltaSeconds**
  * Forced implementation of **NoteSkin** via ApplyGameCommand

Stuff still needs to get fixed, even if the fixed and re-introduced list are quite long.