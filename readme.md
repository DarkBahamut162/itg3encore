# In The Groove 3 Encore X Final Theme
![In The Groove 3 Encore X Final Theme](https://user-images.githubusercontent.com/83576877/215728137-8d637c6c-af76-46e2-bca3-2b58b0f2f013.png)

The following project has been in-officially taken over by me *(DarkBahamut162)*.

It's sources have being displayed down below.

## Warning:
This Theme has been optimized for **Project OutFox** and has some additional *(but optional)* features that only work there!<br>
**ITGmania** might be your second pick since **.mp4** background videos work in there without much issue.<br>
It might work incorrectly when used anywhere else!<br>
If anything broke or isn't working correctly, please report it **ASAP** so I can take a look at it and fix it.

You also might need to switch your **VideoRenderer** to **OpenGL** as **GLAD** breaks the graphics after playing just one round *(depending if they have been fixed yet everywhere)*.

## Information:
Most additional features have been moved to an additional **Theme Options** menu. They are as follows:

- **EncoreThemeMode:**
Switch between **Encore Normal** and **Encore Final** mode
- **ShowBPMDisplayType:**
Change the BPMDisplay type from **DisplayBPM** (default), **ActualBPM** (total range) and **CalculatedBPM** (playable range)
- **ShowCalcDiff:**
Show the calculated Difficulty of the currently selected stepchart *(currently banner only)*. Shows **DB9** *(average steps per second)*, **Y&A** *(RadarValue Calculation)* and **SPS (OutFox Only)** *(median steps per second per steps)*
- **ShowClock:**
Shows **current time and date** on most/all menus
- **ShowHasLua:**
Shows if song **has anything lua** related (no matter if BG, FG or both)
- **ShowOffset:**
Shows **earlies** and **lates** of any timing window **during evaluation** excluding misses but including perfects *(0ms)*
- **ShowRounds:**
Shows either **amount of rounds** or **length specification** during song selection
- **ShowStepCounter (OutFox Only):**
Shows **total step quantification amounts** (might be useful especially for BEMU/POMU, including scratches and foots)

---

# Sources:

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

[In The Groove 3 Encore Final (OpenITG)](https://www.youtube.com/watch?v=n1HvKWturOI)
---

**Description:** ?

**Date:** April 8th 2018

---

# Changes:

I could have actually forked it but I didn't. My reasoning was that it wasn't going to be ITG3 anymore but it was being turned into ITG3Encore (something else while starting off using the same code).

What has been done so far:

* All **cmd()** transformed to **function(self)**
* Removed **D-Pad** Modifier since it breaks other Modifiers (like the new SpeedMod)
* Better and sorted **ScreenPlayerOptions**
  * Including various other mods added from SetpMania5/OutFox
* Added **MOD** & **BPM range** within **Name Badges** inside **ScreenPlayerOptions**
  * TODO: Add **ShowBPMDisplayType** changes onto it
* Added **TimingData** and **"GrooveRadar"** Display to **_panes** in **ScreenSelectMusic**
* Added **StepCounter** to **_panes** in **ScreenSelectMusic** if enables
* Added **Player Avatar** to **_panes** in **ScreenSelectMusic** *(Project OutFox AND WideScreen only)*
* Added **CDTitle** next to **ScreenSelectMusic** banner frame *(WideScreen only)*
* Added and combined both **HasLua** and **Rounds/Length specification** between **Artist** and **BPM** line
* Better **StatsDisplay** going from a range of 1-6 instead of just 3
  * Added option for a fully functional **IIDX pacemaker** with selectable target meter
    * For 2 Player: <u>both players need to choose IIDX</u>
  * Added **NoteGraph** during GamePlay *(red: 0-20 | black: 20-100)*
* Actually fixed **Course Mode** (Battle, Marathon & Survival Mode)
  * Fixed/Better **Song List**
  * Displays **_panes** & **StepArtists** and correctly calculate their difficulty color
  * Fixed **LifeMeterBar/LifeMeterTime** *(except for Marathon Mode?)*
  * Added **LifeMeterBattery** for Courses with Lives
    * Looks and functions similar to **Pump It Up Pro 2**
  * Re-Added stuff in **Course Mode**
    * **Song Time** & **HAS MODS**
    * **RemainingTime** & **DeltaSeconds**
    * Forced implementation of **NoteSkin** via ApplyGameCommand
    * Forced implementation of **SpeedMods** if GamePlay is in Oni mode
    * Added **LifeBar** for Oni Courses that have lives
* Fixed **Rounds/Songs Display**
* Added back **Rotation** to **Judgments** & **Holds** during Gameplay
* Shows **ProductFamily**
* Added most **Final Encore Theme** stuff while adding/adjusting a few other things.
* Re-added **marvelous/perfect/great color bar** on top of the **LifeGraph** in **ScreenEvaluation**
* Added ability to switch between **Normal Score**, **Percentage** and **EX Score** via **Player Options**
* Fixed **Online Mode** *(I think?)*
* Added ability to switch between
  * **Game Mode Styles**
  * **Rave and Battle Mode**

The following has been re-introduced from **OpenITG's ITG3Encore Theme**:
* **BPM Display** during GamePlay *(Disabled in Battle Mode & shows both players BPM if they are different from one another)*
* **Full Combo Splash Animation**
* **CustomMods** and **ScreenFilter**
* **Encore "Folders"**
* **OptionsList** *(Mostly functional)*
* **Fitness/Workout Mode** *(1 Player only)*
* **USB Profile Stats**

Stuff might still need to get fixed, even if the fixed and re-introduced list/code are quite long/big.