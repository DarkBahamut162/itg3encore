# In The Groove 3 Encore X Final Theme
![In The Groove 3 Encore X Final Theme](https://user-images.githubusercontent.com/83576877/215728137-8d637c6c-af76-46e2-bca3-2b58b0f2f013.png)

The following project has been in-officially taken over by me *(DarkBahamut162)*.

It's sources have being displayed down below.

## Warning:
This Theme has been optimized for **Project OutFox** but also works on **ITGmania** and **StepMania 5**!<br>
**ITGmania** might be your second pick since **.mp4** background videos work without much issue on it.<br>
It might work incorrectly when used anywhere else!<br>
Since this theme is being updated periodically: If anything broke or isn't working correctly, please report it **ASAP** so I can take a look and fix it.

You also might need to switch your **VideoRenderer** to **OpenGL** as **GLAD** breaks the graphics after playing just one round *(depending if they have been fixed yet everywhere)*.

## Information:
Most additional features have been moved to an additional **Theme Options** menu. They are as follows:

### [Global]
- **EncoreThemeMode:**
Switch between **Encore Normal *(Light Mode)*** and **Encore Final *(Dark Mode)*** mode.
- **ShowClock:**
Shows **current time and date** on most/all menus
- **SLFavorites:**
Activate ability to favorite songs like in SL
  - Hold **SELECT** and press **UP** to un/favorite *(in StepMania/ITGmania)*
  - Hold **SELECT** and press **DOWN** to un/favorite *(in OutFox because it uses the upper config for OF Favorites)*
- **UseStepCache:**
Activate StepCache to use the chart's data for more accurate values or enable other features requiring it
### [ScreenSelectMusic]
- **ShowBPMDisplayType:**
Change the BPMDisplay type from **DisplayBPM** (default), **ActualBPM** (total range) and **CalculatedBPM** (playable range | more accurate when using StepCache)
- **ShowCalcDiff:**
Show the calculated Difficulty of the currently selected stepchart *(currently banner only)*. Shows **DB9** *(average steps per second)*, **Y&A** *(RadarValue Calculation)* and **SPS (StepCache Only)** *(median steps per second per steps)*
  - **DanceDifficultyType (Dance Mode Only):**
Switch between **OLD & X-SCALE** difficulty ranges
- **ShowHasLua:**
Shows if song **has anything lua** related (no matter if BG, FG or both)
- **ShowRounds:**
Shows either **amount of rounds** or **length specification** during song selection
- **ShowStepCounter (StepCache Only):**
Shows **total step quantification amounts** (might be useful especially for BEMU/POMU, including scratches and foots)
### [ScreenGameplay]
- **AnimatePlayerScore:**
Have the Player Score animate instead of instantly updating
- **AnimateSongTitle:**
Have the Song Title scroll during GamePlay (not possible on d3d)
- **ShowGameplaySpeed:**
Ability to show current Speed and Mod during GamePlay. Also enables modifying said speed mods during GamePlay
  - Hold **SELECT** and press **LEFT**/**RIGHT** or press either EffectButtons on their own
### [ScreenEvaluation]
- **ShowOffset:**
Shows **earlies** and **lates** of any timing window **during evaluation** excluding misses but including perfects *(0ms)*
### [ScreenSummary]
- **ShowSummary:**
Shows **songs played and their stats** after going back to title screen.
  - Shows more if **ShowOffset** has been enabled
- **ShowSummarySummary:**
Shows the **session's overall performance**
  - **At least two rounds** need to be played for this to show

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

### What has been done so far:

**Overall:**
* All **cmd()** transformed to **function(self)**
* All **LoadActor()** transformed to **Def.\***
* Added most **Final Encore Theme** stuff while adding/adjusting a few other things.
* Fixed **Online Mode** *(I think?)*
* Actually fixed **Course Mode** (Battle, Marathon & Survival Mode)
  * Fixed/Better **Song List**
  * Displays **_panes** & **StepArtists** and correctly calculate their difficulty color
  * Fixed **LifeMeterBar/LifeMeterTime** *(except for Marathon Mode?)*
  * Added **LifeMeterBattery** for Courses with Lives
    * Looks and functions similar to **Pump It Up Pro 2**
  * Re-Added stuff in **Course Mode**
    * **SongTime** & **HasMods**
    * **RemainingTime** & **DeltaSeconds**
    * Forced implementation of **NoteSkin** via ApplyGameCommand
    * Forced implementation of **SpeedMods** if GamePlay is in Oni mode

**ScreenTitleMenu:**
* Shows **ProductFamily** & **ProductVersion**
* Shows **StepCacheVersion** *(when StepCache enabled)*
* Shows **Current Game Mode** and **Current Style**
* Shows total amount of playable **Single/Double Songs/Courses** in current **GameMode/Style** *(if able)*

**ScreenSelectStyle:**
* Shows **Current Style**
* Shows **Current Battle Mode**
* Added ability to switch between:
  * **Game Mode Styles** *(hold select and press left/right)*
  * **Rave and Battle Mode** *(hold select and press up/down)*

**ScreenSelectMusic:**
* Shows **TimingData** and **"GrooveRadar"**
* Shows **StepCounter** *(when StepCounter & StepCache enabled)*
* Shows **Player Avatar** *(Project OutFox AND WideScreen only)*
* Shows **CDTitle** next to the banner frame *(VerticalScreen & WideScreen only)*
* Shows various indications between **Artist** and **BPM** line:
  * **HasLua**
  * **HasLyric**
  * **HasNoKeysounds** & **ContainsNullMeasure** *(BE-MU / PO-MU Mode only)*
  * **HasVideo**
  * **Rounds/Length specification**
* Updates **BPMs** and **TIMEs** according to **Current Music Rate**

**ScreenPlayerOptions:**
* Removed **D-Pad** Modifier since it breaks other Modifiers (like the new SpeedMod)
* Better and sorted **List of Options**
  * Including various other mods added for StepMania/ITGmania/OutFox
* Shows **Player's MOD** & **BPM range** within **Name Badges**
* Added ability to switch between **Normal Score**, **Percentage** and **EX Score** via **Player Options**
  * Added ability to choose between **additive** or **subtractive** style
* Updates **BPMs** and **TIMEs** according to **Current Music Rate**

**ScreenGameplay:**
* Better **StatsDisplay** going from a range of 1-6 instead of just 3
  * Added option for a fully functional **IIDX pacemaker** with selectable target meter
    * For 2 Player: <u>both players need to choose IIDX</u>
  * Added **NoteGraph** *(red: 0-20 | black: 20-100)*
* Fixed **Rounds/Songs Display**
* Added back **Rotation** to **Judgments** & **Holds**
* Ability to change SpeedMod by 25/0.25
  * Disabled on OutFox-specific ones ***(Amod/CAmon/AVmon)***
* Shows **Current Speed & Mod**

**ScreenEvaluation:**
* Re-added **marvelous/perfect/great color bar** on top of the **LifeGraph**
---

The following has been re-introduced from **OpenITG's ITG3Encore Theme**:
* **BPM Display** during GamePlay *(Disabled in Battle Mode & shows both players BPM if they are different from one another)*
* **Full Combo Splash Animation**
* **CustomMods** and **ScreenFilter**
* **Encore "Folders"**
* **OptionsList** *(Mostly functional)*
* **Fitness/Workout Mode** *(1 Player only)*
* **USB Profile Stats**

Stuff might still need to get fixed, even if the fixed and re-introduced list/code are quite long/big.