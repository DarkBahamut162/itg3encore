function DanceStageSong()
	local song = GAMESTATE:GetCurrentSong()
	local title = ""
	if song then title = song:GetDisplayFullTitle() end
----------------------------------------------------------------------------- DDR 1st --------------------------------------------------------------------------------
	if title == "Butterfly" 															then return "(X2) BIG SCREEN"
	elseif title == "Have You Never Been Mellow" 									then return "(X2) BIG SCREEN"
	elseif title == "KUNG FU FIGHTING" 												then return "(X2) MOVIE LIGHT"
	elseif title == "LET'S GET DOWN" 												then return "(X2) MOVIE LIGHT"
	elseif title == "Little Bitch" 													then return "(X2) MOVIE LIGHT"
	elseif title == "MAKE IT BETTER" 												then return "(X) DANCING RAYS"
	elseif title == "My Fire (UKS Remix)" 											then return "(X2) MOVIE LIGHT"
	elseif title == "PARANOiA" 														then return "(X) CRYSTALDIUM"
	elseif title == "STRICTLY BUSINESS" 												then return "(X) DANCING RAYS"
	elseif title == "That's The Way (I Like It)" 									then return "(X2) MOVIE LIGHT"
	elseif title == "TRIP MACHINE" 													then return "(X) CRYSTALDIUM"
----------------------------------------------------------------------------- DDR 2ndMIX -----------------------------------------------------------------------------
	elseif title == "AM-3P" 															then return "(X2) CYBER"
	elseif title == "BAD GIRLS" 														then return "(X2) BIG SCREEN"
	elseif title == "Boom Boom Dollar (Red Monster Mix)" 							then return "(X2) MOVIE LIGHT"
	elseif title == "Boys" 															then return "(X2) BIG SCREEN"
	elseif title == "BRILLIANT 2U" 													then return "(X) CAPTURE ME"
	elseif title == "BRILLIANT 2U(Orchestra Groove)" 								then return "(X2) CYBER"
	elseif title == "DUB-I-DUB" 														then return "(X2) BIG SCREEN"
	elseif title == "EL RITMO TROPICAL" 												then return "(X2) BOOM LIGHT"
	elseif title == "GET UP'N MOVE" 													then return "(X2) MOVIE LIGHT"
	elseif title == "HERO" 															then return "(X2) CYBER"
	elseif title == "I Believe In Miracles (The Lisa Marie Experience Radio Edit)" 	then return "(X2) BIG SCREEN"
	elseif title == "IF YOU WERE HERE" 												then return "(X2) BIG SCREEN"	
	elseif title == "LOVE" 															then return "(X) DANCING RAYS"
	elseif title == "LOVE IS THE POWER" 												then return "(X) DANCING RAYS"
	elseif title == "MAKE A JAM!" 													then return "(X) DAWN STREETS"
	elseif title == "MAKE IT BETTER (So-REAL Mix)" 									then return "(X2) MOVIE LIGHT"
	elseif title == "PARANOiA KCET ～clean mix～" 									then return "(A) BOOM DARK"
	elseif title == "PARANOiA MAX～DIRTY MIX～" 										then return "(X) CAPTURE ME"
	elseif title == "PUT YOUR FAITH IN ME" 											then return "(X) BOOM BOOM BOOM"
	elseif title == "PUT YOUR FAITH IN ME (Jazzy Groove)" 							then return "(X2) MOVIE LIGHT"
	elseif title == "Smoke" 															then return "(X2) MOVIE LIGHT"
	elseif title == "SP-TRIP MACHINE～JUNGLE MIX～" 									then return "(X) CRYSTALDIUM"
	elseif title == "stomp to my beat" 												then return "(X2) MOVIE LIGHT"	
	elseif title == "TUBTHUMPING" 													then return "(X) DAWN STREETS"
----------------------------------------------------------------------------- DDR 2ndMIX CLUB Version 1 --------------------------------------------------------------
	elseif title == "e-motion" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "GENOM SCREAMS" 													then return "(X2) CYBER"
----------------------------------------------------------------------------- DDR 3rdMIX -----------------------------------------------------------------------------
	elseif title == "AFRONOVA" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "AFTER THE GAME OF LOVE" 										then return "(X) DANCING RAYS"
	elseif title == "BOOM BOOM DOLLAR (K.O.G. G3 MIX)" 								then return "(X) DANCING RAYS"
	elseif title == "BUMBLE BEE" 													then return "(X2) BOOM LIGHT"
	elseif title == "butterfly (UPSWING MIX)" 										then return "(X) DANCING RAYS"
	elseif title == "CAPTAIN JACK (GRANDALE REMIX)" 									then return "(X2) CYBER"
	elseif title == "CUTIE CHASER" 													then return "(X) LOVE SWEETS"
	elseif title == "DAM DARIRAM" 													then return "(X2) CYBER"
	elseif title == "DEAD END" 														then return "(A) BOOM DARK"
	elseif title == "DROP THE BOMB" 													then return "(X2) CYBER"
	elseif title == "DYNAMITE RAVE" 													then return "(X2) CYBER"
	elseif title == "GRADIUSIC CYBER ～AMD G5 MIX～" 									then return "(X2) CYBER"
	elseif title == "KEEP ON MOVIN'" 												then return "(X2) BOOM LIGHT"
	elseif title == "La Señorita" 													then return "(X2) BOOM LIGHT"
	elseif title == "La Señorita Virtual" 											then return "(X) CRYSTALDIUM"
	elseif title == "LOVE THIS FEELIN'" 												then return "(X2) CYBER"
	elseif title == "LUV TO ME (AMD MIX)" 											then return "(X) DANCING RAYS"
	elseif title == "PARANOiA Rebirth" 												then return "(X) CRYSTALDIUM"
	elseif title == "Silent Hill" 													then return "(X) DANCING RAYS"
	elseif title == "think ya better D" 												then return "(X) CAPTURE ME"
	elseif title == "TRIP MACHINE～luv mix～" 										then return "(X) CRYSTALDIUM"
	elseif title == "TURN ME ON (HEAVENLY MIX)" 										then return "(X2) CLUB"
----------------------------------------------------------------------------- DDR 4thMIX -----------------------------------------------------------------------------
	elseif title == "B4U" 															then return "(X2) CYBER"
	elseif title == "BABY BABY GIMME YOUR LOVE" 										then return "(X) DANCING RAYS"
	elseif title == "BURNIN' THE FLOOR" 												then return "(X2) CLUB"
	elseif title == "CAN'T STOP FALLIN' IN LOVE" 									then return "(X2) CYBER"
	elseif title == "CELEBRATE NITE" 												then return "(X) CAPTURE ME"
	elseif title == "Don't Stop!～AMD 2nd MIX～" 										then return "(X2) BOOM LIGHT"
	elseif title == "DROP OUT" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "era (nostalmix)" 												then return "(X) CAPTURE ME"
	elseif title == "HIGHER" 														then return "(X2) BOOM LIGHT"
	elseif title == "Holic" 															then return "(X2) CYBER"
	elseif title == "HYSTERIA" 														then return "(X) CAPTURE ME"
	elseif title == "LEADING CYBER" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "LOVE AGAIN TONIGHT～For Melissa MIX～" 							then return "(X) DANCING RAYS"
	elseif title == "MY SUMMER LOVE" 												then return "(X2) BOOM LIGHT"
	elseif title == "ORION.78(AMeuro-MIX)" 											then return "(X) CAPTURE ME"
	elseif title == "PARANOIA EVOLUTION" 											then return "(X) CRYSTALDIUM"
	elseif title == "SEXY PLANET" 													then return "(X2) CYBER"
	elseif title == "SUPER STAR" 													then return "(X) DAWN STREETS"
	elseif title == "TRIP MACHINE CLIMAX" 											then return "(X) CRYSTALDIUM"
	elseif title == "WILD RUSH" 														then return "(X) CRYSTALDIUM"
	elseif title == ".59" 															then return "(X) CRYSTALDIUM"
----------------------------------------------------------------------------- DDR 5thMIX -----------------------------------------------------------------------------
	elseif title == "サナ・モレッテ・ネ・エンテ" 												then return "(X) DANCING RAYS"				--SANA MOLLETE NE ENTE
	elseif title == "ABSOLUTE" 														then return "(X2) BOOM LIGHT"
	elseif title == "Abyss" 															then return "(X) CRYSTALDIUM"
	elseif title == "AFRONOVA PRIMEVAL" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "BROKEN MY HEART" 												then return "(X2) CYBER"
	elseif title == "CAN'T STOP FALLIN' IN LOVE ～SPEED MIX～" 						then return "(X) CRYSTALDIUM"
	elseif title == "DXY!" 															then return "(X2) CYBER"
	elseif title == "ECSTASY" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "Electro Tuned ( the SubS Mix )" 								then return "(X) CAPTURE ME"
	elseif title == "Healing Vision" 												then return "(X) CRYSTALDIUM"
	elseif title == "INSERTiON" 														then return "(X) CAPTURE ME"
	elseif title == "PARANOiA ETERNAL" 												then return "(X) CAPTURE ME"
	elseif title == "STILL IN MY HEART" 												then return "(X) BOOM BOOM BOOM"
----------------------------------------------------------------------------- DDRMAX ---------------------------------------------------------------------------------
	elseif title == "CANDY☆" 														then return "(X) LOVE SWEETS"
	elseif title == "exotic ethnic" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Healing Vision ～Angelic mix～" 									then return "(X) CRYSTALDIUM"
	elseif title == "Let the beat hit em!(CLASSIC R&B STYLE)" 						then return "(X) DANCING RAYS"
	elseif title == "MAX 300" 														then return "(X2) MOVIE DARK"
	elseif title == "ORION.78～civilization mix～" 									then return "(X) DANCING RAYS"
----------------------------------------------------------------------------- DDRMAX2 --------------------------------------------------------------------------------
	elseif title == "革命" 															then return "(A) BOOM DARK"				--KAKUMEI
	elseif title == "AFRONOVA(FROM NONSTOP MEGAMIX)"									then return "(X2) CLUB"
	elseif title == "AM-3P(AM EAST mix)" 											then return "(X) DANCING RAYS"
	elseif title == "B4U(B4 ZA BEAT MIX)" 											then return "(X2) CYBER"
	elseif title == "BRE∀K DOWN！" 													then return "(X2) BOOM LIGHT"
	elseif title == "BRILLIANT 2U(K.O.G G3 MIX)" 									then return "(X2) CYBER"
	elseif title == "BURNIN' THE FLOOR(BLUE FIRE mix)" 								then return "(X) CRYSTALDIUM"
	elseif title == "BURNING HEAT！（3 Option MIX）" 									then return "(X2) CYBER"
	elseif title == "CANDY♡" 														then return "(X) LOVE SWEETS"
	elseif title == "CELEBRATE NITE(EURO TRANCE STYLE)" 								then return "(X) CRYSTALDIUM"
	elseif title == "D2R" 															then return "(X) CAPTURE ME"
	elseif title == "DESTINY" 														then return "(X) CAPTURE ME"
	elseif title == "DIVE TO THE NIGHT" 												then return "(X) CAPTURE ME"
	elseif title == "DROP OUT(FROM NONSTOP MEGAMIX)" 								then return "(X2) CYBER"
	elseif title == "ECSTASY (midnight blue mix)" 									then return "(X) CRYSTALDIUM"
	elseif title == "HIGHER(next morning mix)" 										then return "(X2) BOOM LIGHT"
	elseif title == "HYSTERIA 2001" 													then return "(X) DAWN STREETS"
	elseif title == "i feel ..." 													then return "(X) CRYSTALDIUM"
	elseif title == "MAXX UNLIMITED" 												then return "(A) BOOM DARK"
	elseif title == "MY SUMMER LOVE(TOMMY'S SMILE MIX)" 								then return "(X2) BOOM LIGHT"
	elseif title == "rain of sorrow" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "Secret Rendez-vous" 											then return "(X) DANCING RAYS"
	elseif title == "SEXY PLANET(FROM NONSTOP MEGAMIX)" 								then return "(X) CRYSTALDIUM"
	elseif title == "Silent Hill (3rd christmas mix)" 								then return "(X) DANCING RAYS"
	elseif title == "STILL IN MY HEART(MOMO MIX)" 									then return "(X) CRYSTALDIUM"
	elseif title == "SUPER STAR(FROM NONSTOP MEGAMIX)" 								then return "(X2) CYBER"
	elseif title == "Sweet Sweet ♥ Magic" 											then return "(X) LOVE SWEETS"
	elseif title == "TSUGARU" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "TSUGARU (APPLE MIX)"	 										then return "(X) CAPTURE ME"
	elseif title == "WILD RUSH(FROM NONSTOP MEGAMIX)" 								then return "(X) CRYSTALDIUM"
