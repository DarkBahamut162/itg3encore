# In The Groove 3 Encore
![In The Groove 3 Encore](https://user-images.githubusercontent.com/83576877/176179247-61a15786-5992-4a2e-ba08-4eec7ed4613f.png)

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
I could have actually forked it but I didn't. My reasoning was that it wasn't going to be ITG3 anymore but it was being turned into ITG3Encore (something else while starting off using the same code).

What has been fixed so far:

* All **cmd()** transformed to **function(self)**
* Removed **D-Pad** Modifier since it breaks other Modifiers (like the new SpeedMod)
* Better and sorted **ScreenPlayerOptions**
* Added **MOD** & **BPM range** within **Name Badges** inside **ScreenPlayerOptions**
* Better **StatsDisplay/ShowStats** going from a range of 1-6 instead of just 3
* Actually fixed **Course Mode** (Battle, Marathon & Survival Mode)
  * Fixed/Better **Song List**
  * Displays **_panes** & **StepArtists** and correctly calculate their difficulty color
  * Fixed **LifeMeterBar/LifeMeterTime** *(except for Marathon Mode?)*
  * Re-Added stuff in **Course Mode**
    * **Song Time** & **HAS MODS**
      * Introduced **HAS LUA**
    * **RemainingTime** & **DeltaSeconds**
    * Forced implementation of **NoteSkin** via ApplyGameCommand
    * Forced implementation of **SpeedMods** if GamePlay is in Oni mode
    * Added **LifeBar** for Oni Courses that have lives
* Fixed **Rounds/Songs Display**
* Added back **Rotation** to **Judgments** & **Holds** during Gameplay
* Shows **ProductFamily**

The following has been re-introduced from OpenITG's ITG3Encore Theme:
* **BPM Display** *(Disabled in Battle Mode)*
* **Full Combo Splash Animation**
* **CustomMods** and **ScreenFilter**
* **Encore "Folders"**
* **OptionsList** *(Mostly functional)*


Stuff still needs to get fixed, even if the fixed and re-introduced list/code are quite long/big.
Also: This Theme has been optimized for **Project OutFox**! It might work incorrectly when used in StepMania 5!