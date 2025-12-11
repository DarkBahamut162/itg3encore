# In The Groove 3 Encore X Final Theme
![In The Groove 3 Encore X Final Theme](https://user-images.githubusercontent.com/83576877/215728137-8d637c6c-af76-46e2-bca3-2b58b0f2f013.png)

The following project has been in-officially taken over by me *(DarkBahamut162)*.

It's sources have being displayed down below.

## Warning:
This Theme has been optimized for **Project OutFox** but also works on **ITGmania**, **StepMania 5** and **Etterna**!<br>
**ITGmania** might be your second pick since **.mp4** background videos work without much issue on it.<br>
Videos might not work correctly when used anywhere else!<br>
This is an Engine Issue I cannot fix! *(unless fixed by newer versions)*<br>
Since this theme is being updated periodically: If anything broke or isn't working correctly, please report it **ASAP** so I can take a look and fix it.

When using certain versions of OutFox *(from 0.4.17 to 0.4.18.1)*, you might need to switch your **VideoRenderer** to **OpenGL** as **GLAD** breaks the graphics after playing just one round *(depending if they have been fixed yet everywhere)*.
When the **VideoRenderer** is set to **d3d**, certain animations or options might not be possible.
Please use 0.4.19 (LTS) or 0.5.042 (V) otherwise! *(0.5.043 seems to be more ChonkFox than OutFox with the longer file loading times)*

## Information:
Most additional features have been moved to an additional **Theme Options** menu. They are as follows:

### [Global]
- **EncoreThemeMode:**
Switch between **Encore Normal *(Light Mode)*** and **Encore Final *(Dark Mode)*** mode
- **ExperimentalProfileLevel:**
Enable the Experimental Profile Leveling System
  - **Differentiates** between **GameModes** and **Styles**
  - **EXP** gained through **Cleared Songs**
    - **EXP** is calculated through the Song's **SPS-Level** and the **Player's Percentage Score**
      - **MusicRate** and **SongLength**  are part of the equation.
- **KeyboardEnabled:**
  - **Extra features** requiring special keys like **CTRL** or **SHIFT** might be moved to **SELECT** if disabled
    - Some other **controls** might have **changed** if enabled/disabled!
- **MouseEnabled:**
Enables MouseControls wherever possible *(CustomSelections & MusicWheel Only)*
- **ShowClock:**
Shows **current time and date** on most/all menus
- **SLFavorites:**
Activate ability to favorite songs like in SL
  - Hold **SELECT** and press **UP** to un/favorite *(in StepMania/ITGmania/Etterna)*
  - Hold **SELECT** and press **DOWN** to un/favorite *(in OutFox because it uses the upper config for OF Favorites)*
- **TrueRounds:**
**Rounds/Lengths** will be adjusted if the **StepChart's Length** is shorter than the **Song's Length**
- **UseStepCache:**
Activate StepCache to use the chart's data for more accurate values or enable other features requiring it *(cached values are listed further down)*
### [ScreenTitleMenu]
- **Allow Battle/Marathon/Survival/Fitness/Jukebox/Edit/Share/Records:**
Ability to **enable/disable** certain **options** within **ScreenTitleMenu**
### [ScreenTitleJoin]
- **GetAutoPlayMode:**
Ability to **AutoSelect** the **PlayMode** when in **ScreenTitleJoin**
### [ScreenSelectStyle]
- **AutoStyleDance/Groove/Solo/Pump/Smx/BeMu/Beat/PoMu/Popn/Techno:**
Ability to **AutoSelect** the **Style** to skip **ScreenSelectStyle/ScreenSelectNumPlayers**
### [ScreenSelectNumPlayers]
- **AutoBattle:**
Ability to **AutoSelect** the **BattleMode** to skip **ScreenSelectNumPlayers**
### [ScreenSelectMusic]
- **MusicWheelStyle:**
Ability to change **Wheel Behavior** between **ITG** and **IIDX**
- **ShowBPMDisplayType:**
Ability to chance the BPMDisplay type
  - **DisplayBPM** displays the **set BPM** of the **Song** *(including ???s)*
  - **ActualBPM** displays the **minimum & maximum BPMs** of the **Song** *(excluding ???s)*
  - **CalculatedBPM** displays the **true minimum & maximum BPMs** of the **Song** outside of Speed Ups
    - More accurate when using **StepCache**!
- **ShowCalcDiff:**
Show the calculated Difficulty of the currently selected stepchart.
  - The **highest value** will be displayed alongside the original difficulty *(OG)*
    - **DB9** *(average steps per second)*
    - **Y&A** *(RadarValue Calculation)*
    - **SPS (StepCache Only)** *(median steps per second per steps)*
- **ShowCalcDiffDecimals**
Change the amount of decimals for the calculated Difficulty- **DanceDifficultyType *(GameMode Dance Only)*:**
Switch between **Old DDR/ITG & DDR X-SCALE** difficulty ranges
- **ShowGraph:**
Shows the **graph** of the **currently selected stepchart** *(VerticalScreen & WideScreen only)*
- **ShowHasLua:**
Shows if song **has anything lua** related (no matter if BG, FG or both)
- **ShowMODDisplay:**
Switches back and forth between the stepchart's BPMs and the player's current mod speed 
- **ShowOrigin**
Switches back and forth between the song's Artist and the song's origin *(only if Origin Value has been set)*
- **ShowRounds:**
Shows either **amount of rounds** or **length specification** during song selection
  - Will be adjusted if **TrueRounds** is enabled
- **ShowStepCounter (StepCache Only):**
Shows **total step quantification amounts** (might be useful especially for BEMU/POMU, including scratches and foots)
- **ShowTechCounter (ITGmania Only)**
Shows stepchart's Techniques
  - If *both Counters* have been enabled, **both switch between one another** like *BPMDisplay* and *MODDisplay*
- **ShowTime**
Shows **Session Time** and **Time Played** per Player
### [ScreenGameplay]
- **AnimatePlayerScore:**
Have the Player Score animate instead of instantly updating
- **AnimateSongTitle:**
Have the Song Title scroll during GamePlay *(not possible on d3d)*
- **ShowSeconds**
Ability to show current Seconds during GamePlay
  - More accurate when StepCache is enabled
- **ShowSpeedMod:**
Ability to show current Speed and Mod during GamePlay. Also enables modifying said speed mods during GamePlay
  - Hold **SELECT** and press **LEFT**/**RIGHT** or press either EffectButtons on their own
### [ScreenEvaluation]
- **ShowOffset:**
Shows **earlies** and **lates** of any timing window **during evaluation** excluding misses but including perfects *(0ms)*
  - Ability to **switch** between **multiple Graph Views**
    - Life/Flare Graph
    - Judgment Dotted *(Added)*
    - Judgment Lined *(Added)*
### [ScreenSummary]
- **ShowSummary:**
Shows **songs played and their stats** after going back to title screen
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
* Fixed **Legacy Online Mode** *(I think?)*
* Actually fixed **Battle/Course Mode** (Battle/Rave, Marathon & Survival Mode)
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
  - May also show **AutoPlayMode** and **AutoStyle** and **AutoBattle** depending on Screen & Settings
    - **AutoStyle** overwrites **Current Style**
* Shows total amount of playable **Single/Double Songs/Courses** in current **GameMode/Style** *(if able)*

**ScreenSelectStyle:**
* Shows **Current Style**
* Shows **Current Battle Mode**
* Added ability to switch between:
  * **Game Mode Styles** *(hold select and press left/right)*
  * **Rave and Battle Mode** *(hold select and press up/down)*

**ScreenSelectMusic:**
* Shows **TimingData** and **"GrooveRadar"**
* Shows **TOTAL** and **STEPS** NoteCounter of currently selected Song's Difficulty
* Shows **StepCounter** *(when StepCounter & StepCache enabled)*
* Shows **TechCounter** *(when TechCounter enabled | ITGmania only)*
* Shows **Player Avatar** *(Project OutFox AND WideScreen only)*
* Shows **Player's Level & EXP** over their Username *(when ExperimentalProfileLevel enabled)*
* Shows **Session Time & Player's Time Played** *(when ShowTime enabled)*
  - **Session Time** starts upon first entry of **ScreenSelectMusic**
* Shows **HighscoreList** by holding CTRL
  - **Left CTRL** for **Player 1** / **Right CTRL** for **Player 2**
* Shows **Player's MODDisplay** *(when ShowMODDisplay enabled)*
* Shows **Song's rigin** *(when ShowOrigin enabled & if Song has Origin)*
* Shows **Player's NoteGraph** *(when ShowGraph enabled)*
* Shows **CDTitle** next to the banner frame *(VerticalScreen & WideScreen only)*
* Shows various indications between **Artist** and **BPM** line:
  * **Autogen**
  * **HasLua**
  * **HasLyric**
  * **HasNoKeysounds** & **ContainsNullMeasure** *(BE-MU / PO-MU Mode only)*
  * **HasVideo**
  * **Rounds/Length specification**
* Updates **BPMs** and **TIMEs** according to **Current Music Rate**
* Ability to change current **Speed Mod** and **Speed Type** (when enabled)

**ScreenPlayerOptions:**
* Removed **D-Pad** Modifier since it breaks other Modifiers (like the new SpeedMod)
* Better and sorted **List of Options**
  * Including various other mods added for StepMania/ITGmania/OutFox
* Shows **Player's MOD** & **BPM range** within **Name Badges**
* Added ability to switch between **Normal Score**, **Percentage** and **EX Score** via **Player Options**
  * Added ability to choose between **additive** or **subtractive** style
* Updates **BPMs** and **TIMEs** according to **Current Music Rate**
* Added various PlayerOptions:
  - **LifeType:** **LifeLine** *(Battery)* & **Survival** *(Timer)*
  - **FlareLevel:** **Flare 1-10** & **Flare Float**
    - Ability to change between **Old** & **New** score requirement
    - Ability to have it **Accurate** *(uses SN2 scoring)*
  - **Fade:** Enable both **Fade In** & **F.I.Dynamic** to enable simulated **Dynamic Sudden**
    - Same goes for **Fade Out** & **F.O.Dynamic** for simulated **Dynamic Hidden**
  - **MovePlayerfieldStats:** Bring both **Combo & Judgment** either **nearer** towards or **farther** away from the **Receptors**
  - **ScoreTypes:** **Score**, **Percent**, **EX**, **SN2**, **IIDX**, **WIFE3***
    - Have the selected ScoreTypes **Additive** or **Subtractive**
    - Enable an additional FA+ Scoring to the selected ScoreType
    - WIFE3 *(from Etterna)* can't be selected if the GameMode is on **CountNotesSeperately** because of a judgment bug in the engine.
  - **ErrorBar:** Selectable **Range of Judgment** to be displayed *(lowest first)*
  - **PlayerStats:** Selectable **Range of Judgment** to be displayed *(highest first)*
    - **IIDX** switches **StatsMode** to a fully functional **IIDX pacemaker** and shows **Player**, **Highscore** *(if available)* and **Pacemaker**
    - Ability to switch between **FullSize** & **MiniSize**
      - **Mini (Bottom/Top)** decides where the data is being displayed *(NoteGraph is being show on th eopposite end)*
  - **PlayerNoteGraph:** Customizable **NoteGraph**
    - **Normal** *Steps per second*
    - **SPS** *Steps per second per Step*
    - **One** *Row of notes count as one*
    - **All** *Row counts all notes within*
    - **Fixed** *Display NoteGraph in a fixed rate: Red = 0-20 NPS | Black = 20-100 NPS*
    - **Adjusted** *Adjust NoteGraph to use the full height*
    - **ShowData** Shows **average & maximum NPS** next to **NoteGraph**
  - **Pacemaker:** Selectable **Grade** to reach during Gameplay
  - **PacemakerOnFail:** What the game does when **Player fails the Pacemaker**
  - **PlayerAssists:** Ability to show **SpeedChanges/Stops** during Gameplay
  - **SongFrame:** Ability to change the SongFrame
    - Bunnies *(Pink Fuzzy Bunnies)*
    - Disconnect *(Disconnected Hardkore)*
    - Energy *(Energizer)*
    - Hasse *(Hasse Mich)*
    - Love *(Love Eternal)*
    - Nightmare *(Dream to Nightmare)*
    - Normal *(Default)*
    - Pandy *(Pandemonium)*
    - Smiley *(Summer ~Speedy Mix~)*
    - Vertex *(Base from VerTex)*
    - Virtual *(Virtual Emotion)*

**ScreenGameplay:**
* Better **StatsDisplay** going from a range of 1-6 instead of just 3
  * Added option for a fully functional **IIDX pacemaker** with selectable target meter
    * For 2 Player: <u>both players need to choose IIDX</u>
  * Added **NoteGraph** *(red: 0-20 | black: 20-100)*
* Fixed **Rounds/Songs Display**
* Added back **Rotation** to **Judgments** & **Holds**
* Ability to change SpeedMod by 25/0.25
  * Disabled on OutFox-specific ones ***(Amod/CAmod/AVmod)***
* Shows **Current Speed & Mod**

**ScreenEvaluation:**
* Re-added **marvelous/perfect/great color bar** on top of the **LifeGraph**

**StepCache:** *(Caching additional info for each StepChart)*
  - Version *(StepCacheVersion during Caching)*
  - FirstRow *(For Preview)*
  - StepCounter *(Condensed StepCounter)*
  - StepsPerSecond *(Raw SPS)*
  - TrueFirstBeat *(Beat of First Real Note)*
  - TrueLastBeat *(Beat of Last Real Note)*
  - TrueBeats *(Real Duration of Stepchart in Beats)*
  - TrueMaxBPM *(Actual Highest BPM with Notes)*
  - TrueFirstSecond *(Second of First Real Note)*
  - TrueLastSecond *(Second of Last Real Note)*
  - TrueSeconds *(Real Duration of Stepchart in Seconds)*
  - chaosCount *(Etterna only)*
  - maxVoltage *(Etterna only)*
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