----------------------------------------------------------------------------- DDR EXTREME -----------------------------------------------------------------------------
	elseif title == "蒼い衝動 ～for EXTREME～" 											then return "(X2) CYBER"					--BLUE IMPULSE ~for EXTREME~
	elseif title == "桜" 																then return "(X) CRYSTALDIUM"				--SAKURA
	elseif title == "大見解" 															then return "(X2) CYBER"					--DAIKENKAI
	elseif title == "三毛猫ロック" 														then return "(X) DANCING RAYS"				--CALICO CAT ROCK
	elseif title == "A" 																then return "(X2) CYBER"
	elseif title == "Across the nightmare" 											then return "(X) BOOM BOOM BOOM"
	elseif title == "air" 															then return "(X) CRYSTALDIUM"
	elseif title == "AM-3P -303 BASS MIX-" 											then return "(X) BOOM BOOM BOOM"
	elseif title == "bag" 															then return "(X) CAPTURE ME"
	elseif title == "BE LOVIN" 														then return "(X2) CYBER"
	elseif title == "Colors ～for EXTREME～" 											then return "(X2) CYBER"
	elseif title == "CUTIE CHASER(MORNING MIX)" 										then return "(X) DANCING RAYS"
	elseif title == "Dance Dance Revolution" 										then return "(X) DANCING RAYS"
	elseif title == "Destiny lovers" 												then return "(X2) BOOM LIGHT"
	elseif title == "DROP THE BOMB(SyS.F. Mix)" 										then return "(X) CRYSTALDIUM"
	elseif title == "Frozen Ray ～for EXTREME～" 										then return "(X) CRYSTALDIUM"
	elseif title == "Gamelan de Couple" 												then return "(X2) BOOM LIGHT"
	elseif title == "GRADUATION ～それぞれの明日～" 										then return "(X2) BOOM LIGHT"
	elseif title == "Happy Wedding" 													then return "(X) DANCING RAYS"
	elseif title == "Heaven is a '57 metallic gray ～gimmix～" 						then return "(X) DANCING RAYS"
	elseif title == "HYPER EUROBEAT" 												then return "(X) DANCING RAYS"
	elseif title == "I'm gonna get you!" 											then return "(X) BOOM BOOM BOOM"
	elseif title == "jane jana" 														then return "(X2) BOOM LIGHT"
	elseif title == "JET WORLD" 														then return "(X) CAPTURE ME"
	elseif title == "KISS KISS KISS" 												then return "(X) DANCING RAYS"
	elseif title == "Kiss me all night long" 										then return "(X2) CYBER"
	elseif title == "LA BAMBA" 														then return "(X2) BOOM LIGHT"
	elseif title == "L'amour et la liberté(DDR Ver.)" 								then return "(X2) CYBER"
	elseif title == "LOVE♥SHINE" 													then return "(X2) BOOM LIGHT"
	elseif title == "♥Love²シュガ→♥" 													then return "(X) LOVE SWEETS"
	elseif title == "Miracle Moon ～L.E.D.LIGHT STYLE MIX～" 							then return "(X) DANCING RAYS"
	elseif title == "PARANOIA survivor" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "PARANOIA survivor MAX" 											then return "(A) BOOM DARK"
	elseif title == "Pink Rose" 														then return "(X2) CYBER"
	elseif title == "SO IN LOVE" 													then return "(X) DANCING RAYS"
	elseif title == "STAY (Organic house Version)" 									then return "(X2) BOOM LIGHT"
	elseif title == "stoic (EXTREME version)" 										then return "(X2) CYBER"
	elseif title == "sync (EXTREME version)" 										then return "(X2) CYBER"
	elseif title == "TEARS" 															then return "(X) CRYSTALDIUM"
	elseif title == "The Least 100sec" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "The legend of MAX" 												then return "(A) BOOM DARK"
	elseif title == "TRIP MACHINE survivor" 											then return "(X) CRYSTALDIUM"
	elseif title == "Twin Bee -Generation X-" 										then return "(X2) CYBER"
	elseif title == "V ～for EXTREME～" 												then return "(X) CAPTURE ME"
	elseif title == "VANITY ANGEL" 													then return "(X2) CYBER"
	elseif title == "xenon" 															then return "(X) BOOM BOOM BOOM"
	elseif title == "1998" 															then return "(X2) CYBER"
	elseif title == "321STARS" 														then return "(X) BOOM BOOM BOOM"
----------------------------------------------------------------------------- DDR SuperNOVA
	elseif title == "怒れる大きな白い馬" 													then return "(X2) CYBER"					--Tino's White Horse
	elseif title == "カゲロウ" 															then return "(X) BOOM BOOM BOOM"			--KAGEROW (Dragonfly)
	elseif title == "月光蝶" 															then return "(A) BOOM DARK"				--Gekkou chou
	elseif title == "この子の七つのお祝いに" 												then return "(X) BOOM BOOM BOOM"			--Konoko no nanatsu no oiwaini
	elseif title == "男々道" 															then return "(X) CAPTURE ME"			--DanDanDO(The true MAN's Road)
	elseif title == "チカラ" 															then return "(X2) BOOM LIGHT"				--CHIKARA
	elseif title == "虹色" 															then return "(X) CAPTURE ME"				--NIJIIRO
	elseif title == "華爛漫 -Flowers-" 												then return "(X) CRYSTALDIUM"				--Hana Ranman -Flowers-
	elseif title == "ヒマワリ" 															then return "(X2) BOOM LIGHT"				--Himawari
	elseif title == "夢幻ノ光" 															then return "(X2) CYBER"					--Mugen
	elseif title == "A Stupid Barber" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "AA" 															then return "(X2) CYBER"
	elseif title == "Bad Routine" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Baile Le Samba" 												then return "(X) DANCING RAYS"
	elseif title == "BALLAD FOR YOU～想いの雨～" 										then return "(X) DANCING RAYS"
	elseif title == "Brazilian Anthem" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "cachaca" 														then return "(X2) BOOM LIGHT"
	elseif title == "Can Be Real" 													then return "(X) DANCING RAYS"
	elseif title == "CAN'T STOP FALLIN' IN LOVE -super euro version-" 				then return "(X) CRYSTALDIUM"
	elseif title == "CENTAUR" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "CHAOS"															then return "(A) BOOM DARK"
	elseif title == "CURUS" 															then return "(X) CRYSTALDIUM"
	elseif title == "DoLL" 															then return "(X) DANCING RAYS"
	elseif title == "Dragon Blade" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Fascination ～eternal love mix～" 								then return "(A) BOOM DARK"
	elseif title == "Fascination MAXX" 												then return "(A) BOOM DARK"
	elseif title == "Flow" 															then return "(X2) CYBER"
	elseif title == "Flow (True Style)" 												then return "(X) CRYSTALDIUM"
	elseif title == "Fly away" 														then return "(X2) BOOM LIGHT"
	elseif title == "Forever Sunshine" 												then return "(X2) BOOM LIGHT"
	elseif title == "Freedom" 														then return "(X2) CYBER"
	elseif title == "Funk Boogie" 													then return "(X) DAWN STREETS"
	elseif title == "GORGEOUS 2012" 													then return "(X) DANCING RAYS"
	elseif title == "HAPPY☆ANGEL" 													then return "(X2) BOOM LIGHT"
	elseif title == "Healing-D-Vision" 												then return "(A) BOOM DARK"
	elseif title == "I Need You" 													then return "(X) DANCING RAYS"
	elseif title == "iFUTURELIST(DDR VERSION)"										then return "(X) BOOM BOOM BOOM"
	elseif title == "INNOCENCE OF SILENCE" 											then return "(X) CRYSTALDIUM"
	elseif title == "INSIDE YOUR HEART" 												then return "(X2) CYBER"
	elseif title == "Jam & Marmalade" 												then return "(X) CAPTURE ME"
	elseif title == "KEEP ON MOVIN' ～DMX MIX～" 									then return "(X2) BOOM LIGHT"
	elseif title == "LA BAMBA" 														then return "(X) DANCING RAYS"
	elseif title == "LOGICAL DASH" 													then return "(X) CAPTURE ME"
	elseif title == "LOVE IS ORANGE" 												then return "(X) DANCING RAYS"
	elseif title == "Make A Difference" 												then return "(X2) BOOM LIGHT"
	elseif title == "MARIA(I believe...)" 											then return "(X2) CYBER"
	elseif title == "MAX 300 (Super-Max-Me Mix)" 									then return "(A) BOOM DARK"
	elseif title == "MAXIMIZER" 														then return "(X2) CYBER"
	elseif title == "MIDNIGHT SPECIAL" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "Mind Parasite" 													then return "(X2) CYBER"
	elseif title == "Monkey Punk" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "MOON" 															then return "(X) DANCING RAYS"
	elseif title == "murmur twins" 													then return "(X2) BOOM LIGHT"
	elseif title == "My Only Shining Star" 											then return "(X) CAPTURE ME"
	elseif title == "No.13" 															then return "(X) CAPTURE ME"
	elseif title == "PARANOiA-Respect-" 												then return "(X) CAPTURE ME"
	elseif title == "PASSION OF LOVE" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "Polovtsian Dances And Chorus" 									then return "(X2) CYBER"
	elseif title == "PUT YOUR FAITH IN ME ～SATURDAY NIGHT MIX～" 					then return "(X) DANCING RAYS"
	elseif title == "Quick Master" 													then return "(X) CRYSTALDIUM"
	elseif title == "Quickening" 													then return "(X2) CYBER"
	elseif title == "rainbow flyer" 													then return "(X2) BOOM LIGHT"
	elseif title == "rainbow rainbow" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "RED ZONE" 														then return "(X2) CYBER"
	elseif title == "Saturday Night Love" 											then return "(X) DANCING RAYS"
	elseif title == "Scorching Moon" 												then return "(X) DAWN STREETS"
	elseif title == "SEDUCTION" 														then return "(X2) CYBER"
	elseif title == "SEDUCTION(Vocal Remix)" 										then return "(X) CRYSTALDIUM"
	elseif title == "Ska Ska No.3" 													then return "(X) DAWN STREETS"
	elseif title == "Star Gate Heaven"												then return "(X) BOOM BOOM BOOM"
	elseif title == "STARS☆☆☆(2nd NAOKI's style)"									then return "(X2) CYBER"
	elseif title == "THE SHINING POLARIS" 											then return "(X) CRYSTALDIUM"
	elseif title == "TIERRA BUENA" 													then return "(X) CAPTURE ME"
	elseif title == "TOMORROW" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "Tomorrow Perfume" 												then return "(X2) BOOM LIGHT"
	elseif title == "TRUE♥LOVE" 														then return "(X) LOVE SWEETS"
	elseif title == "Try 2 Luv. U" 													then return "(X) DANCING RAYS"
	elseif title == "un deux trois" 													then return "(X2) CYBER"
	elseif title == "Under the Sky" 													then return "(X2) BOOM LIGHT"
	elseif title == "Xepher" 														then return "(X) CRYSTALDIUM"
	elseif title == "You gotta move it (feat. Julie Rugaard)" 						then return "(X) BOOM BOOM BOOM"
----------------------------------------------------------------------------- DDR SuperNOVA 2
	elseif title == "A thing called LOVE" 											then return "(X2) BOOM LIGHT"
	elseif title == "AM-3P (\"CHAOS\" Special)" 										then return "(X) CRYSTALDIUM"
	elseif title == "Arrabbiata" 													then return "(X) CRYSTALDIUM"
	elseif title == "B4U (\"VOLTAGE\" Special)" 										then return "(X) CRYSTALDIUM"
	elseif title == "Blind Justice ～Torn souls, Hurt Faiths ～" 						then return "(X) CRYSTALDIUM"
	elseif title == "Bloody Tears(IIDX EDITION)" 									then return "(X2) CYBER"
	elseif title == "BRILLIANT 2U (\"STREAM\" Special)" 								then return "(X) CAPTURE ME"
	elseif title == "CaptivAte～誓い～" 												then return "(X) CRYSTALDIUM"
	elseif title == "D2R (\"FREEZE\" Special)" 										then return "(X) CRYSTALDIUM"
	elseif title == "DEAD END (\"GROOVE RADAR\" Special)" 							then return "(A) BOOM DARK"
	elseif title == "dream of love" 													then return "(X) DANCING RAYS"
	elseif title == "DYNAMITE RAVE (\"AIR\" Special)" 								then return "(X) CRYSTALDIUM"
	elseif title == "Electrified" 													then return "(X2) CYBER"
	elseif title == "Every Day, Every Night(NM STYLE)" 								then return "(X) DANCING RAYS"
	elseif title == "Feelings Won't Fade(Extend Trance Mix)" 						then return "(X2) CYBER"
	elseif title == "FIRE" 															then return "(X) BOOM BOOM BOOM"
	elseif title == "Flow (Jammin' Ragga Mix)" 										then return "(X) DANCING RAYS"
	elseif title == "Fly away -mix del matador-" 									then return "(X2) BOOM LIGHT"
	elseif title == "Freeway Shuffle" 												then return "(X) CRYSTALDIUM"
	elseif title == "GIRIGILI門前雀羅" 												then return "(X) DAWN STREETS"
	elseif title == "L'amour et la liberté(Darwin & DJ Silver remix)" 				then return "(X) CRYSTALDIUM"
	elseif title == "MARS WAR 3" 													then return "(X) CAPTURE ME"
	elseif title == "MOONSTER" 														then return "(X) DANCING RAYS"
	elseif title == "Music In The Rhythm"											then return "(X2) CYBER"
	elseif title == "NGO" 															then return "(A) BOOM DARK"
	elseif title == "PARANOiA ～HADES～" 												then return "(A) BOOM DARK"
	elseif title == "Pluto" 															then return "(A) BOOM DARK"
	elseif title == "Pluto Relinquish" 												then return "(X) CRYSTALDIUM"
	elseif title == "Poseidon" 														then return "(X) CAPTURE ME"
	elseif title == "Raspberry♡Heart(English version)"							 	then return "(X2) BOOM LIGHT"
	elseif title == "Saturn" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "Shades of Grey" 												then return "(X) CAPTURE ME"
	elseif title == "Silver Platform - I wanna get your heart -" 					then return "(X) CRYSTALDIUM"
	elseif title == "SOUL CRASH" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Star Gate Heaven (FUTURE LOVE Mix)"							 	then return "(X) CRYSTALDIUM"
	elseif title == "STARS☆☆☆（Re-tuned by HΛL） - DDR EDITION -" 						then return "(X) BOOM BOOM BOOM"
	elseif title == "stealth" 														then return "(X) CAPTURE ME"
	elseif title == "SUNKiSS♥DROP" 													then return "(X) LOVE SWEETS"
	elseif title == "switch" 														then return "(X) CRYSTALDIUM"
	elseif title == "Trim" 															then return "(X) CRYSTALDIUM"
	elseif title == "TRIP MACHINE PhoeniX" 											then return "(A) BOOM DARK"
	elseif title == "Trust -DanceDanceRevolution mix-" 								then return "(X2) BOOM LIGHT"
	elseif title == "Unreal" 														then return "(X2) CYBER"
	elseif title == "Uranus" 														then return "(X) CRYSTALDIUM"
	elseif title == "Vem brincar" 													then return "(X) DANCING RAYS"
	elseif title == "Venus"															then return "(X) BOOM BOOM BOOM"
	elseif title == "volcano" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "Votum stellarum -forest #25 DDR RMX-" 							then return "(X) CRYSTALDIUM"
	elseif title == "Why not" 														then return "(X) BOOM BOOM BOOM"
----------------------------------------------------------------------------- DDR X
	elseif title == "スキ☆メロ" 															then return "(X) LOVE SWEETS"				--Suki Melo
	elseif title == "ポリリズム" 															then return "(X) LOVE SWEETS"				--PORIRIZUMU
	elseif title == "世界は踊る" 														then return "(X) CRYSTALDIUM"				--SEKAI HA ODORU
	elseif title == "凛として咲く花の如く" 													then return "(X2) BOOM LIGHT"				--Rin To Shite Saku Hana No Gotoku
	elseif title == "旅人" 															then return "(X2) BOOM LIGHT"				--Tabibito
	elseif title == "零 - ZERO -" 													then return "(X) BOOM BOOM BOOM"			--ZERO
	elseif title == "革命(X-Special)" 												then return "(X) CAPTURE ME"				--KAKUMEI(X-Special)
	elseif title == "A Geisha's Dream" 												then return "(X) DANCING RAYS"
	elseif title == "AFRONOVA(X-Special)" 											then return "(X) CRYSTALDIUM"
	elseif title == "Always on My Mind"	 											then return "(X) DANCING RAYS"
	elseif title == "Beautiful Inside (Cube::Hard Mix)" 								then return "(X) CRYSTALDIUM"
	elseif title == "Big Girls Don't Cry" 											then return "(X) LOVE SWEETS"
	elseif title == "Blue Rain" 														then return "(X2) CYBER"
	elseif title == "Boys (2008 X-edit)" 											then return "(X) DANCING RAYS"
	elseif title == "Butterfly (2008 X-edit)" 										then return "(X) DANCING RAYS"
	elseif title == "CANDY☆(X-Special)" 												then return "(X) CRYSTALDIUM"
	elseif title == "Chance and Dice" 												then return "(X) CAPTURE ME"
	elseif title == "Dance Celebration" 												then return "(X) DAWN STREETS"
	elseif title == "Dance Celebration (System 7 Remix)" 							then return "(X) BOOM BOOM BOOM"
	elseif title == "Dance Dance Revolution(X-Special)" 								then return "(REPLICANT) LIGHT PURPLE"
	elseif title == "Dance Floor" 													then return "(X) DANCING RAYS"
	elseif title == "dazzle" 														then return "(X) CRYSTALDIUM"
	elseif title == "Dream Machine" 													then return "(X2) BOOM LIGHT"
	elseif title == "DUB-I-DUB (2008 X-edit)" 										then return "(X) LOVE SWEETS"
	elseif title == "Feel" 															then return "(X) BOOM BOOM BOOM"
	elseif title == "Flight of the Phoenix" 											then return "(X) CRYSTALDIUM"
	elseif title == "Flourish" 														then return "(X) DANCING RAYS"
	elseif title == "GET UP'N MOVE (2008 X-edit)" 									then return "(X) DAWN STREETS"
	elseif title == "Ghetto Blasta Deluxe" 											then return "(X) BOOM BOOM BOOM"
	elseif title == "Happy" 															then return "(X) BOOM BOOM BOOM"
	elseif title == "Healing Vision(X-Special)" 										then return "(X) CRYSTALDIUM"
	elseif title == "Here It Goes Again" 											then return "(X) DANCING RAYS"
	elseif title == "Horatio" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "Inspiration" 													then return "(X) CAPTURE ME"
	elseif title == "INTO YOUR HEART (Ruffage remix)" 								then return "(X) DANCING RAYS"
	elseif title == "Koko Soko"						 								then return "(X) DANCING RAYS"
	elseif title == "Lift You Up" 													then return "(X) DANCING RAYS"
	elseif title == "LOVING YOU (Epidemik remix)" 									then return "(X2) BOOM LIGHT"
	elseif title == "Make Me Cry"				 									then return "(X) CRYSTALDIUM"
	elseif title == "Malacca" 														then return "(X2) CYBER"
	elseif title == "MAX 300(X-Special)" 											then return "(REPLICANT) LIGHT PURPLE"
	elseif title == "MAXX UNLIMITED(X-Special)" 										then return "(X) CRYSTALDIUM"
	elseif title == "on the bounce" 													then return "(X) CRYSTALDIUM"
	elseif title == "On The Break" 													then return "(X) CAPTURE ME"
	elseif title == "PARANOiA ETERNAL(X-Special)" 									then return "(X) CRYSTALDIUM"
	elseif title == "PARANOIA EVOLUTION(X-Special)" 									then return "(X) CRYSTALDIUM"
	elseif title == "PARANOiA MAX～DIRTY MIX～(X-Special)" 							then return "(X) CAPTURE ME"
	elseif title == "PARANOiA Rebirth(X-Special)" 									then return "(X) CRYSTALDIUM"
	elseif title == "PARANOiA(X-Special)" 											then return "(X) CRYSTALDIUM"
	elseif title == "Party Lights" 													then return "(X) DANCING RAYS"
	elseif title == "Playa (Original Mix)" 											then return "(X) DANCING RAYS"
	elseif title == "Put 'Em Up"			 											then return "(X) DANCING RAYS"
	elseif title == "puzzle" 														then return "(X) CAPTURE ME"
	elseif title == "Reach Up" 														then return "(X) CRYSTALDIUM"
	elseif title == "SABER WING" 													then return "(X2) CYBER"
	elseif title == "SABER WING (Akira Ishihara Headshot mix)" 						then return "(X) CRYSTALDIUM"
	elseif title == "S・A・G・A" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "Slip Out" 														then return "(X) DANCING RAYS"
	elseif title == "Slip Out (bounce in beat mix)" 									then return "(X2) BOOM LIGHT"
	elseif title == "SP-TRIP MACHINE～JUNGLE MIX～(X-Special)" 						then return "(X) CRYSTALDIUM"
	elseif title == "SUPER SAMURAI" 													then return "(X2) CLUB"
	elseif title == "Swingin'"	 													then return "(X) DAWN STREETS"
	elseif title == "Taj He Spitz" 													then return "(X) DAWN STREETS"
	elseif title == "Taj He Spitz (Tommie Sunshine's Brooklyn Fire Re-Touch)" 		then return "(X) DAWN STREETS"
	elseif title == "Take A Chance" 													then return "(X) DANCING RAYS"
	elseif title == "The flower in your smile" 										then return "(X2) BOOM LIGHT"
	elseif title == "The legend of MAX(X-Special)" 									then return "(X) CRYSTALDIUM"
	elseif title == "Ticket to Bombay" 												then return "(X) DANCING RAYS"
	elseif title == "Till the lonely's gone" 										then return "(X) DANCING RAYS"
	elseif title == "TimeHollow" 													then return "(X) CRYSTALDIUM"
	elseif title == "Tracers (4Beat Remix)" 											then return "(X) CAPTURE ME"
	elseif title == "Trickster"			 											then return "(X) DANCING RAYS"
	elseif title == "Trigger" 														then return "(X) CAPTURE ME"
	elseif title == "TRIP MACHINE CLIMAX(X-Special)" 								then return "(X) CRYSTALDIUM"
	elseif title == "TRIP MACHINE(X-Special)" 										then return "(X) CRYSTALDIUM"
	elseif title == "U Can't Touch This"			 									then return "(X) DANCING RAYS"
	elseif title == "Übertreffen" 													then return "(X) DANCING RAYS"
	elseif title == "Waiting 4 u" 													then return "(X2) CYBER"
	elseif title == "We Come Alive" 													then return "(X) DANCING RAYS"
	elseif title == "We've Got To Make It Tonight" 									then return "(X) DANCING RAYS"
	elseif title == "will" 															then return "(X) CRYSTALDIUM"
	elseif title == "Xmix1 (Midnight Dawn)" 											then return "(X) BOOM BOOM BOOM"
	elseif title == "Xmix2 (Beats 'n Bangs)" 										then return "(X) DAWN STREETS"
	elseif title == "Xmix3 (Stomp Dem Groove)" 										then return "(X) CRYSTALDIUM"
	elseif title == "Xmix4 (Linear Momentum)" 										then return "(X) BOOM BOOM BOOM"
	elseif title == "Xmix5 (Overcrush)" 												then return "(X) DANCING RAYS"
	elseif title == "30 Lives (Up-Up-Down-Dance Mix)" 								then return "(X2) BOOM LIGHT"
----------------------------------------------------------------------------- DDR X2 ---------------------------------------------------------------------------------
	elseif title == "不沈艦CANDY" 														then return "(X2) MOVIE LIGHT"				--YELLOW CANDY
	elseif title == "冥" 																then return "(X2) MOVIE LIGHT"				--Mei
	elseif title == "A Brighter Day" 												then return "(X2) CYBER"
	elseif title == "aftershock!!" 													then return "(X2) CYBER"
	elseif title == "All My Love" 													then return "(X2) BIG SCREEN"				
	elseif title == "Anti-Matter" 													then return "(REPLICANT) LIGHT PURPLE"	
	elseif title == "BALLAD THE FEATHERS" 											then return "(X2) MOVIE LIGHT"
	elseif title == "Be your wings" 													then return "(X) DANCING RAYS"
	elseif title == "Bonafied Lovin'" 												then return "(X) DAWN STREETS"
	elseif title == "CG Project" 													then return "(X2) CYBER"
	elseif title == "Crazy Control" 													then return "(X) DAWN STREETS"
	elseif title == "DAFT PUNK IS PLAYING AT MY HOUSE" 								then return "(X) DANCING RAYS"
	elseif title == "Dazzlin' Darlin" 												then return "(X2) BOOM LIGHT"
	elseif title == "Dazzlin' Darlin-秋葉工房mix-" 									then return "(X) CRYSTALDIUM"
	elseif title == "Decade" 														then return "(X2) MOVIE LIGHT"
	elseif title == "ΔMAX" 															then return "(X2) CYBER"
	elseif title == "dirty digital" 													then return "(A) BOOM DARK"
	elseif title == "DROP" 															then return "(X2) BOOM LIGHT"
	elseif title == "Dummy" 															then return "(X2) CYBER"
	elseif title == "ETERNITY" 														then return "(X2) BOOM LIGHT"
	elseif title == "Everytime We Touch" 											then return "(X2) CLUB"
	elseif title == "EZ DO DANCE" 													then return "(X) DANCING RAYS"
	elseif title == "Feel Good Inc" 													then return "(X2) CYBER"
	elseif title == "FIRE FIRE" 														then return "(X2) MOVIE LIGHT"
	elseif title == "Freeze" 														then return "(X) CRYSTALDIUM"
	elseif title == "going up" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "GOLD RUSH" 														then return "(X) DANCING RAYS"
	elseif title == "Gotta Dance" 													then return "(X) DANCING RAYS"
	elseif title == "Heatstroke" 													then return "(X) DANCING RAYS"
	elseif title == "Hide-away" 														then return "(X) DANCING RAYS"
	elseif title == "ICE ICE BABY" 													then return "(X2) CYBER"
	elseif title == "IF YOU WERE HERE (L.E.D.-G STYLE REMIX)" 						then return "(X2) CYBER"
	elseif title == "I'm so Happy" 													then return "(X2) BOOM LIGHT"
	elseif title == "in love wit you" 												then return "(X) DANCING RAYS"
	elseif title == "KIMONO♥PRINCESS" 												then return "(X2) BIG SCREEN"
	elseif title == "KISS KISS KISS 秋葉工房 MIX" 										then return "(X2) MOVIE LIGHT"
	elseif title == "La libertad" 													then return "(X2) BOOM LIGHT"
	elseif title == "La receta" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "Leaving…" 														then return "(X2) MOVIE DARK"
	elseif title == "Love Again" 													then return "(X2) CLUB"
	elseif title == "MAX LOVE" 														then return "(X) LOVE SWEETS"
	elseif title == "Melody Life" 													then return "(X2) BOOM LIGHT"
	elseif title == "more more more" 												then return "(X2) CLUB"
	elseif title == "New Decade" 													then return "(REPLICANT) LIGHT PURPLE"
	elseif title == "oarfish" 														then return "(X2) CYBER"
	elseif title == "only my railgun" 												then return "(X) CRYSTALDIUM"
	elseif title == "Pierce The Sky" 												then return "(REPLICANT) LIGHT BLUE"
	elseif title == "Pluto The First" 												then return "(A) BOOM DARK"
	elseif title == "Poseidon(kors k mix)" 											then return "(X2) MOVIE LIGHT"
	elseif title == "POSSESSION" 													then return "(REPLICANT) LIGHT PURPLE"
	elseif title == "real-high-SPEED" 												then return "(X2) BOOM LIGHT"
	elseif title == "resonance" 														then return "(X2) CYBER"
	elseif title == "roppongi EVOLVED ver.A" 										then return "(X2) CYBER"
	elseif title == "roppongi EVOLVED ver.B" 										then return "(X2) CYBER"
	elseif title == "roppongi EVOLVED ver.C" 										then return "(X2) CYBER"
	elseif title == "roppongi EVOLVED ver.D" 										then return "(X2) MOVIE LIGHT"
	elseif title == "Sacred Oath" 													then return "(X2) CYBER"
	elseif title == "sakura storm" 													then return "(X2) BIG SCREEN"
	elseif title == "Sakura Sunrise" 												then return "(REPLICANT) LIGHT BLUE"
	elseif title == "Second Heaven" 													then return "(X2) MOVIE LIGHT"
	elseif title == "She is my wife" 												then return "(X2) BOOM LIGHT"
	elseif title == "Shine" 															then return "(X2) BOOM LIGHT"
	elseif title == "☆shining☆" 														then return "(X2) BIG SCREEN"
	elseif title == "Shiny World" 													then return "(REPLICANT) LIGHT BLUE"
	elseif title == "Sky Is The Limit" 												then return "(X2) MOVIE LIGHT"
	elseif title == "smooooch･∀･" 													then return "(X2) CYBER"
	elseif title == "someday..." 													then return "(X2) BIG SCREEN"
	elseif title == "Super Driver" 													then return "(X2) CYBER"
	elseif title == "SUPER EUROBEAT <GOLD MIX>" 										then return "(X2) BOOM LIGHT"
	elseif title == "Taking It To The Sky" 											then return "(X2) BOOM LIGHT"
	elseif title == "TENSHI" 														then return "(X2) CYBER"
	elseif title == "Theory of Eternity" 											then return "(X) CRYSTALDIUM"
	elseif title == "THIS NIGHT" 													then return "(X) DANCING RAYS"
	elseif title == "Time After Time" 												then return "(X) DANCING RAYS"
	elseif title == "Valkyrie dimension" 											then return "(REPLICANT) DARK PURPLE"
	elseif title == "VANESSA" 														then return "(X2) MOVIE DARK"
	elseif title == "WH1TE RO5E" 													then return "(X2) MOVIE LIGHT"
	elseif title == "What Will Come of Me" 											then return "(X) BOOM BOOM BOOM"
	elseif title == "You are a Star" 												then return "(X2) CYBER"
	elseif title == "Your Angel" 													then return "(X) CRYSTALDIUM"
	elseif title == "ZETA～素数の世界と超越者～" 											then return "(X2) MOVIE LIGHT"				--ZETA ~The World of Prime Numbers and the Transcendental Being~
	elseif title == "888" 															then return "(X2) CYBER"
----------------------------------------------------------------------------- DDR X3 vs 2ndMIX
	elseif title == "アルストロメリア (walk with you remix)" 								then return "(X2) BOOM LIGHT"				--Alstroemeria (walk with you remix)
	elseif title == "紅焔" 															then return "(X) CRYSTALDIUM"				--Kouen
	elseif title == "雫" 																then return "(A) BOOM DARK"				--Shizuku
	elseif title == "隅田川夏恋歌" 														then return "(X) CRYSTALDIUM"				--Sumidagawa karenka
	elseif title == "天上の星 ～黎明記～" 												then return "(X2) CYBER"					--Tenjou no Hoshi -Reimeiki-
	elseif title == "コネクト" 															then return "(X2) CYBER"					--Connect
	elseif title == "ヘビーローテーション" 													then return "(X) LOVE SWEETS"				--Heavy Rotation
	elseif title == "ビューティフル レシート" 													then return "(X2) BOOM LIGHT"				--Beautiful Receipt
	elseif title == "女々しくて" 														then return "(X) DANCING RAYS"				--Memeshikute
	elseif title == "繚乱ヒットチャート" 													then return "(X2) MOVIE LIGHT"				--Ryouran Hit Chart
	elseif title == "恋閃繚乱" 														then return "(X) CRYSTALDIUM"				--Rensen ryouran
	elseif title == "Amalgamation" 													then return "(A) BOOM DARK"
	elseif title == "BRILLIANT 2U (AKBK MIX)" 										then return "(X2) CYBER"
	elseif title == "Chronos" 														then return "(X2) CLUB"
	elseif title == "COME BACK TO MY HEART" 											then return "(X2) CYBER"
	elseif title == "Cosmic Hurricane" 												then return "(X) CRYSTALDIUM"
	elseif title == "CRAZY♥LOVE" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Diamond Dust" 													then return "(X) CRYSTALDIUM"
	elseif title == "dreaming can make a wish come true" 							then return "(X2) CLUB"
	elseif title == "ever snow" 														then return "(X) CRYSTALDIUM"
	elseif title == "Fever" 															then return "(X2) CLUB"
	elseif title == "Find You Again" 												then return "(X2) CLUB"
	elseif title == "FLOWER" 														then return "(X) CRYSTALDIUM"
	elseif title == "future gazer" 													then return "(X2) BOOM LIGHT"
	elseif title == "Get Back Up!" 													then return "(X2) CLUB"
	elseif title == "Go For The Top" 												then return "(REPLICANT) LIGHT BLUE"
	elseif title == "Haunted Rhapsody" 												then return "(X2) CLUB"
	elseif title == "HEART BEAT FORMULA" 											then return "(X2) BOOM LIGHT"
	elseif title == "HEARTBREAK (Sound Selektaz remix)" 								then return "(X2) CLUB"
	elseif title == "I/O" 															then return "(X2) CYBER"
	elseif title == "In The Air" 													then return "(X2) BOOM LIGHT"
	elseif title == "IN THE ZONE" 													then return "(X) DAWN STREETS"
	elseif title == "KEEP ON MOVIN' (Y&Co. DJ BOSS remix)" 							then return "(X2) BOOM LIGHT"
	elseif title == "Let's Get Away" 												then return "(X) CRYSTALDIUM"
	elseif title == "London EVOLVED Ver.A" 											then return "(X2) CLUB"
	elseif title == "London EVOLVED Ver.B" 											then return "(X2) CLUB"
	elseif title == "London EVOLVED Ver.C" 											then return "(X2) CLUB"
	elseif title == "LOVE & JOY" 													then return "(X2) BOOM LIGHT"
	elseif title == "LOVE IS THE POWER -Re:born-" 									then return "(X) DANCING RAYS"
	elseif title == "MAGIC PARADE" 													then return "(X) CRYSTALDIUM"
	elseif title == "Mermaid girl" 													then return "(X) CRYSTALDIUM"
	elseif title == "message" 														then return "(X2) BOOM LIGHT"
	elseif title == "NEPHILIM DELTA" 												then return "(A) BOOM DARK"
	elseif title == "New Beginning" 													then return "(X) CRYSTALDIUM"
	elseif title == "New York EVOLVED (Type A)" 										then return "(A) BOOM DARK"
	elseif title == "New York EVOLVED (Type B)" 										then return "(A) BOOM DARK"
	elseif title == "New York EVOLVED (Type C)" 										then return "(A) BOOM DARK"
	elseif title == "osaka EVOLVED -毎度、おおきに！- (TYPE1)" 							then return "(X2) CLUB"
	elseif title == "osaka EVOLVED -毎度、おおきに！- (TYPE2)" 							then return "(X2) CLUB"
	elseif title == "osaka EVOLVED -毎度、おおきに！- (TYPE3)" 							then return "(X2) CLUB"
	elseif title == "PARANOiA (kskst mix)" 											then return "(A) BOOM DARK"
	elseif title == "PARANOiA Revolution" 											then return "(X2) MOVIE DARK"
	elseif title == "Private Eye" 													then return "(X) CRYSTALDIUM"
	elseif title == "Programmed Universe" 											then return "(X2) CYBER"
	elseif title == "PUT YOUR FAITH IN ME (DA's Twinkly Disco Remix)" 				then return "(X) DANCING RAYS"
	elseif title == "REBORN MAGIC" 													then return "(X2) CYBER"
	elseif title == "Rescue Me" 														then return "(X2) CLUB"
	elseif title == "Resurrection" 													then return "(X) CRYSTALDIUM"
	elseif title == "REVOLUTIONARY ADDICT" 											then return "(REPLICANT) LIGHT BLUE"
	elseif title == "Rhythms Inside" 												then return "(X2) CLUB"
	elseif title == "Seasons" 														then return "(X) DANCING RAYS"
	elseif title == "Seule" 															then return "(X) BOOM BOOM BOOM"
	elseif title == "Share The Love" 												then return "(X2) BOOM LIGHT"
	elseif title == "SigSig" 														then return "(X2) CLUB"
	elseif title == "SILVER☆DREAM" 													then return "(X) CRYSTALDIUM"
	elseif title == "snow prism" 													then return "(X) CRYSTALDIUM"
	elseif title == "Something Special" 												then return "(X) DANCING RAYS"
	elseif title == "STRAIGHT JET" 													then return "(X2) BOOM LIGHT"
	elseif title == "Take A Step Forward" 											then return "(X2) CYBER"
	elseif title == "The Heavens Above" 												then return "(X) CRYSTALDIUM"
	elseif title == "TIME" 															then return "(X2) BOOM LIGHT"
	elseif title == "Tohoku EVOLVED" 												then return "(X) CRYSTALDIUM"
	elseif title == "tokyoEVOLVED (TYPE1)" 											then return "(X2) CLUB"
	elseif title == "tokyoEVOLVED (TYPE2)" 											then return "(X2) CLUB"
	elseif title == "tokyoEVOLVED (TYPE3)" 											then return "(X2) CLUB"
	elseif title == "Tribe" 															then return "(X) DANCING RAYS"
	elseif title == "TRIP MACHINE (xac nanoglide mix)" 								then return "(A) BOOM DARK"
	elseif title == "TRIP MACHINE EVOLUTION" 										then return "(X2) MOVIE DARK"
	elseif title == "TWINKLE♡HEART" 													then return "(X2) BOOM LIGHT"
	elseif title == "UNBELIEVABLE (Sparky remix)" 									then return "(X2) CYBER"
	elseif title == "Until the End" 													then return "(A) BOOM DARK"
	elseif title == "Wicked Plastik" 												then return "(X2) CYBER"
	elseif title == "Wings of an Angel (Fly With Me)" 								then return "(X) CRYSTALDIUM"
----------------------------------------------------------------------------- DDR 2013 -----------------------------------------------------------------------------
	elseif title == "つけまつける" 														then return "(X) DANCING RAYS"				--Tsukematsukeru
	elseif title == "ふりそでーしょん" 														then return "(X) DANCING RAYS"				--Furisodation
	elseif title == "ウッーウッーウマウマ(ﾟ∀ﾟ)(Speedcake Remix)" 								then return "(X) DANCING RAYS"				--U-u-uma uma (Speedcake Remix)
	elseif title == "お米の美味しい炊き方、そしてお米を食べることによるその効果。" 						then return "(X2) CYBER"					--Okome no oishii takikata, soshite okome wo taberu koto ni yoru sono kouka
	elseif title == "オリオンをなぞる" 														then return "(X) DANCING RAYS"				--Orion wo nazoru
	elseif title == "からふるぱすてる" 													then return "(X2) BIG SCREEN"				--Colorful Pastel
	elseif title == "キケンな果実"													 	then return "(X2) BOOM LIGHT"				--Kiken na kajitsu
	elseif title == "ジョジョ～その血の運命～"												then return "(X) DANCING RAYS"				--JoJo ~Sono Chi no Sadame~
	elseif title == "ずっとみつめていて (Ryu☆Remix)"										then return "(X) DANCING RAYS"				--Zutto Mitsu Meteite (Ryu Remix)
	elseif title == "晴天Bon Voyage"													then return "(X) CRYSTALDIUM"				--Seiten Bon Voyage
	elseif title == "創世ノート"															then return "(X2) BOOM LIGHT"				--Sousei Note
	elseif title == "ちくわパフェだよ☆CKP"													then return "(X) LOVE SWEETS"				--Chikuwa parfait da yo CKP
	elseif title == "†渚の小悪魔ラヴリィ～レイディオ†" 											then return "(X) DANCING RAYS"				--Nagisa no koakuma lovely~radio
	elseif title == "虹色の花"															then return "(X) BOOM BOOM BOOM"			--Nijiiro no hana
	elseif title == "フー・フローツ"														then return "(X) CRYSTALDIUM"				--Who Floats
	elseif title == "マジLOVE1000%"													then return "(X) DANCING RAYS"				--Maji LOVE 1000%
	elseif title == "めうめうぺったんたん！！"													then return "(X) LOVE SWEETS"				--Meumeupettantan!!
	elseif title == "ラキラキ"															then return "(X2) BOOM LIGHT"				--Lucky Lucky
	elseif title == "凛として咲く花の如く ～ひなビタ♪ edition～"									then return "(X) LOVE SWEETS"				--Rin to shite saku hana no gotoku ~HinaBitter edition~
	elseif title == "ロンドンは夜8時(LON 8PM - TYO 4AM)" 									then return "(X) DANCING RAYS"				--London wa Yoru 8 Ji (LON 8PM - TYO 4AM)
	elseif title == "折れないハート" 														then return "(X) DANCING RAYS"				--Orenai Heart
	elseif title == "ACROSS WORLD" 													then return "(X2) BOOM LIGHT"
	elseif title == "Ah La La La" 													then return "(X) DANCING RAYS"
	elseif title == "Air Heroes" 													then return "(X) DANCING RAYS"
	elseif title == "Another Phase" 													then return "(A) BOOM DARK"
	elseif title == "Back In Your Arms" 												then return "(X2) CLUB"
	elseif title == "Beautiful Dream" 												then return "(X2) BOOM LIGHT"
	elseif title == "Blew My Mind" 													then return "(A) BOOM DARK"
	elseif title == "Bombay Bomb" 													then return "(X) DANCING RAYS"
	elseif title == "BRIGHT STREAM" 													then return "(X) DANCING RAYS"
	elseif title == "Burst The Gravity" 												then return "(X) DANCING RAYS"
	elseif title == "Children of the Beat" 											then return "(X) DANCING RAYS"
	elseif title == "Chinese Snowy Dance" 											then return "(X2) BOOM LIGHT"
	elseif title == "Choo Choo TRAIN" 												then return "(X) DANCING RAYS"
	elseif title == "Condor" 														then return "(X) DANCING RAYS"
	elseif title == "Confession" 													then return "(X) DANCING RAYS"
	elseif title == "Desert Journey" 												then return "(X) DANCING RAYS"
	elseif title == "Diamond Night" 													then return "(X) DANCING RAYS"
	elseif title == "Elemental Creation" 											then return "(A) BOOM DARK"
	elseif title == "Empathetic" 													then return "(X) CRYSTALDIUM"
	elseif title == "escape" 														then return "(X) DANCING RAYS"
	elseif title == "Everything I Need" 												then return "(X) DANCING RAYS"
	elseif title == "Find The Way" 													then return "(X2) BOOM LIGHT"
	elseif title == "GAIA" 															then return "(X2) CYBER"
	elseif title == "heron" 															then return "(X2) CYBER"
	elseif title == "Hoping To Be Good" 												then return "(X) DANCING RAYS"
	elseif title == "JOKER" 															then return "(X) LOVE SWEETS"
	elseif title == "LOVE & JOY -Risk Junk MIX-" 									then return "(X) DANCING RAYS"
	elseif title == "Magnetic" 														then return "(X2) CYBER"
	elseif title == "Mickey Mouse March(Eurobeat Version)" 							then return "(X) DANCING RAYS"
	elseif title == "Monkey Business" 												then return "(A) BOOM DARK"
	elseif title == "New Generation" 												then return "(X) DANCING RAYS"
	elseif title == "New Gravity" 													then return "(X) DANCING RAYS"
	elseif title == "nightbird lost wing" 											then return "(X) CRYSTALDIUM"
	elseif title == "PRANA" 															then return "(X) CRYSTALDIUM"
	elseif title == "printemps" 														then return "(X) CRYSTALDIUM"
	elseif title == "Qipchãq" 														then return "(X) CRYSTALDIUM"
	elseif title == "Right on time (Ryu☆Remix)" 										then return "(X) DANCING RAYS"
	elseif title == "RЁVOLUTIФN" 													then return "(X) DANCING RAYS"
	elseif title == "sola" 															then return "(X2) BOOM LIGHT"
	elseif title == "Somehow You Found Me" 											then return "(X) DANCING RAYS"
	elseif title == "south" 															then return "(X) DANCING RAYS"
	elseif title == "Spanish Snowy Dance" 											then return "(X) DANCING RAYS"
	elseif title == "Starry HEAVEN" 													then return "(X) DANCING RAYS"
	elseif title == "Straight Oath" 													then return "(X) DANCING RAYS"
	elseif title == "STULTI" 														then return "(X2) CYBER"
	elseif title == "Sucka Luva" 													then return "(X) CRYSTALDIUM"
	elseif title == "Summer Fairytale" 												then return "(X) DANCING RAYS"
	elseif title == "Sweet Rain" 													then return "(X) DANCING RAYS"
	elseif title == "Synergy For Angels" 											then return "(X2) CYBER"
	elseif title == "Tell me what to do" 											then return "(X) DANCING RAYS"
	elseif title == "The Island Song" 												then return "(X) DANCING RAYS"
	elseif title == "THE REASON" 													then return "(X) DANCING RAYS"
	elseif title == "The Wind of Gold" 												then return "(X2) CYBER"
	elseif title == "Top The Charts" 												then return "(X) DANCING RAYS"
	elseif title == "Triple Journey -TAG EDITION-" 									then return "(X) CRYSTALDIUM"
	elseif title == "WILD SIDE" 														then return "(X) DANCING RAYS"
	elseif title == "Windy Fairy" 													then return "(X2) CYBER"
	elseif title == "Wow Wow VENUS" 													then return "(X) DANCING RAYS"
	elseif title == "You" 															then return "(X) DANCING RAYS"
----------------------------------------------------------------------------- DDR 2014 ---------------------------------------------------------------------------------
	elseif title == "朝色の紙飛行機" 													then return "(X2) CYBER"					--Asa-iro no kami hikouki
	elseif title == "妖隠し -あやかしかくし-" 												then return "(A) BOOM DARK"				--Ayakashi kakushi
	elseif title == "阿波おどり -Awaodori- やっぱり踊りはやめられない" 							then return "(X2) BOOM LIGHT"				--Awa odori -Awaodori- yappari odori wa yame rarenai
	elseif title == "エンドルフィン" 														then return "(X2) CYBER"					--Endorphin
	elseif title == "御千手メディテーション" 													then return "(X2) CYBER"					--Osenju meditation
	elseif title == "乙女繚乱 舞い咲き誇れ" 												then return "(X) LOVE SWEETS"				--Otome ryouran mai sakihokore
	elseif title == "女言葉の消失" 														then return "(X2) BOOM LIGHT"				--Onna kotoba no shoushitsu
	elseif title == "クリムゾンゲイト" 														then return "(A) BOOM DARK"				--Crimson Gate
	elseif title == "激アツ☆マジヤバ☆チアガール" 												then return "(X2) BOOM LIGHT"				--Gekiatsu majiyaba cheer girl
	elseif title == "幻想系世界修復少女" 												then return "(X) CRYSTALDIUM"				--Gensoukei sekai shuufuku shoujo
	elseif title == "恋はどう？モロ◎波動OK☆方程式！！" 										then return "(X) LOVE SWEETS"				--Koi hadou Moro Hadou OK Houteishiki!!
	elseif title == "漆黒のスペシャルプリンセスサンデー" 											then return "(X) BOOM BOOM BOOM"			--Shikkoku no special princess sundae
	elseif title == "灼熱Beach Side Bunny" 											then return "(X2) BOOM LIGHT"				--Shakunetsu Beach Side Bunny
	elseif title == "セツナトリップ" 														then return "(X2) BOOM LIGHT"				--Setsuna Trip
	elseif title == "地方創生☆チクワクティクス" 												then return "(X) LOVE SWEETS"				--Chihou sousei chikuwactics
	elseif title == "ちゅ～いん☆バニー" 													then return "(X) LOVE SWEETS"				--Chewin' Bunny
	elseif title == "チョコレートスマイル" 													then return "(X) LOVE SWEETS"				--Chocolate Smile
	elseif title == "デッドボヲルdeホームラン" 												then return "(X) DANCING RAYS"				--Deadball de homerun
	elseif title == "天空の華" 														then return "(A) BOOM DARK"				--Tenkuu no hana
	elseif title == "ドーパミン" 															then return "(A) BOOM DARK"				--Dopamine
	elseif title == "ドキドキ☆流星トラップガール!!" 											then return "(X) CRYSTALDIUM"				--Dokidoki ryuusei trap girl!!
	elseif title == "突撃！ガラスのニーソ姫！" 												then return "(X) CRYSTALDIUM"				--Totsugeki! Glass no kneeso hime!
	elseif title == "轟け！恋のビーンボール！！" 												then return "(X2) BOOM LIGHT"				--Todoroke! Koi no beanball!!
	elseif title == "嘆きの樹" 															then return "(A) BOOM DARK"				--Nageki no ki
	elseif title == "夏色DIARY -DDR mix-" 											then return "(X) BOOM BOOM BOOM"			--SUMMER DIARY -DDR mix-
	elseif title == "爆なな☆てすとロイヤー" 													then return "(X) LOVE SWEETS"				--Bakunana Testroyer
	elseif title == "はなまるぴっぴはよいこだけ" 												then return "(X) DANCING RAYS"				--Hanamaru pippi wa yoiko dake
	elseif title == "パ→ピ→プ→Yeah!" 													then return "(X) LOVE SWEETS"				--Pa pi pu Yeah!
	elseif title == "バンブーソード・ガール" 													then return "(X2) CYBER"					--Bamboo Sword Girl
	elseif title == "ビビットストリーム" 													then return "(X) DANCING RAYS"				--BeBeatStream
	elseif title == "星屑のキロク" 														then return "(X) CRYSTALDIUM"				--Hoshikuzu no kiroku
	elseif title == "ホメ猫☆センセーション" 													then return "(X) LOVE SWEETS"				--Home neko sensation
	elseif title == "マインド・ゲーム" 														then return "(X2) BOOM LIGHT"				--Mind Game
	elseif title == "回レ！雪月花" 														then return "(X2) BIG SCREEN"				--Maware! Setsugetsuka
	elseif title == "ミライプリズム" 														then return "(X) CRYSTALDIUM"				--Mirai prism
	elseif title == "滅亡天使 † にこきゅっぴん" 												then return "(X) LOVE SWEETS"				--Metsubou tenshi nikokyuppin
	elseif title == "野球の遊び方　そしてその歴史　～決定版～" 									then return "(X) DANCING RAYS"				--Yakyuu no asobikata soshite sono rekishi ~ketteiban~
	elseif title == "ヤマトなでなで♡かぐや姫" 												then return "(X) CRYSTALDIUM"				--Yamato nadenade Kaguya-hime
	elseif title == "ラクガキスト" 														then return "(X) DAWN STREETS"				--Luckgakist
	elseif title == "海神" 															then return "(A) BOOM DARK" 				--Wadatsumi
	elseif title == "Adularia" 														then return "(X2) CYBER"
	elseif title == "ÆTHER" 															then return "(X) CRYSTALDIUM"
	elseif title == "AWAKE" 															then return "(X) CRYSTALDIUM"
	elseif title == "chaos eater" 													then return "(A) BOOM BLUE"
	elseif title == "Cleopatrysm" 													then return "(X) CRYSTALDIUM"
	elseif title == "Daily Lunch Special" 											then return "(X) CRYSTALDIUM"
	elseif title == "Dance Partay" 													then return "(X) DANCING RAYS"
	elseif title == "Destination" 													then return "(A) BOOM GREEN"
	elseif title == "Din Don Dan" 													then return "(X) DANCING RAYS"
	elseif title == "Dispersion Star" 												then return "(X2) CYBER"
	elseif title == "Do The Evolution" 												then return "(X2) BOOM LIGHT"
	elseif title == "Dreamin'" 														then return "(X) CRYSTALDIUM"
	elseif title == "EGOISM 440" 													then return "(REPLICANT) RED"
	elseif title == "Electronic or Treat!" 											then return "(X) BOOM BOOM BOOM"
	elseif title == "Elysium" 														then return "(X) DANCING RAYS"
	elseif title == "Engraved Mark" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "esrev:eR" 														then return "(X) DANCING RAYS"
	elseif title == "Follow Tomorrow" 												then return "(X2) BOOM LIGHT"
	elseif title == "FUJIMORI -祭- FESTIVAL" 											then return "(X2) BOOM LIGHT"
	elseif title == "FUNKY SUMMER BEACH" 											then return "(A) BOOM DARK"
	elseif title == "Go↓Go↑Girls&Boys!" 												then return "(X2) BOOM LIGHT"
	elseif title == "Habibe (Antuh muhleke)" 										then return "(X) CRYSTALDIUM"
	elseif title == "HAPPY☆LUCKY☆YEAPPY" 											then return "(A) BOOM WHITE"
	elseif title == "HEART BEAT FORMULA (Vinyl Mix)" 								then return "(X) LOVE SWEETS"
	elseif title == "HYENA" 															then return "(X2) CYBER"
	elseif title == "Idola" 															then return "(A) BOOM DARK"
	elseif title == "IMANOGUILTS" 	 												then return "(A) BOOM DARK"
	elseif title == "In The Breeze" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "JOMANDA" 	 													then return "(X) CRYSTALDIUM"
	elseif title == "KHAMEN BREAK" 	 												then return "(X2) CYBER"
	elseif title == "M.A.Y.U." 														then return "(X2) CYBER"
	elseif title == "MAX.(period)" 													then return "(REPLICANT) DARK BLUE"
	elseif title == "neko＊neko" 														then return "(X) LOVE SWEETS"
	elseif title == "Nostalgia Is Lost" 	 											then return "(X) CRYSTALDIUM"
	elseif title == "One Sided Love" 	 											then return "(X2) BOOM LIGHT"
	elseif title == "Over The “Period”" 												then return "(REPLICANT) RED"
	elseif title == "Party Lights (Tommie Sunshine's Brooklyn Fire Remix)" 	 		then return "(X) DANCING RAYS"
	elseif title == "Plan 8" 														then return "(A) BOOM DARK"
	elseif title == "POSSESSION(EDP Live Mix)" 										then return "(X2) MOVIE LIGHT"
	elseif title == "PRANA+REVOLUTIONARY ADDICT (U1 DJ Mix)" 						then return "(X) LOVE SWEETS"
	elseif title == "PUNISHER" 	 													then return "(X2) CYBER"
	elseif title == "Remain" 														then return "(A) BOOM DARK"
	elseif title == "Romancing Layer" 	 											then return "(X2) CYBER"
	elseif title == "SABER WING (satellite silhouette remix)" 						then return "(X) CRYSTALDIUM"
	elseif title == "Sakura Mirage" 													then return "(X) CRYSTALDIUM"
	elseif title == "Samurai Shogun vs. Master Ninja" 								then return "(A) BOOM RED"
	elseif title == "Sand Blow" 														then return "(A) BOOM YELLOW"
	elseif title == "Scarlet Moon" 													then return "(X) DANCING RAYS"
	elseif title == "second spring storm" 											then return "(X) DANCING RAYS"
	elseif title == "SPECIAL SUMMER CAMPAIGN!" 										then return "(X2) BOOM LIGHT"
	elseif title == "Squeeze" 														then return "(X2) CYBER"
	elseif title == "Starlight Fantasia" 											then return "(X) CRYSTALDIUM"
	elseif title == "Starlight Fantasia (Endorphins Mix)" 							then return "(X) LOVE SWEETS"
	elseif title == "starmine" 														then return "(X2) BIG SCREEN"
	elseif title == "Stella Sinistra" 												then return "(X) CRYSTALDIUM"
	elseif title == "Strobe♡Girl" 													then return "(X) LOVE SWEETS"
	elseif title == "Struggle" 														then return "(X) CRYSTALDIUM"
	elseif title == "Summer fantasy (Darwin remix)" 									then return "(X) BOOM BOOM BOOM"
	elseif title == "SUPER HERO" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Thank You Merry Christmas" 										then return "(X) DANCING RAYS"
	elseif title == "The Lonely Streets" 											then return "(X) DAWN STREETS"
	elseif title == "Truare!" 														then return "(A) BOOM DARK"
	elseif title == "True Blue" 														then return "(X) CRYSTALDIUM"
	elseif title == "TSUBASA" 														then return "(X) CRYSTALDIUM"
	elseif title == "VEGA" 															then return "(X) CRYSTALDIUM"
	elseif title == "8000000" 														then return "(X) DANCING RAYS"
	elseif title == "IX" 	 														then return "(A) BOOM DARK"
----------------------------------------------------------------------------- U.M.U × BEMANI
	elseif title == "僕は君に恋をした" 	 												then return "(X2) BIG SCREEN"				--Boku wa kimi ni koi wo shita
	elseif title == "Che Che Chelip～魔法のコトバ～" 	 									then return "(X2) BIG SCREEN"				--Che Che Chelip ~mahou no kotoba~
	elseif title == "ドリームキャッチャー" 	 												then return "(X2) BIG SCREEN"				--DREAM CATCHER
	elseif title == "HAPPY☆きたかた" 	 												then return "(X2) BIG SCREEN"				--HAPPY kitakata
	elseif title == "川崎純情音頭" 	 													then return "(X2) BIG SCREEN"				--Kawasaki junjo ondo
	elseif title == "キライじゃないのぉ" 	 												then return "(X2) BIG SCREEN"				--Kiraijanaino
	elseif title == "ルシャナの気持ち" 	 												then return "(X2) BIG SCREEN"				--Le Siana no kimochi
	elseif title == "ラブラブキュートなハピハピサンデー" 	 										then return "(X2) BIG SCREEN"				--Love love cute na happy happy sunday
	elseif title == "マーメイド" 	 													then return "(X2) BIG SCREEN"				--Mermaid
	elseif title == "MITOれて！いばらきっしゅだ～りん" 	 										then return "(X2) BIG SCREEN"				--MITOrete! Ibarakisshuda~rin
	elseif title == "乙女の真骨頂" 	 													then return "(X2) BIG SCREEN"				--Otome no shinkocchou
	elseif title == "らいらら" 	 														then return "(X2) BIG SCREEN"				--Rairara
	elseif title == "瞬間 I LOVE YOU" 	 											then return "(X2) BIG SCREEN"				--Shunkan I LOVE YOU
	elseif title == "ザッツ！KAIYODO" 	 												then return "(X2) BIG SCREEN"				--That's! KAIYODO
	elseif title == "We are チャリンコエンジェルス" 	 										then return "(X2) BIG SCREEN"				--We are Charinko Angels
	elseif title == "A to Z" 	 													then return "(X2) BIG SCREEN"
	elseif title == "Boom! Boom! Miracle Emotion" 	 								then return "(X2) BIG SCREEN"
	elseif title == "CAPTIVE" 	 													then return "(X2) BIG SCREEN"
	elseif title == "Dong! Dong!" 	 												then return "(X2) BIG SCREEN"
	elseif title == "Everybody Say EDOGAWA" 	 										then return "(X2) BIG SCREEN"
	elseif title == "Field on!" 	 													then return "(X2) BIG SCREEN"
	elseif title == "HeartLatte" 	 												then return "(X2) BIG SCREEN"
	elseif title == "LoveLove DokiDoki" 	 											then return "(X2) BIG SCREEN"
	elseif title == "LUCKY-YO!!" 	 												then return "(X2) BIG SCREEN"
	elseif title == "my cosmic world" 	 											then return "(X2) BIG SCREEN"
	elseif title == "MY HERO" 	 													then return "(X2) BIG SCREEN"
----------------------------------------------------------------------------- DDR A
	elseif title == "愛言葉" 															then return "(X) LOVE SWEETS"				--Ai kotoba
	elseif title == "天ノ弱" 															then return "(X2) BOOM LIGHT"				--Ama no jyaku
	elseif title == "ありふれたせかいせいふく" 												then return "(X) BOOM BOOM BOOM"			--Arifureta sekai seifuku
	elseif title == "いーあるふぁんくらぶ" 													then return "(X) DANCING RAYS"				--Yi-er fanclub
	elseif title == "イーディーエム・ジャンパーズ" 												then return "(X2) BOOM LIGHT"				--EDM jumpers
	elseif title == "色は匂へど散りぬるを" 													then return "(X) BOOM BOOM BOOM"			--Iro wa nio e do chirinuru wo
	elseif title == "エイリアンエイリアン" 													then return "(X) DANCING RAYS"				--Alien Alien
	elseif title == "エキサイティング!!も・ちゃ・ちゃ☆" 											then return "(X) LOVE SWEETS" 				--Exciting!! Mo-cha-cha
	elseif title == "おねがいダーリン" 														then return "(X) LOVE SWEETS" 				--Onegai darling
	elseif title == "朧" 																then return "(X2) BOOM LIGHT"  				--Oboro
	elseif title == "朧 (dj TAKA Remix)" 												then return "(X) CRYSTALDIUM" 				--Oboro (dj TAKA Remix)
	elseif title == "きゅん×きゅんばっきゅん☆LOVE" 											then return "(X) BOOM BOOM BOOM" 			--Kyun kyun bakkyun LOVE
	elseif title == "倉野川音頭" 														then return "(X2) BOOM LIGHT"				--Kuranogawa ondo
	elseif title == "黒髪乱れし修羅となりて～凛 edition～" 									then return "(X) CRYSTALDIUM" 				--Kurokami midareshi shura to narite ~Rin edition~
	elseif title == "君氏危うくも近うよれ" 													then return "(X) BOOM BOOM BOOM" 			--Kunshi ayauku mo chikou yore
	elseif title == "恋時雨" 															then return "(X) BOOM BOOM BOOM" 			--Koishigure
	elseif title == "恋する☆宇宙戦争っ!!" 												then return "(X2) BOOM LIGHT" 				--Koisuru uchuu sensou!!
	elseif title == "恋のパズルマジック" 													then return "(X) CRYSTALDIUM" 				--Koi no puzzle magic
	elseif title == "この青空の下で" 														then return "(X) CRYSTALDIUM" 				--Kono aozora no shita de
	elseif title == "さよならトリップ ～夏陽 EDM edition～" 									then return "(X) CRYSTALDIUM" 				--Sayonara trip ~Natsuhi EDM edition~
	elseif title == "幸せになれる隠しコマンドがあるらしい" 										then return "(X) BOOM BOOM BOOM"			--Shiawase ni nareru kakushi command ga arurashii
	elseif title == "しゃかりきリレーション" 													then return "(X) LOVE SWEETS" 				--Shakariki relation
	elseif title == "十二星座の聖域" 													then return "(X) CRYSTALDIUM" 				--Juuniseiza no seiiki
	elseif title == "シュレーディンガーの猫" 													then return "(X) LOVE SWEETS" 				--Schrodinger no neko
	elseif title == "春風ブローインウィンド" 													then return "(X2) BOOM LIGHT" 				--Shunpuu blowing wind
	elseif title == "すろぉもぉしょん" 														then return "(X) CRYSTALDIUM" 				--SLoWMoTIoN
	elseif title == "星座が恋した瞬間を。" 													then return "(X) CRYSTALDIUM" 				--Seiza ga koishita shunkan wo
	elseif title == "千年ノ理" 															then return "(X) BOOM BOOM BOOM" 			--Sennen no kotowari
	elseif title == "宇宙(ソラ)への片道切符" 												then return "(X) BOOM BOOM BOOM" 			--Sora e no katamichi kippu
	elseif title == "闘え！ダダンダーンV" 													then return "(X) DANCING RAYS" 				--Tatakae! Dadandarn V
	elseif title == "打打打打打打打打打打" 												then return "(X) DANCING RAYS" 				--Dadadadadadadadadada
	elseif title == "チルノのパーフェクトさんすう教室" 											then return "(X) CRYSTALDIUM" 				--Cirno's Perfect Math Class
	elseif title == "チルノのパーフェクトさんすう教室 (EDM REMIX)" 								then return "(X) CRYSTALDIUM" 				--Cirno's Perfect Math Class (EDM REMIX)
	elseif title == "ナイト・オブ・ナイツ" 													then return "(A) BOOM DARK" 				--Night of knights
	elseif title == "脳漿炸裂ガール" 													then return "(X2) CYBER" 					--Nou shou sakuretsu girl
	elseif title == "初音ミクの消失" 														then return "(X2) BOOM LIGHT" 				--Hatsune Miku no shoushitsu
	elseif title == "ハッピーシンセサイザ" 													then return "(X) DANCING RAYS" 				--Happy synthesizer
	elseif title == "ハピ恋☆らぶりぃタイム!!" 												then return "(X) LOVE SWEETS" 				--Happy koi lovely time!!
	elseif title == "ハルイチバン" 														then return "(X2) BOOM LIGHT" 				--Haru ichiban
	elseif title == "*ハロー、プラネット。" 													then return "(X2) CLUB"						--Hello, planet
	elseif title == "向日葵サンセット" 													then return "(X2) BOOM LIGHT" 				--Himawari sunset
	elseif title == "風鈴花火" 														then return "(X) DANCING RAYS" 				--Fuurin hanabi
	elseif title == "無頼ック自己ライザー" 													then return "(X2) CLUB"						--Buraikku jikorizer
	elseif title == "プレインエイジア -PHQ remix-" 											then return "(X) BOOM BOOM BOOM" 			--Plain Asia -PHQ remix-
	elseif title == "ベィスドロップ・フリークス" 												then return "(X) LOVE SWEETS" 				--Bassdrop freaks
	elseif title == "放課後ストライド"														then return "(X2) BOOM LIGHT" 				--Houkago stride
	elseif title == "魔法のたまご ～心菜 ELECTRO POP edition～" 							then return "(X) CRYSTALDIUM" 				--Mahou no tamago ~Cocona ELECTRO POP edition~
	elseif title == "魔理沙は大変なものを盗んでいきました" 										then return "(X) LOVE SWEETS" 				--Marisa wa taihen na mono wo nusunde ikimashita
	elseif title == "妄想税" 															then return "(X2) CYBER" 					--Mousou zei
	elseif title == "ようこそジャパリパークへ" 												then return "(X2) BOOM LIGHT" 				--Youkoso Japari Park e
	elseif title == "輪廻転生" 														then return "(A) BOOM DARK" 				--Rinnetensei
	elseif title == "ルミナスデイズ" 														then return "(X) DANCING RAYS" 				--Luminous days
	elseif title == "恋愛観測" 														then return "(X) LOVE SWEETS" 				--Renai kansoku
	elseif title == "ロールプレイングゲーム" 													then return "(X2) CYBER" 					--Role-playing game
	elseif title == "六兆年と一夜物語" 													then return "(X2) CYBER" 					--Rokuchounen to ichiya monogatari
	elseif title == "炉心融解" 														then return "(X) CRYSTALDIUM" 				--Roshin yuukai
	elseif title == "ロストワンの号哭" 													then return "(X) BOOM BOOM BOOM" 			--Lost one no goukoku
	elseif title == "ロンロンへ ライライライ!" 												then return "(X2) BOOM LIGHT" 				--Ronron e rairairai!
	elseif title == "ACE FOR ACES" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "ALGORITHM" 														then return "(X2) CYBER"
	elseif title == "ALL MY HEART -この恋に、わたしの全てを賭ける-" 							then return "(X2) BOOM LIGHT"
	elseif title == "Angelic Jelly" 													then return "(X) LOVE SWEETS"
	elseif title == "ANNIVERSARY ∴∵∴ ←↓↑→" 											then return "(X2) CYBER"
	elseif title == "Astrogazer" 													then return "(A) BOOM WHITE"
	elseif title == "Bad Apple!! feat. nomico" 										then return "(X2) CYBER"
	elseif title == "bass 2 bass" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Be a Hero!" 													then return "(X2) BOOM LIGHT"
	elseif title == "Believe" 														then return "(X2) CLUB"
	elseif title == "Boss Rush" 														then return "(A) BOOM DARK"
	elseif title == "Break Free" 													then return "(X) DANCING RAYS"
	elseif title == "Catch Our Fire!" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "CHAOS Terror-Tech Mix" 											then return "(A) BOOM YELLOW"
	elseif title == "CHOCOLATE PHILOSOPHY" 											then return "(X) LOVE SWEETS"
	elseif title == "Chronos (walk with you remix)" 									then return "(X) CRYSTALDIUM"
	elseif title == "Come to Life" 													then return "(A) BOOM RED"
	elseif title == "Cosy Catastrophe" 												then return "(A) BOOM WHITE"
	elseif title == "Cytokinesis" 													then return "(A) BOOM DARK"
	elseif title == "DANCE ALL NIGHT (DDR EDITION)" 									then return "(X2) CYBER"
	elseif title == "Dancer in the flare" 											then return "(X) DANCING RAYS"
	elseif title == "DDR MEGAMIX" 													then return "(X) DANCING RAYS"
	elseif title == "Determination" 													then return "(X) DAWN STREETS"
	elseif title == "DREAMING-ING!!" 												then return "(X) DANCING RAYS"
	elseif title == "Electric Dance System Music" 									then return "(X2) CYBER"
	elseif title == "Emera" 															then return "(A) BOOM GREEN"
	elseif title == "ENDYMION" 														then return "(REPLICANT) RED"
	elseif title == "Eternal Summer" 												then return "(X2) BOOM LIGHT"
	elseif title == "Far east nightbird" 											then return "(X2) CYBER"
	elseif title == "Far east nightbird kors k Remix -DDR edit ver-" 				then return "(A) BOOM DARK"
	elseif title == "First Time" 													then return "(A) BOOM DARK"
	elseif title == "Fly far bounce" 												then return "(X2) CYBER"
	elseif title == "Grand Chariot" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Grip & Break down !!" 											then return "(X) DANCING RAYS"
	elseif title == "HANDS UP IN THE AIR" 											then return "(X) CRYSTALDIUM"
	elseif title == "Happy" 															then return "(X) DAWN STREETS"
	elseif title == "Ha・lle・lu・jah" 													then return "(X2) CYBER"
	elseif title == "Help me, ERINNNNNN!!" 											then return "(X) BOOM BOOM BOOM"
	elseif title == "High School Love" 												then return "(X2) BOOM LIGHT"
	elseif title == "Hillbilly Shoes" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "Hopeful" 														then return "(X2) CYBER"
	elseif title == "I Want You To Know" 											then return "(X) CRYSTALDIUM"
	elseif title == "Illegal Function Call" 											then return "(A) BOOM DARK"
	elseif title == "IN BETWEEN" 													then return "(A) BOOM YELLOW"
	elseif title == "invisible rain" 												then return "(X) DAWN STREETS"
	elseif title == "Ishtar" 														then return "(A) BOOM RED"
	elseif title == "Jewelry days" 													then return "(X2) BOOM LIGHT"
	elseif title == "Lesson by DJ" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Life is beautiful" 												then return "(X) BOOM BOOM BOOM"
	elseif title == "Love You More" 													then return "(A) BOOM RED"
	elseif title == "Love♡Shine わんだふるmix" 											then return "(X) LOVE SWEETS"
	elseif title == "MAX 360" 														then return "(A) BOOM RED"
	elseif title == "More One Night" 												then return "(X) CRYSTALDIUM"
	elseif title == "Neutrino" 														then return "(A) BOOM BLUE"
	elseif title == "New Century" 													then return "(A) BOOM GREEN"
	elseif title == "#OurMemories" 													then return "(X2) BOOM LIGHT"
	elseif title == "out of focus" 													then return "(A) BOOM GREEN"
	elseif title == "Poochie" 														then return "(X2) CYBER"
	elseif title == "POSSESSION (20th Anniversary Mix)" 								then return "(A) BOOM BLUE"
	elseif title == "Prey" 															then return "(X2) CYBER"
	elseif title == "Puberty Dysthymia" 												then return "(A) BOOM DARK"
	elseif title == "Pursuer" 														then return "(A) BOOM RED"
	elseif title == "Reach The Sky, Without you" 									then return "(A) BOOM DARK"
	elseif title == "Rejoin" 														then return "(X2) BOOM LIGHT"
	elseif title == "RISING FIRE HAWK" 												then return "(A) BOOM RED"
	elseif title == "S!ck" 															then return "(X2) CYBER"
	elseif title == "Sakura Reflection" 												then return "(X2) CYBER"
	elseif title == "Sephirot" 														then return "(X2) CYBER"
	elseif title == "SHION" 															then return "(X) CRYSTALDIUM"
	elseif title == "Show me your moves" 											then return "(X) DANCING RAYS"
	elseif title == "Shut Up and Dance" 												then return "(X2) BOOM LIGHT"
	elseif title == "siberite" 														then return "(X) CRYSTALDIUM"
	elseif title == "Smiling Passion" 												then return "(X) LOVE SWEETS"
	elseif title == "Special One" 													then return "(X) DANCING RAYS"
	elseif title == "Star Trail" 													then return "(X2) MOVIE LIGHT"
	elseif title == "Start a New Day" 												then return "(A) BOOM WHITE"
	elseif title == "STERLING SILVER" 												then return "(X) CRYSTALDIUM"
	elseif title == "STERLING SILVER (U1 overground mix)" 							then return "(X) CRYSTALDIUM"
	elseif title == "Strawberry Chu♡Chu♡" 											then return "(X) LOVE SWEETS"
	elseif title == "StrayedCatz" 													then return "(X) DANCING RAYS"
	elseif title == "SUN² SUMMER STEP!" 												then return "(X2) BOOM LIGHT"
	elseif title == "SUPER SUMMER SALE" 												then return "(X) DAWN STREETS"
	elseif title == "TECH-NOID" 														then return "(X2) CYBER"
	elseif title == "The Night Away (MK Remix)" 										then return "(X) CRYSTALDIUM"
	elseif title == "Time Of Our Lives" 												then return "(X) DAWN STREETS"
	elseif title == "Towards the TOWER" 												then return "(X) CRYSTALDIUM"
	elseif title == "Triple Counter" 												then return "(X2) BOOM LIGHT"
	elseif title == "Twin memories W" 												then return "(X2) BOOM LIGHT"
	elseif title == "Vanquish The Ghost" 											then return "(A) BOOM WHITE"
	elseif title == "Wake Me Up" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Yeah! Yeah!" 													then return "(X) DANCING RAYS"
	elseif title == "ZEPHYRANTHES" 													then return "(X) CRYSTALDIUM"
	elseif title == "39" 															then return "(X2) BOOM LIGHT"
----------------------------------------------------------------------------- DDR A20 ---------------------------------------------------------------------------------
	elseif title == "おーまい！らぶりー！すうぃーてぃ！だーりん！" 									then return "(X) LOVE SWEETS"				--Oh my! lovely! sweety! darling!
	elseif title == "革命パッショネイト" 													then return "(X) BOOM BOOM BOOM"			--Kakumei passionate
	elseif title == "腐れ外道とチョコレゐト" 												then return "(X) CRYSTALDIUM"				--Kusare gedou to chocolate
	elseif title == "最終鬼畜妹フランドール・S" 												then return "(A) BOOM RED"				--Saishuu kichiku imouto Flandre-S
	elseif title == "最小三倍完全数" 													then return "(X2) CYBER"					--Saishou sanbai kanzensuu
	elseif title == "スイーツはとまらない♪" 													then return "(X) LOVE SWEETS"				--Sweets wa tomaranai
	elseif title == "すきなことだけでいいです" 												then return "(X) BOOM BOOM BOOM"			--Sukina koto dakede ii desu
	elseif title == "タイガーランペイジ" 													then return "(X) BOOM BOOM BOOM"			--Tiger rampage
	elseif title == "どきドキ バレンタイン" 													then return "(X) LOVE SWEETS"				--Dokidoki Valentine
	elseif title == "毒占欲" 															then return "(X) BOOM BOOM BOOM"			--Dokusenyoku
	elseif title == "ナイト・オブ・ナイツ (Ryu☆Remix)" 										then return "(A) BOOM BLUE"				--Night of Knights (Ryu Remix)
	elseif title == "熱情のサパデアード" 													then return "(X2) CLUB"						--Netsujou no zapadeado
	elseif title == "び" 																then return "(X) LOVE SWEETS"				--Bi
	elseif title == "ヒカリユリイカ" 														then return "(X2) BOOM LIGHT"				--Hikari eureka
	elseif title == "ベビーステップ" 														then return "(X2) BOOM LIGHT"				--Baby step
	elseif title == "ホーンテッド★メイドランチ" 												then return "(A) BOOM DARK"				--Haunted maid lunch
	elseif title == "星屑の夜果て" 														then return "(X) CRYSTALDIUM"				--Hoshikuzu no yoru hate
	elseif title == "未完成ノ蒸氣驅動乙女 (DDR Edition)" 									then return "(A) BOOM YELLOW"			--Mikansei no jouki kudou otome (DDR Edition)
	elseif title == "ミッドナイト☆WAR" 													then return "(X) LOVE SWEETS"				--Midnight WAR
	elseif title == "未来（ダ）FUTURE" 													then return "(X) DANCING RAYS"				--Mirai (da) FUTURE	
	elseif title == "妄想感傷代償連盟" 													then return "(X) DANCING RAYS"				--Mousou kanshou daishou renmei
	elseif title == "ライアーダンス" 														then return "(X) DANCING RAYS"				--Liar dance
	elseif title == "ラブキラ☆スプラッシュ" 													then return "(X) LOVE SWEETS"				--Love kira splash
	elseif title == "ランカーキラーガール" 													then return "(A) BOOM YELLOW"			--Ranker killer girl
	elseif title == "令和" 															then return "(X2) BOOM LIGHT"				--Reiwa
	elseif title == "Ace out" 														then return "(A) BOOM YELLOW"
	elseif title == "Afterimage d'automne" 											then return "(X2) BOOM LIGHT"
	elseif title == "Alone" 															then return "(X2) CYBER"
	elseif title == "ALPACORE" 														then return "(A) BOOM BLUE"
	elseif title == "Avenger" 														then return "(A) BOOM BLUE"
	elseif title == "BLACK JACKAL" 													then return "(X2) CLUB"
	elseif title == "BLSTR" 															then return "(X2) CYBER"
	elseif title == "Bounce Trippy" 													then return "(X2) CYBER"
	elseif title == "BUTTERFLY (20th Anniversary Mix)" 								then return "(X2) BOOM LIGHT"
	elseif title == "CARTOON HEROES (20th Anniversary Mix)" 							then return "(X2) BOOM LIGHT"
	elseif title == "Clarity" 														then return "(X2) CYBER"
	elseif title == "Crazy Shuffle" 													then return "(X) DAWN STREETS"
	elseif title == "CROSS" 															then return "(X) BOOM BOOM BOOM"
	elseif title == "CyberConnect" 													then return "(X2) CYBER"
	elseif title == "Dead Heat" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "DIGITAL LUV" 													then return "(X2) CLUB"
	elseif title == "District of the Shadows" 										then return "(X2) CYBER"
	elseif title == "DOWNER & UPPER" 												then return "(X) DANCING RAYS"
	elseif title == "Drop The Bounce" 												then return "(A) BOOM DARK"
	elseif title == "ENDLESS" 														then return "(X) DANCING RAYS"
	elseif title == "F4SH10N" 														then return "(X) DANCING RAYS"
	elseif title == "Firestorm" 														then return "(A) BOOM YELLOW"
	elseif title == "Get On Da Floor" 												then return "(X) DANCING RAYS"
	elseif title == "Give Me" 														then return "(X) LOVE SWEETS"
	elseif title == "Glitch Angel" 													then return "(A) BOOM WHITE"
	elseif title == "Golden Arrow" 													then return "(X) DANCING RAYS"
	elseif title == "HAVE YOU NEVER BEEN MELLOW (20th Anniversary Mix)" 				then return "(X2) BOOM LIGHT"
	elseif title == "Helios" 														then return "(X) CRYSTALDIUM"
	elseif title == "Hunny Bunny" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "I Love You" 													then return "(X2) BOOM LIGHT"
	elseif title == "I’m an Albatraoz" 												then return "(X) DANCING RAYS"
	elseif title == "IRON HEART" 													then return "(X2) CYBER"
	elseif title == "Lachryma《Re:Queen’M》" 											then return "(A) BOOM WHITE"
	elseif title == "LEVEL UP" 														then return "(X) CRYSTALDIUM"
	elseif title == "LONG TRAIN RUNNIN' (20th Anniversary Mix)" 						then return "(X) DAWN STREETS"
	elseif title == "Mythomane" 														then return "(X) CRYSTALDIUM"
	elseif title == "Neverland" 														then return "(X2) BOOM LIGHT"
	elseif title == "New Era" 														then return "(A) BOOM YELLOW"
	elseif title == "New Rules" 														then return "(X) DANCING RAYS"
	elseif title == "No Tears Left to Cry" 											then return "(X) CRYSTALDIUM"
	elseif title == "ORCA" 															then return "(A) BOOM RED"
	elseif title == "Our Soul" 														then return "(X2) CYBER"
	elseif title == "ΩVERSOUL" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "Party Rock Anthem" 												then return "(X) DAWN STREETS"
	elseif title == "Play Hard" 														then return "(X2) CLUB"
	elseif title == "Procyon" 														then return "(X) CRYSTALDIUM"
	elseif title == "Rampage Hero" 													then return "(A) BOOM RED"
	elseif title == "Re:GENERATION" 													then return "(X) CRYSTALDIUM"
	elseif title == "Right Time Right Way" 											then return "(X2) BOOM LIGHT"
	elseif title == "Seta Para Cima↑↑" 												then return "(X2) CLUB"
	elseif title == "Silly Love" 													then return "(X) DANCING RAYS"
	elseif title == "Six String Proof" 												then return "(X) CRYSTALDIUM"
	elseif title == "SKY HIGH (20th Anniversary Mix)" 								then return "(X2) BOOM LIGHT"
	elseif title == "Skywalking" 													then return "(X2) CYBER"
	elseif title == "Small Steps" 													then return "(X2) CLUB"
	elseif title == "SODA GALAXY" 													then return "(X) BOOM BOOM BOOM"
	elseif title == "Something Just Like This (Alesso Remix) " 						then return "(X2) CLUB"
	elseif title == "Splash Gold" 													then return "(A) BOOM DARK"
	elseif title == "Starlight in the Snow" 											then return "(X2) CLUB"
	elseif title == "Starry Sky" 													then return "(X) DANCING RAYS"
	elseif title == "Stay 4 Ever" 													then return "(X) DANCING RAYS"
	elseif title == "SWEET HOME PARTY" 												then return "(A) BOOM RED"
	elseif title == "The History of the Future" 										then return "(A) BOOM BLUE"
	elseif title == "The Light" 														then return "(X2) CYBER"
	elseif title == "The World Ends Now" 											then return "(A) BOOM WHITE"
	elseif title == "This Beat Is....." 												then return "(X) DAWN STREETS"
	elseif title == "Toy Box Factory" 												then return "(X) LOVE SWEETS"
	elseif title == "toy boxer" 														then return "(X) BOOM BOOM BOOM"
	elseif title == "Trill auf G" 													then return "(X) DAWN STREETS"
	elseif title == "Une mage blanche" 												then return "(X) LOVE SWEETS"
	elseif title == "voltississimo" 													then return "(X) DANCING RAYS"
	elseif title == "Waiting" 														then return "(X) CRYSTALDIUM"
	elseif title == "50th Memorial Songs -Beginning Story-" 							then return "(A) BOOM RED"
	elseif title == "50th Memorial Songs -Flagship medley-" 							then return "(X) DAWN STREETS"
	elseif title == "50th Memorial Songs -二人の時 ～under the cherry blossoms～-" 		then return "(X) LOVE SWEETS"	
	elseif title == "50th Memorial Songs -The BEMANI History-" 						then return "(X2) CYBER"
----------------------------------------------------------------------------- DDR A20 PLUS ---------------------------------------------------------------------------
	elseif title == "蒼が消えるとき"														then return "(X) BOOM BOOM BOOM"			--Ao ga kieru toki
	elseif title == "アリスサイド・キャスリング"													then return "(X) CRYSTALDIUM"				--Alice side castling
	elseif title == "鋳鉄の檻"															then return "(X) BOOM BOOM BOOM"			--Itetsu no pride
	elseif title == "イノセントバイブル"														then return "(X) BOOM BOOM BOOM"			--Innocent bible
	elseif title == "ウソツキ横丁は雨模様"													then return "(X) BOOM BOOM BOOM"			--Usotsuki yokochou wa amemoyou
	elseif title == "梅雪夜"															then return "(X) CRYSTALDIUM"				--Umeyukiyo
	elseif title == "御伽噺に幕切れを"													then return "(X) BOOM BOOM BOOM"			--Otogibanashi ni makugire wo
	elseif title == "彼方のリフレシア"														then return "(X2) BOOM LIGHT"				--Kanata no Reflesia
	elseif title == "狂水一華"															then return "(X) DANCING RAYS"				--Kyousui ichika
	elseif title == "恋"																then return "(X) DANCING RAYS"				--Koi
	elseif title == "ここからよろしく大作戦143"												then return "(X) BOOM BOOM BOOM"			--Koko kara yoroshiku daisakusen 143
	elseif title == "逆さま♥シンデレラパレード"												then return "(X) LOVE SWEETS"				--Sakasama Cinderella parade
	elseif title == "雑草魂なめんなよ！"													then return "(X2) BOOM LIGHT"				--Zassou tamashii namen na yo!
	elseif title == "至上のラトゥーリア"													then return "(X) BOOM BOOM BOOM"			--Shijou no laturia
	elseif title == "思想犯"															then return "(X) BOOM BOOM BOOM"			--Shisouhan
	elseif title == "灼熱 Pt.2 Long Train Running"									then return "(X) DANCING RAYS"				--Shakunetsu Pt 2 Long Train Running
	elseif title == "シル・ヴ・プレジデント"													then return "(X) LOVE SWEETS"				--S'il vous president
	elseif title == "スーパー戦湯ババンバーン"												then return "(X2) BOOM LIGHT"				--Super sentou Babanburn
	elseif title == "スカイクラッドの観測者"													then return "(A) BOOM WHITE"				--Skyclad no kansokusha
	elseif title == "世界の果てに約束の凱歌を -DDR Extended Megamix-"						then return "(A) BOOM YELLOW"			--Sekai no hate ni yakusoku no gaika wo -DDR Extended Megamix-
	elseif title == "追憶のアリア"														then return "(X2) BOOM LIGHT"				--Tsuioku no aria
	elseif title == "東京神話"															then return "(X) BOOM BOOM BOOM"			--Tokyo shinwa
	elseif title == "なだめスかし Negotiation"											then return "(X) LOVE SWEETS"				--Nadame sukashi Negotiation
	elseif title == "ノルエピネフリン"														then return "(X) BOOM BOOM BOOM"			--Norepinephrine
	elseif title == "花は折りたし梢は高し"													then return "(X) BOOM BOOM BOOM"			--Hana wa oritashi kozue wa takashi
	elseif title == "ハラショー！おにぎりサーカス団☆"											then return "(X) LOVE SWEETS"				--Khorosho! Onigiri circus dan
	elseif title == "春を告げる"														then return "(X) BOOM BOOM BOOM"			--Haru wo tsugeru
	elseif title == "叛逆のディスパレート"													then return "(X) BOOM BOOM BOOM"			--Hangyaku no disparate
	elseif title == "勇猛無比"															then return "(X) BOOM BOOM BOOM"			--YU-MOU-MU-HI
	elseif title == "ユメブキ"															then return "(X2) CYBER"					--Yumebuki
	elseif title == "ロキ(w/緒方恵美)"													then return "(X) BOOM BOOM BOOM"			--Roki (Megumi Ogata)
	elseif title == "ほしのつくりかた"													then return "(X) CRYSTALDIUM"			--Hoshi no tsukurikata
	elseif title == "モノクロモーメント"													then return "(X) CRYSTALDIUM"			--Monochrome moment
	elseif title == "ノープラン・デイズ"													then return "(X) CRYSTALDIUM"			--No plan days
	elseif title == "サイカ"															then return "(X) BOOM BOOM BOOM"			--Saika
	elseif title == "テレキャスタービーボーイ"												then return "(X) LOVE SWEETS"			--Telecaster B-boy
	elseif title == "actualization of self (weaponized)"								then return "(X2) BOOM LIGHT"
	elseif title == "AI"																then return "(X2) CYBER"
	elseif title == "Aftermath"														then return "(A) BOOM BLUE"
	elseif title == "ANTI ANTHEM"													then return "(A) BOOM YELLOW"
	elseif title == "Bang Pad(Werk Mix)"												then return "(X2) CYBER"
	elseif title == "Better Than Me"													then return "(X2) CYBER"
	elseif title == "BITTER CHOCOLATE STRIKER"										then return "(X2) CYBER"
	elseif title == "BLAKE"															then return "(X) BOOM BOOM BOOM"
	elseif title == "BRIDAL FESTIVAL !!!"											then return "(X) LOVE SWEETS"
	elseif title == "City Never Sleeps"												then return "(X) CRYSTALDIUM"
	elseif title == "Come Back To Me" 												then return "(X) CRYSTALDIUM"
	elseif title == "CONNECT-"														then return "(X2) CLUB"
	elseif title == "Crazy Hot"														then return "(X) DANCING RAYS"
	elseif title == "DANCERUSH STARDOM ANTHEM" 										then return "(X) DAWN STREETS"
	elseif title == "DEADLOCK -Out Of Reach-"										then return "(A) BOOM RED"
	elseif title == "DeStRuCtIvE FoRcE" 												then return "(X) CRYSTALDIUM"
	elseif title == "DIGITALIZER"													then return "(A) BOOM RED"
	elseif title == "Draw the Savage" 												then return "(X2) CYBER"
	elseif title == "Evans"															then return "(A) BOOM BLUE"
	elseif title == "Feidie"															then return "(X) DANCING RAYS"
	elseif title == "GHOST KINGDOM"													then return "(X) DAWN STREETS"
	elseif title == "Globe Glitter"													then return "(X) CRYSTALDIUM"
	elseif title == "Going Hypersonic" 												then return "(A) BOOM WHITE"
	elseif title == "Good Looking"													then return "(X2) CLUB"
	elseif title == "GUILTY DIAMONDS"												then return "(X) DANCING RAYS"
	elseif title == "HARD BRAIN"														then return "(X) CRYSTALDIUM"
	elseif title == "Hella Deep"														then return "(X2) CYBER"
	elseif title == "High & Low"														then return "(A) BOOM DARK"
	elseif title == "Hyper Bomb" 													then return "(X2) CYBER"
	elseif title == "HYPERDRIVE" 													then return "(X) CRYSTALDIUM"
	elseif title == "HyperTwist" 													then return "(X) DANCING RAYS"
	elseif title == "I believe what you said"										then return "(X) BOOM BOOM BOOM"
	elseif title == "I Want To Do This Keep"											then return "(X) LOVE SWEETS"
	elseif title == "If"																then return "(X2) CYBER"
	elseif title == "In the past"													then return "(X) BOOM BOOM BOOM"
	elseif title == "Inner Spirit -GIGA HiTECH MIX-"									then return "(X2) CYBER"
	elseif title == "Jetcoaster Windy"												then return "(X) LOVE SWEETS"
	elseif title == "Jucunda Memoria"												then return "(A) BOOM RED"
	elseif title == "Last Card" 														then return "(A) BOOM WHITE"
	elseif title == "Last Twilight"													then return "(X) CRYSTALDIUM"
	elseif title == "LET'S CHECK YOUR LEVEL!"										then return "(X) BOOM BOOM BOOM"
	elseif title == "Lightspeed" 													then return "(A) BOOM YELLOW"
	elseif title == "LIKE A VAMPIRE"													then return "(A) BOOM DARK"
	elseif title == "Midnight Amaretto" 												then return "(X2) CLUB"
	elseif title == "MOVE! (We Keep It Movin')"										then return "(X) DANCING RAYS"
	elseif title == "MUTEKI BUFFALO"													then return "(A) BOOM RED"
	elseif title == "Never See You Again"											then return "(X) CRYSTALDIUM"
	elseif title == "Next Phase"														then return "(A) BOOM BLUE"
	elseif title == "No Life Queen [DJ Command Remix]"								then return "(X) DANCING RAYS"
	elseif title == "ONYX"															then return "(X2) CYBER"
	elseif title == "Our Love"														then return "(X2) CYBER"
	elseif title == "PANIC HOLIC"													then return "(A) BOOM DARK"
	elseif title == "paparazzi"														then return "(X2) CLUB"
	elseif title == "PARTY ALL NIGHT(DJ KEN-BOW MIX)" 								then return "(X) DANCING RAYS"
	elseif title == "Poppin' Soda"													then return "(X) LOVE SWEETS"
	elseif title == "Rave Accelerator" 												then return "(X2) CYBER"
	elseif title == "Realize"														then return "(X) BOOM BOOM BOOM"
	elseif title == "Red Cape Theorem"												then return "(X) CRYSTALDIUM"
	elseif title == "Riot of Color"													then return "(X) BOOM BOOM BOOM"
	elseif title == "ROOM"															then return "(X) CRYSTALDIUM"
	elseif title == "Run The Show" 													then return "(X2) CYBER"
	elseif title == "Seize The Day"													then return "(X2) BOOM LIGHT"
	elseif title == "SHINY DAYS"														then return "(X2) BOOM LIGHT"
	elseif title == "Shout It Out"													then return "(A) BOOM DARK"
	elseif title == "Sparkle Smilin'"												then return "(X2) BOOM LIGHT"
	elseif title == "STEP MACHINE" 													then return "(X2) CYBER"
	elseif title == "Step This Way"													then return "(X2) BOOM LIGHT"
	elseif title == "Sweet Clock"													then return "(X) LOVE SWEETS"
	elseif title == "Sword of Vengeance"												then return "(A) BOOM RED"
	elseif title == "take me higher" 												then return "(X2) BOOM LIGHT"
	elseif title == "Taking It To The Sky (PLUS step)"								then return "(X2) BOOM LIGHT"
	elseif title == "Together Going My Way"											then return "(X) DANCING RAYS"
	elseif title == "Triple Cross" 													then return "(X2) BOOM LIGHT"
	elseif title == "Twinkle Wonderland" 											then return "(X2) BOOM LIGHT"
	elseif title == "TYPHØN" 														then return "(A) BOOM WHITE"
	elseif title == "Uh-Oh"															then return "(X) LOVE SWEETS"
	elseif title == "Vertigo"														then return "(X2) CYBER"
	elseif title == "We're so Happy"													then return "(X) CRYSTALDIUM"
	elseif title == "X-ray binary"													then return "(X) DANCING RAYS"
	elseif title == "Yuni's Nocturnal Days"											then return "(X) DANCING RAYS"
----------------------------------------------------------------------------- DDR GRAND PRIX 
	elseif title == "怪物"															then return "(X) DAWN STREETS"
	elseif title == "紅蓮華"															then return "(X) BOOM BOOM BOOM"
	elseif title == "群青"															then return "(X) CRYSTALDIUM"
	elseif title == "さくらんぼ"														then return "(X) LOVE SWEETS"
	elseif title == "じょいふる"														then return "(X) LOVE SWEETS"
	elseif title == "ドライフラワー"													then return "(X) DAWN STREETS"
	elseif title == "夏祭り"															then return "(X2) BOOM LIGHT"
	elseif title == "夜に駆ける"														then return "(X) BOOM BOOM BOOM"
	elseif title == "ルカルカ★ナイトフィーバー"										then return "(X) DANCING RAYS"
	elseif title == "恋愛レボリューション21"											 then return "(X2) CLUB"	
	elseif title == "勿忘"															then return "(X2) BOOM LIGHT"
----------------------------------------------------------------------------- OTHER SONGS 
	elseif title == "Re:Elemental Creation"											then return "(A) BOOM WHITE"
	elseif title == "Haryu"															then return "(X2) CYBER"
	elseif title == "dEKA"															then return "(X) CRYSTALDIUM"
	elseif title == "U.N. Owen Was Her"												then return "(X) BOOM BOOM BOOM"
	elseif title == "You Goddamn Fish"												then return "(X2) BOOM LIGHT"
	else
		local RDS = math.random(1,8)
		if RDS == 1 then
			return "(X) BOOM BOOM BOOM"
		elseif RDS == 2 then
			return "(X2) BOOM LIGHT"
		elseif RDS == 3 then
			return "(X) CRYSTALDIUM"
		elseif RDS == 4 then
			return "(X2) CYBER"
		elseif RDS == 5 then
			return "(X) DANCING RAYS"
		elseif RDS == 6 then
			return "(X) DAWN STREETS"
		elseif RDS == 7 then
			return "(X) LOVE SWEETS"
		elseif RDS == 8 then
			return "(X) CAPTURE ME"
		end
	end
----------------------------------------------------------------------------- END OF SONG LIST
end