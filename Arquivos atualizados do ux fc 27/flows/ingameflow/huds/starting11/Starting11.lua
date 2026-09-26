
-- New Custom Starting11 By billz12 --

local Starting11 = {}
local TableUtil, FormationModel, OverlaysIdContainer, OverlayParam, eventmanager = ...
local OVERLAY_TYPES = OverlaysIdContainer.Overlays.OVERLAY_TYPE
local EventTypes = eventmanager.FE.FIFA.EventTypes

local leagueIDs = {
  PremierLeague = 13,
  Ligue1 = 16,
  Ligue2 = 17,
  Bundesliga = 19,
  Bundesliga2 = 20,
  SerieA = 31,
  SerieB = 32,
  Laliga = 53,
  LaligaHypermotion = 54,
  BRILiga1 = 2235,
  ChampionshipLiga2 = 2254
}

local TeamColors = {
PremierLeagueTeamsData = {
  { teamid = 1, homeColor = "0x9d1a27", awayColor = "0x001FA3", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF", thirdColor = "0xEFECE4", thirdFontColor = "0x74233C"},
  { teamid = 2, homeColor = "0x5c253f", awayColor ="0x1C1C1C",homeFontColor = "0x80a5ca", awayFontColor = "0xFFFFFF", thirdColor = "0xF4F1EA", thirdFontColor = "0x6C63B5"},
  { teamid = 5, homeColor = "0x084B8A", awayColor ="0xF0F9F1",homeFontColor = "0xFFFFFF", awayFontColor = "0x255527", thirdColor = "0x141414", thirdFontColor = "0x4166E0"},
  { teamid = 7, homeColor = "0x1e406d", awayColor = "0xFFFBEC",homeFontColor = "0xFFFFFF", awayFontColor = "0x1e406d", thirdColor = "0x141414", thirdFontColor = "0xD8B03C"},
  { teamid = 9, homeColor = "0x942528", awayColor = "0xFFFFFF",homeFontColor = "0xFFFFFF", awayFontColor = "0x942528", thirdColor = "0x1C755F", thirdFontColor = "0xFFFFFF"},
  { teamid = 10, homeColor = "0x58D3F7", awayColor = "0x2E2E2E",homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF", thirdColor = "0xB3B9C1", thirdFontColor = "0xB6FF1A"},
  { teamid = 11, homeColor = "0xb7243b", awayColor ="0xF4DCFF",homeFontColor ="0xFFFFFF" , awayFontColor = "0x36004E", thirdColor = "0x151515", thirdFontColor = "0xF0C12B"},
  { teamid = 13, homeColor = "0x000000" , awayColor ="0x29AC50",homeFontColor = "0xFFFFFF", awayFontColor = "0x000000", thirdColor = "0x313D7A", thirdFontColor = "0xF29B3A"},
  { teamid = 18, homeColor = "0xedecea", awayColor ="0x292929",homeFontColor = "0x424242", awayFontColor = "0xFFFFFF", thirdColor = "0xDFDD3E", thirdFontColor = "0x20275C"},
  { teamid = 94, homeColor = "0x004A99", awayColor = "0xE31E34", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" },
  { teamid = 8, homeColor = "0xF8F8F8", awayColor ="0xEAD02C",homeFontColor = "0x4356EE", awayFontColor = "0x4356EE"},  
  { teamid = 14, homeColor = "0xb51e1f", awayColor ="0xFAF8E4",homeFontColor = "0xFFFFFF", awayFontColor = "0xb51e1f", },  
  { teamid = 1952, homeColor = "0xD99400", awayColor = "0x121212", homeFontColor = "0x121212", awayFontColor = "0xF2A900" },
  { teamid = 144, homeColor ="0xe9e8e7" , awayColor ="0x8AB541",homeFontColor = "0xd5cbbb", awayFontColor ="0x2F3963", thirdColor = "0x151515", thirdFontColor = "0xBE9463"},  
  { teamid = 1800, homeColor = "0xA8D8F0", awayColor = "0xD94A3F", homeFontColor = "0xFFFFFF", awayFontColor = "0xFFFFFF" },
  { teamid = 1799, homeColor ="0xd62d25" , awayColor ="0xFFEF18",homeFontColor = "0xE0E0E0", awayFontColor ="0x001E63" , thirdColor = "0xD8BF96", thirdFontColor = "0x2A2A2A"},
  { teamid = 1808, homeColor ="0x205da0" , awayColor ="0xBDAFEF",homeFontColor = "0xE0E0E0", awayFontColor ="0x8B78D9", thirdColor = "0xDFA632", thirdFontColor = "0x1D295F"}, 
  { teamid = 1925, homeColor ="0xb52328" , awayColor ="0xC98DC7",homeFontColor = "0xFFFFFF", awayFontColor ="0x5A3757", thirdColor = "0xAED5F3", thirdFontColor = "0x7B2140"},
  { teamid = 1943, homeColor ="0xae272f" , awayColor ="0x5b669d",homeFontColor = "0xE0E0E0", awayFontColor ="0x202838" ,thirdColor = "0xE8B8C6", thirdFontColor = "0x6D4E80"},
  { teamid = 106, homeColor = "0xE23641", awayColor ="0x3D7BDE",homeFontColor = "0xFFFFFF", awayFontColor = "0xE23641"},
},

Bundesliga1TeamsData = {
  { teamid = 21, homeColor = "0xB80018", awayColor = "0xE0E0E0", homeFontColor = "0xE0E0E0", awayFontColor = "0xB80018", thirdColor = "0x1C1C1C", thirdFontColor = "0xEFE4D8"},
  { teamid = 22, homeColor = "0xF4D13A", awayColor ="0xD6FF57",homeFontColor = "0x1A1A1A", awayFontColor = "0x4A4A4A", thirdColor = "0xF5C633", thirdFontColor = "0x202020"},
  { teamid = 23, homeColor = "0xE0E0E0", awayColor ="0x30B060",homeFontColor = "0x30B060", awayFontColor = "0xE0E0E0", thirdColor = "0x202020", thirdFontColor = "0xD9D9D9"},
  { teamid = 25, homeColor = "0x9c2225", awayColor ="0x3e4041",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0", thirdColor = "0xCF2424", thirdFontColor = "0xF5F5F5"},
  { teamid = 31, homeColor = "0xE0E0E0", awayColor = "0xE01820",homeFontColor = "0xE01820", awayFontColor = "0xE0E0E0" },
  { teamid = 32, homeColor = "0xB81020", awayColor = "0x101010",homeFontColor = "0xE0E0E0", awayFontColor = "0xE0E0E0", thirdColor = "0x1D4ED8", thirdFontColor = "0xB7FFF5"},
  { teamid = 36, homeColor = "0xd3d4d3", awayColor ="0xc62432",homeFontColor ="0xc62432" , awayFontColor = "0xd3d4d3", thirdColor = "0x2A2A2A", thirdFontColor = "0xF2F2F2"},
  { teamid = 38, homeColor = "0x289880", awayColor ="0xE1B5AD",homeFontColor ="0xE0E0E0" , awayFontColor = "0x289880", thirdColor = "0x0F6A52", thirdFontColor = "0xD8B08A"},
  { teamid = 160, homeColor ="0x1d3552" , awayColor ="0x65a7d4",homeFontColor = "0xE0E0E0", awayFontColor ="0x202838" }, 
  { teamid = 169, homeColor = "0xD01818", awayColor = "0xD8D8D8",homeFontColor = "0xD8D8D8", awayFontColor = "0xD01818", thirdColor = "0xF1ECE2", thirdFontColor = "0x4A4A4A"},
  --{ teamid = 175, homeColor = "0x50A830", awayColor ="0x383C3D",homeFontColor = "0xE0E0E0", awayFontColor = "0x50A830"},
  { teamid = 1824, homeColor ="0xD7D7D5" , awayColor ="0x323231",homeFontColor = "0x323231", awayFontColor ="0xD7D7D5", thirdColor = "0x2B2B2B", thirdFontColor = "0xECECEC"},  
  { teamid = 1831, homeColor ="0xbc1e20" , awayColor ="0xd5cbbb",homeFontColor = "0xd5cbbb", awayFontColor ="0xbc1e20", thirdColor = "0x8FD3F5", thirdFontColor = "0xFFFFFF"},  
  { teamid = 10029, homeColor ="0x204390" , awayColor = "0x27B8E3",homeFontColor = "0xcec29a", awayFontColor = "0xF5F5F5", thirdColor = "0xF5F5F5", thirdFontColor = "0x1F2E5A"},  
  { teamid = 100409, homeColor = "0xaa2327", awayColor ="0xd2d1d0",homeFontColor = "0xd2d1d0", awayFontColor = "0xaa2327", thirdColor = "0x1F1F1F", thirdFontColor = "0xC8A96B"}, 
  { teamid = 112172, homeColor = "0xf9f8f8", awayColor ="0xa51b21",homeFontColor = "0xa51b21", awayFontColor = "0xf9f8f8", thirdColor = "0x6B1F1F", thirdFontColor = "0x2B2B2B"},   
  --{ teamid = 111235, homeColor = "0xC7181D", awayColor = "0x2958A0",homeFontColor = "0x2958A0", awayFontColor = "0xC7181D"},
  --{ teamid = 110502, homeColor = "0xD0CFCE", awayColor = "0x313447", homeFontColor = "0x313447", awayFontColor = "0xD0CFCE"},
  { teamid = 34, homeColor = "0x243A78", awayColor = "0xF5F5F5", homeFontColor = "0xEFEFEF", awayFontColor = "0x4A6DE3"},
  { teamid = 580, homeColor = "0xF4F4F4", awayColor = "0x1E1E1E", homeFontColor = "0x3A3A3A", awayFontColor = "0xD9D9D9"},
  { teamid = 10030, homeColor = "0x101010", awayColor = "0xEFEFEF", homeFontColor = "0x1F56B3", awayFontColor = "0x2670D9"},
  { teamid = 28, homeColor = "0xF2F2F2", awayColor = "0x2F4798", homeFontColor = "0x2F4798", awayFontColor = "0xECECEC"},
},
    BRILiga1TeamsData = {
        { teamid = 155600, homeColor = "0x0841B3", awayColor = "0xD7DADE", homeFontColor = "0xffffff", awayFontColor = "0xED0C0E" },
        { teamid = 155601, homeColor = "0x800202", awayColor = "0xfffffff", homeFontColor = "0xffffff", awayFontColor = "0x800202" },
        { teamid = 155602, homeColor = "0x0D41A5", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x0D41A5" },
        { teamid = 155603, homeColor = "0xE72629", awayColor = "0xffffff", homeFontColor = "0xFDD05D", awayFontColor = "0x000000" },
        { teamid = 155604, homeColor = "0x01712C", awayColor = "0xFFFB01", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
        { teamid = 155606, homeColor = "0x8E1502", awayColor = "0x000000", homeFontColor = "0xfffffff", awayFontColor = "0xfffffff" },
        { teamid = 155607, homeColor = "0xB00101", awayColor = "0xffffff", homeFontColor = "0xfffffff", awayFontColor = "0x000000" }, 
        { teamid = 155609, homeColor = "0xC19823", awayColor = "0xffffff", homeFontColor = "0x000000", awayFontColor = "0xC19823" },
        { teamid = 155611, homeColor = "0x000000", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
        { teamid = 155612, homeColor = "0x7F46A6", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
        { teamid = 155614, homeColor = "0xC40505", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
        { teamid = 155616, homeColor = "0xA40101", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0xA40101" },
        { teamid = 155617, homeColor = "0x1F0454", awayColor = "0xffffff", homeFontColor = "0xFFD454", awayFontColor = "0x1F0454" },
        { teamid = 155618, homeColor = "0xCA0303", awayColor = "0xF5D401", homeFontColor = "0xffffff", awayFontColor = "0x000000" },
        { teamid = 155620, homeColor = "0x025E01", awayColor = "0xBEB307", homeFontColor = "0xffffff", awayFontColor = "0x025E01" },
        { teamid = 155621, homeColor = "0xCA0101", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0xCA0101" },
        { teamid = 155624, homeColor = "0x163F90", awayColor = "0xffffff", homeFontColor = "0xffffff", awayFontColor = "0x163F90" },
        { teamid = 155630, homeColor = "0xC60101", awayColor = "0xffffff", homeFontColor = "0xfffffff", awayFontColor = "0xC60101" }
    }
}

function Starting11:getPlayerNameColor(teamID, teamSide)

  local leagueData = TeamColors[self.currentLeague]
  local teamColor = nil

  if leagueData then
    for i = 1, #leagueData do
      if leagueData[i].teamid == teamID then
        teamColor = leagueData[i]
        break
      end
    end
  end

  if teamColor then

    if teamSide == 0 then

      if currentMatch.HomeKitIndex == 0 then
        return teamColor.homeFontColor or DefaultPlayerNameColor

      elseif currentMatch.HomeKitIndex == 1 then
        return teamColor.awayFontColor or teamColor.homeFontColor or DefaultPlayerNameColor

      elseif currentMatch.HomeKitIndex == 3 then
        return teamColor.thirdFontColor or teamColor.awayFontColor or teamColor.homeFontColor or DefaultPlayerNameColor

      else
        return teamColor.homeFontColor or DefaultPlayerNameColor
      end

    else

      if currentMatch.AwayKitIndex == 0 then
        return teamColor.homeFontColor or DefaultPlayerNameColor

      elseif currentMatch.AwayKitIndex == 1 then
        return teamColor.awayFontColor or teamColor.homeFontColor or DefaultPlayerNameColor

      elseif currentMatch.AwayKitIndex == 3 then
        return teamColor.thirdFontColor or teamColor.awayFontColor or teamColor.homeFontColor or DefaultPlayerNameColor

      else
        return teamColor.awayFontColor or teamColor.homeFontColor or DefaultPlayerNameColor
      end

    end

  end

  if self.currentData and self.currentData.bnd_player_name_fontColor then
    return self.currentData.bnd_player_name_fontColor
  end

  return DefaultPlayerNameColor
end

local coachNames = {
    -- denmark superliga
  [269]="Steve Cooper",[270]="Kent Nielsen",[271]="Jakob Poulsen",[272]="Alexander Zorniger",[819]="Bo Svensson",[822]="Claus Nørgaard",[1443]="Nickolai Lund",[1447]="Thomas Nørgaard",[1516]="Mike Tullberg",[1786]="Rasmus Bertelsen",[1788]="Jens Fønsskov Olsen",[15006]="Michael Hansen", 
  -- belgium pro league
  [229]="Jérémy Taravel",[230]="Stef Wils",[231]="Ivan Leko",[232]="Vincent Euvrard",[537]="Yannick Ferrera",[670]="Hans Cornelis",[673]="Nicky Hayen",[674]="Rik De Mil",[680]="Bernd Storck",[681]="Timmy Simons",[1750]="Lars Friis",[2014]="Karel Geraerts",[15005]="Frederik Vanderbiest",[100087]="Marc Brys",[110724]="Steven Defour",[122231]="Jean-Guy Wallemme", 
  -- brazil serie a
  [1629]="Luís Castro",[598]="Thiago Carpini",[1035]="Gabriel Milito",[517]="Artur Jorge",[1048]="Eduardo Coudet",[383]="Abel Ferreira",[567]="Fernando Diniz",[1598]="Renato Paiva",[1041]="Mano Menezes",[1719]="Léo Condé",[569]="Ramón Díaz",[568]="Paulo Autuori",[1043]="Jorge Jesus",[112472]="Pedro Caixinha",[1053]="Fábio Carille",[130361]="Ricardo Catalá",[111044]="Antônio Zago",[1039]="Wesley Carvalho",[115458]="Paulo Baier",[112476]="Gilmar Dal Pozzo", 
  -- netherlands eredivisie
  [634]="Danny Buijs",[1913]="Kees van Wonderen",[245]="John van 't Schip",[1903]="Ron Jans",[247]="Peter Bosz",[1910]="Rogier Meijer",[100632]="René Hake",[1908]="Joseph Oosting",[246]="Arne Slot",[100646]="Jeroen Rijsdijk",[1906]="Pascal Jansen",[1915]="Dick Lukkien",[1914]="Johnny Jansen",[100634]="John Lammers",[1904]="Peter Hyballa",[645]="Wim Jonk",[1971]="Marinus Dijkhuizen",[100638]="Andries Jonker", 
  -- netherlands eerste divisie
  [635]="Jan Vreman",[647]="Henk de Jong",[650]="Robin Peter",[652]="Klaas Wels",[653]="Erwin van de Looi",[655]="Kevin Hofland",[1902]="Jurgen Streppel",[1905]="Joseph Oosting",[1907]="Kevin Hofland",[1909]="Edward Linskens",[100624]="Ulrich Landvreugd",[100626]="Gérard de Nooijer",[100628]="Dick Lukkien",[100640]="Maurice Verberne",[100651]="Hans de Koning",[111380]="Jeroen Rijsdijk",[112681]="John Heitinga",[112683]="Ruud van Nistelrooy",[130095]="Misha Salden",[130096]="Rick Kruys", 
  -- england premier league
  [13]="Eddie Howe",[1925]="Thomas Frank",[14]="Vitor Pereira",[110]="Rob Edwards",[18]="Roberto De Zerbi",[19]="Nuno Espirito Santo",[5]="Liam Rosenior",[2]="Unai Emery",[10]="Pep Guardiola",[144]="Marco Silva",[1]="Mikel Arteta",[11]="Michael Carrick",[1799]="Oliver Glasner",[1943]="Andoni Iraola",[1808]="Roberto De Zerbi",[7]="Sean Dyche",[9]="Arne Slot",[8]="Daniel Farke",[1796]="Vincent Kompany",[106]="Regis Le Bris", 
  -- england championship
  [15]="Marti Cifuentes",[97]="Neil Harris",[1800]="Mark Robins",[1919]=" Liam Manning",[109]="Carlos Corberan",[1960]="Luke Williams",[1952]="Tim Walter",[1807]="Danny Röhl",[1794]="Chris Wilder",[1806]="Alex Neil",[12]="Michael Carrick",[3]="Jon Dahl Tomasson",[1795]="Tom Cleverley",[1792]="Johann van Lommel",[1951]="Des Buckingham",[1790]="John Mousinho",[91]="Paul Warne",[1801]="Ryan Lowe",[88]="Tony Mowbray",[1947]="Phil Parkinson",[17]="Russell Martin",[94]="Kieran McKenna",[95]="Ruud van Nistelrooy",[89]="Nathan Jones", 
  -- france ligue 1
  [65]="Paulo Fonseca",[69]="Adi Hütter",[76]="Patrick Vieira",[219]="Roberto De Zerbi",[73]="Luis Enrique",[66]="Pierre Sage",[64]="Will Still",[74]="Julien Stephan",[1738]="Olivier Dall'Oglio",[72]="Francesco Farioli",[71]="Antoine Kombouaré",[1530]="Alexandre Dujeux",[57]="Christophe Pélissier",[378]="Eric Roy",[1809]="Carles Martinez Novell",[217]="Olivier Dall'Oglio",[111817]="Stéphane Gilli",[68]="László Bölöni", 
  -- france ligue 2
  [379]="Luka Elsner",[210]="Nicolas Seube",[62]="Stéphane Dumont",[294]="Ariel Jacobs",[1816]="Omar Daf",[111659]="Olivier Guégan",[1815]="Laurent Batlles",[115494]="Régis Brouard",[58]="Mathieu Chabert",[110321]="Bruno Irles",[1814]="Olivier Frapolli",[1805]="Vincent Hognon",[614]="Mathieu Raynal",[67]="Grégory Poirier",[111273]="Habib Beye",[111276]="Fabien Mercadal",[70]="Zoumana Camara",[1819]="Eirik Horneland",[122680]="David Carré",[1823]="Pablo Correa",[1739]="Mathieu Le Scornet", 
  -- germany bundesliga
  [175]="Niko Kovac",[38]="Ole Werner",[112172]="Marco Rose",[23]="Gerardo Seoane",[36]="Sebastian Hoeneß",[32]="Kasper Hjulmand",[1831]="Bojan Radeljic",[21]="Vincent Kompany",[100409]="Jess Thorup",[1824]="Dino Toppmöller",[25]="Christian Streich",[111235]="Frank Schmidt",[22]="Nuri Sahin",[110329]="Alexander Blessin",[10029]="Pellegrino Matarazzo",[169]="Bo Henriksen",[31]="Timo Schultz",[28]="Steffen Baumgart", 
  -- germany 2. bundesliga
  [580]="Horst Steffen",[165]="Alexander Zorniger",[110500]="Daniel Scherning",[10030]="Lukas Kwasniok",[1832]="Christian Eichner",[34]="Markus Anfang",[485]="Stefan Leitl",[166]="Pal Dardai",[171]="Mersad Selimbegovic",[110636]="Daniel Thioune",[29]="Jeff Saibene",[531]="Alexander Ende",[110588]="Christian Titz",[110502]="Torsten Frings",[160]="Heiko Butscher",[576]="Marcel Rapp",[159]="Mitchell Weiser",[503]="Pascal Bieler", 
  -- italy serie a
  [52]="Fabio Grosso",[46]="Maurizio Sarri",[347]="Marco Baroni",[55]="Gabriele Cioffi",[1842]="Davide Nicola",[110556]="Patrick Vieira",[206]="Marco Zaffaroni",[110374]="Vincenzo Italiano",[39]="Gian Piero Gasperini",[48]="Antonio Conte",[44]="Cristian Chivu",[54]="Roberto D'Aversa",[45]="Luciano Spalletti",[189]="Thiago Motta",[50]="Fabio Liverani",[1745]="Cesc Fàbregas",[47]="Massimiliano Allegri",[110738]="Filippo Inzaghi",[111974]="Fabio Grosso",[111434]="Eusebio Di Francesco", 
  -- italy serie b
  [1746]="Fabio Caserta",[205]="Giovanni Stroppa",[111811]="Paolo Bianco",[1744]="Massimo Rastelli",[1837]="Angelo Gregucci",[1843]="Eugenio Corini",[1848]="Raffaele Biancolino",[110740]="Davide Dionigi",[110908]="Giovanni Martusciello",[110915]="Michele Mignani",[111433]="Davide Possanzini",[111657]="Fabio Liverani",[112124]="Pasquale Marino",[112493]="Antonio Calabro",[112494]="Fabrizio Castori",[110741]="Luca D'Angelo",[200]="Silvio Baldini",[2038]="Davide Ballardini",[110912]="Manolo Gabbiadini",[113147]="Simone Banchieri", 
  -- usa mls
  [111140]="Giovanni Savarese",[114161]="Nico Estévez",[697]="Greg Vanney",[114640]="Dean Smith",[111928]="Luchi Gonzalez",[693]="Gregg Berhalter",[688]="René Weiler",[112828]="Nick Cushing",[694]="Matt Wells",[691]="Marko Mitrović",[113149]="Pat Noonan",[112893]="Guillermo Ojos",[114162]="Gary Smith",[112885]="Gerardo Martino",[687]="Henrik Rydström",[112134]="Jim Curtin",[101112]="Jesper Sørensen",[112996]="Marc Dos Santos",[112606]="Óscar Pareja",[111651]="Robin Fraser",[698]="Ben Olsen",[111065]="Pablo Mastroeni",[696]="Raphael Wicky",[689]="Michael Bradley",[111139]="Marco Donadel",[111138]="Cameron Knowles",[695]="Eric Quill",[111144]="Brian Schmetzer",[113018]="Yoann Damet",[121439]="Mikael Stahre", 
  -- norway eliteserien
  [298]="Alfred Johansson",[300]="Morten Jensen",[417]="Sindre Tjelmeland",[418]="Jørgen Vik",[918]="Kjetil Knutsen",[919]="Eirik Horneland",[920]="Geir Bakke",[922]="Johannes Moesgaard",[1463]="Amund Skiri",[1523]="Jan Halvor Halvorsen",[1756]="Jakob Michelsen",[1757]="Hans Erik Ødegaard",[2041]="Andreas Hagen",[112199]="Lars Arne Nilsen",[113459]="Christian Johnsen",[121491]="Kjetil Rekdal", 
  -- scotland premiership
  [81]="David Gray",[181]="Jim Goodwin",[83]="Jens Berthel Askou",[77]="Barry Robson",[80]="Steven Naismith",[100805]="Stephen Robinson",[78]="Brendan Rodgers",[86]="Danny Röhl",[82]="Derek McInnes",[180]="Tony Docherty",[79]="John Hughes",[621]="David Martindale", 
  -- spain la liga
  [1860]="Quique Sánchez Flores",[449]="Manuel Pellegrini",[457]="Imanol Alguacil",[243]="José Mourinho",[461]="Rubén Baraja",[240]="Diego Simeone",[241]="Hansi Flick",[453]="Martín Demichelis",[448]="Ernesto Valverde",[450]="Claudio Giráldez",[483]="Marcelino",[110062]="Míchel",[481]="Luis García Plaza",[479]="Jagoba Arrasate",[463]="Eduardo Coudet",[480]="Iñigo Pérez",[452]="Xavi García Pimienta",[110827]="Guillermo Almada",[1853]="Javier Calleja",[468]="Eder Sarabia", 
  -- spain segunda división
  [472]="Paco Jémez",[100888]="Iñigo Vélez",[462]="José Rojo Martín",[467]="Gaizka Garitano",[456]="José Luis Martí",[1861]="Rubén Albés",[110839]="Aritz López Garai",[1854]="Alberto Toril",[459]="Borja Jiménez",[110069]="José Alberto",[573]="Sergio Pellicer",[10846]="José Ramón Sandoval",[244]="Miguel Ángel Ramírez",[110832]="Paco López",[1968]="Sergio González",[242]="Fernando Vázquez",[1867]="José María Salmerón",[100852]="Javier Vidales",[1894]="Juanfran",[15012]="Curro Torres",[110711]="Ion Ansotegi",[114554]="Francesc Xavier García Pimienta", 
  -- sweden allsvenskan
  [319]="Stefan Billborn",[320]="Miguel Ángel Ramírez",[321]="Johan Lindholm",[433]="Andreas Alm",[700]="Björn Hamberg",[702]="Jens Gustafsson",[708]="Kalle Karlsson",[710]="Jani Honkavaara",[711]="Per-Mathias Høgmo",[111594]="Fredrik Holmberg",[111705]="Ulf Kristiansson",[112072]="Karl Marius Aksum",[112126]="Toni Koskela",[113458]="Andreas Engelmark",[113892]="Henok Goitom",[1870]="Alexander Rubin", 
  -- england league one
  [1797]="Matt Hamshaw",[1793]="Leam Richardson",[1933]="Mike Dodds",[4]="Steven Schumacher",[1930]="Kevin Nolan",[1926]="Steve Bruce",[1917]="Gary Caldwell",[1958]="Richie Wellens",[361]="Alex Revell",[149]="Michael Skubala",[1939]="Liam Manning",[1932]="Conor Hourihane",[1938]="Luke Williams",[15015]="Gary Bowyer",[1940]="Nigel Clough",[1931]="Dave Challinor",[143]="Matt Taylor",[142]="Grant McCann",[1928]="Jon Brady",[1804]="Graham Alexander",[1923]="Jack Wilshere",[1929]="Tom Cleverley",[1961]="Brian Barry-Murphy",[112259]="Johnnie Jackson", 
  -- england league two
  [91]="David Artell",[121]="Lee Bell",[127]="Michael Appleton",[135]="Dean Brennan",[381]="Andy Crosby",[1798]="Paul Warne",[1802]="Gareth Ainsworth",[1803]="Mat Sadler",[1920]="Micky Mellon",[1924]="Paul Cook",[1934]="Ian Holloway",[1935]="Danny Cowley",[1936]="Michael Flynn",[1937]="Martin Paterson",[1944]="Neil Harris",[1962]="Darrell Clarke",[15048]="Andy Crosby",[110313]="John Doolan",[110890]="Scott Lindsey",[112222]="Simon Weaver",[112254]="David Hughes",[112260]="Pete Wild",[112764]="Andy Woodman",[113926]="Karl Robinson", 
  -- ireland premier division
  [305]="Alan Reynolds",[306]="Stephen Bradley",[423]="Jon Daly",[445]="Ruaidhrí Higgins",[563]="John Russell",[753]="Jon Daly",[834]="Damien Duff",[837]="Stephen O'Donnell",[1571]="John Caulfield",[1572]="Kevin Doherty",[422]="Colin Healy", 
  -- poland ekstraklasa
  [301]="Željko Sopić",[420]="Michal Gašparík",[873]="Niels Frederiksen",[1871]="Gustavo Costas",[110206]="Rafał Górak",[110745]="Adrian Siemieniec",[110746]="Jens Gustafsson",[110747]="Bartosz Grzelak",[110749]="Leszek Ojrzyński",[111083]="Jacek Zieliński",[111086]="Aleksandar Vuković",[111088]="Grzegorz Mokry",[111091]="John Carver",[111097]="Mariusz Rumak",[114326]="Marek Papszun",[111082]="Dariusz Banasik",[112510]="Marcin Brosz",[1569]="Radosław Sobolewski", 
  -- russia premier league
  [312]="Igor Osinkin",[315]="Fabio Celestini",[100764]="Magomed Adiyev",[100765]="Mikhail Galaktionov",[100767]="Juan Carlos Carcedo",[100769]="Sergei Semak",[110102]="Vadim Evseev",[110109]="Stanislav Cherchesov",[110227]="Franc Artiga",[110231]="Jonatan Alba",[112217]="Aleksey Shpilevsky",[112218]="Murad Musayev",[112261]="Vladimir Slišković",[130988]="Zaur Tedeev",[110222]="Igor Osinkin",[110238]="Andrei Talalayev", 
  -- turkey süper lig
  [326]="Domenico Tedesco",[325]="Okan Buruk",[110776]="Burak Yılmaz",[436]="Fatih Tekke",[327]="Sergen Yalçın",[101033]="Levent Şahin",[113142]="João Pereira",[111339]="Shota Arveladze",[101014]="Nuri Şahin",[101020]="Radomir Đalović",[741]="Emre Belözoğlu",[748]="Thomas Reis",[101026]="Stanimir Stoilov",[101037]="İlhan Palut",[121174]="Atila Gerin",[111117]="Onur Can Korkmaz",[101025]="Volkan Demirel",[101032]="Selçuk İnan", 
  -- national teams
  [110082]="Veljko Paunović",[1365]="Vincenzo Montella",[1366]="Serhiy Rebrov",[1367]="Craig Bellamy",[111512]="Graham Arnold",[111111]="Mohamed Ouahbi",[1353]="Jan Urban",[111533]="Anthony Hudson",[111506]="Zé Pedro",[1331]="Brian Riemer",[111505]="Félix Dalmás",[111513]="Jamal Sellami",[111487]="Fernando Batista",[111391]="Hélio Sousa",[111523]="Branko Ivanković",[111449]="Pedro Gonçalves",[111514]="Maksim Lisitsyn",[111536]="Marcel Koller",[111532]="Igor Shkvyrin",[111456]="Bubista",[1357]="Valery Karpin",[111464]="Jørn Andersen",[111510]="John Herdman",[1395]="Marc Brys",[1393]="José Peseiro",[1667]="Aliou Cissé",[1391]="Jalel Kadri",[1387]="Mauricio Pochettino",[1386]="Javier Aguirre",[1383]="Gustavo Alfaro",[1377]="Marcelo Bielsa",[1375]="Daniel Garnero",[1370]="Carlo Ancelotti",[1369]="Lionel Scaloni",[1341]="Aage Hareide",[1338]="Ivan Jovanović",[111515]="Michael Weiß",[1330]="Miroslav Koubek",[1363]="Jon Dahl Tomasson",[1362]="Luis de la Fuente",[1328]="Zlatko Dalić",[1360]="Francesco Calzona",[1359]="Steve Clarke",[1356]="Edward Iordănescu",[1415]="Graham Arnold",[1886]="Marco Rossi",[1411]="Hajime Moriyasu",[111114]="Georgios Donis",[111521]="Michael Feichtenbeiner",[111473]="Danny Hay",[111466]="Igor Štimac",[111465]="Félix Sánchez",[111462]="Chris Hughton",[111459]="Ricardo Gareca",[111455]="Jesse Marsch",[111451]="Antônio Carlos Zago",[111448]="Abdelhak Benchikha",[111130]="Marcel Koller",[111115]="Amir Ghalenoei",[1318]="Thomas Tuchel",[111112]="Emerse Faé",[1343]="Luciano Spalletti",[111109]="Néstor Lorenzo",[111108]="Jorge Célico",[111099]="Hugo Broos",[1335]="Didier Deschamps",[110081]="Michael O'Neill",[105035]="Ronald Koeman",[105022]="Blagoj Milevski",[111527]="Tintín Márquez",[111461]="Thierry Mouyouma",[111475]="Thomas Christiansen",[111525]="Makram Daboub",[111453]="Blaise Kilama",[1354]="Roberto Martínez",[111528]="Tsutomu Ogura",[111504]="Mario Rivera",[1361]="Matjaž Kek",[111526]="Michael Weiß",[1325]="Domenico Tedesco",[1319]="Sylvinho",[105013]="Vladan Milojević",[1413]="Branko Ivanković",[1327]="Ilian Iliev",[1322]="Ralf Rangnick",[974]="Hong Myung-bo",[1334]="Markku Kanerva",[1352]="Ståle Solbakken",[111518]="Peter Cklamovski",[112048]="Jean-Jacques Pierre",[111545]="Sébastien Desabre",[111485]="Slavche Shkëlzenov",[111489]="Aljoša Asanović",[111550]="Éric Chelle",[1364]="Murat Yakın",[1337]="Julian Nagelsmann",[111488]="Kim Sang-sik",[1355]="Stephen Kenny",[111530]="Héctor Cúper",[1336]="Kakhaber Tskhadadze",[111481]="Heimir Hallgrímsson",[112062]="Serigne Abdou Thiam",[112044]="Nassor N'Diaye",[111483]="Paulo Duarte",[112046]="Baciro Candé",[112049]="Nicolas Rabésandratana",[111472]="Chiquinho Conde",[111392]="Luka Elsner",[111549]="Yun Jong-su",[112054]="Arturo Álvarez",[112060]="Giovanni Savarese",[111740]="Miodrag Božović",[111463]="Kaba Diawara",[105042]="Fabrizio Costantini",[111516]="Aleksandar Ilić",[111502]="Óscar Bruzón",[111486]="Jimmy Nagle",[111537]="Samuel García",[112486]="Marcial Poro",[112063]="Timote Moleni",[111547]="Marcelo Vega",[111548]="Pedro Troglio",[111546]="Hugo Pérez",[111524]="Shahzad Anwar",[112067]="Tarek Thabet",[1321]="Ognjen Čančarević",[114639]="Primož Gliha",[1349]="Devis Mangia",[1323]="Gurban Gurbanov",[1333]="Sámuel Erdsack",[111450]="Gernot Rohr",[111555]="Moses Basena",[111113]="Luis Fernando Tena",[111110]="Mario Mutsch",[111484]="Dennis Lawrence",[112038]="Yasnier Romero",[1344]="Dainis Kazakevičs",[111551]="Jaime de la Pava",[130501]="Jocelyn Angloma",[111535]="Rahmatullo Fuzailov",[111471]="Mário Soares",[112053]="Colin Benjamin",[1324]="Sergei Gurenko",[111467]="Francis Kimanzi",[115656]="Xabi Alonso",[111522]="Vincent Subramaniam",[111519]="Ali Ashfaq",[111107]="Andrei Karpovich",[112037]="Younes Ali",[111482]="Jalel Kadri",[111480]="Burhan Tia",[112050]="Corentin Martins",[111452]="Wesley Mondoro",[111556]="Bruce Grobbelaar",[112042]="Cus Basabe",[112041]="Marcelo Neveleff",[111454]="Etienne Ndayiragije",[1329]="Marios Elia",[1332]="Alberts Zvejnieks",[111469]="Ansu Toure",[111468]="Thabo Senong",[111479]="Vladimir Vujović",[111553]="Marlon Nonu",[111501]="Petar Šegrt", 
  -- Austria
  [191]="Daniel Beichler",[209]="Fabio Ingolitsch",[252]="Dietmar Kühbauer",[254]="Robert Ilyés",[256]="Stephan Helm",[2017]="Manfred Schmid",[15009]="Ognjen Zaric",[15040]="Philipp Semlic",[110720]="Michael Köllner",[111822]="Ismail Atalan",[113616]="Ferdinand Feldhofer",[780]="Maximilian Senft", 
  -- South Korea
  [980]="Hwang Sun-Hong",[982]="Kim Gi-dong",[1473]="Hong Myung-bo",[1474]="Park Tae-ha",[1477]="Kim Sang-sik",[1478]="Nam Ki-il",[2056]="Choi Won-kwon",[110765]="Jo Sung-hwan",[112115]="Lee Jung-hyo",[112258]="Lee Jung-hyo",[112558]="Kim Do-hoon",[2055]="Kim Tae-wan",[112555]="Lee Seung-woo", 
  -- Switzerland
  [322]="Gerald Scheiblehner",[324]="Alain Geiger",[894]="Ricardo Moniz",[896]="Heiko Vogel",[897]="Mario Frick",[898]="Peter Zeidler",[900]="Raphael Wicky",[1704]="Andrea Binotto",[1713]="Uli Forte",[1862]="Ludovic Magnin",[10032]="Mattia Croci-Torti",[110770]="Christian Zermatten",[1715]="Marius Zarn", 
  -- Portugal
  [1438]="Vasco Seabra",[10020]="Ricardo Soares",[112513]="Armando Evangelista",[1887]="Álvaro Pacheco",[234]="José Mourinho",[744]="Filipe Martins",[112809]="Ivo Vieira",[114510]="Filipe Coelho",[1896]="Artur Jorge",[236]="Sérgio Conceição",[237]="João Pereira",[1888]="Vítor Campelos",[718]="Filipe Gouveia",[1891]="Rui Borges",[1900]="Jorge Simão",[121463]="Sérgio Vieira",[717]="Filipe Martins",[112516]="Nuno Campos", 
  -- Romania
  [308]="Mirel Rădoi",[310]="Liviu Ciobotariu",[100757]="Ovidiu Burcă",[100761]="Eduard Iordănescu",[110072]="Dan Alexa",[110075]="Gheorghe Hagi",[110078]="Adrian Mutu",[110750]="Marius Măldărășanu",[110751]="Cristian Pustai",[110752]="Marius Croitoru",[110815]="Marius Lăcătuș",[113378]="Adrian Neaga",[114147]="Marius Șumudică",[114385]="Andrea Pirlo",[114549]="Cristian Bălgrădean",[121459]="Mihai Teja",[114546]="Valentin Sinescu",[114545]="Gabriel Răduță",[100759]="Laurențiu Reghecampf", 
  -- Chile
  [101097]="Nicolás Núñez",[110978]="Gustavo Álvarez",[112585]="Mario Salas",[112116]="Juan Manuel Azconzábal",[111328]="Pablo Guede",[112705]="Fernando Díaz",[112584]="Jorge Célico",[111327]="Jorge Almirón",[110977]="Ronald Fuentes",[112535]="Héctor Tapia",[110975]="Nicolás Córdova",[110980]="Fernando Ortiz",[112531]="José Luis Sierra",[15029]="Mauricio Soria", 
  -- Colombia
  [101100]="Diego Arias",[101099]="Lucas González",[101105]="Alberto Gamero",[101101]="Jorge Célico",[101103]="David González",[111722]="Julio Comesaña",[101106]="Eduardo Lara",[101104]="Néstor Lorenzo",[112744]="Jorge Célico",[112992]="Leonel Álvarez",[101102]="Jorge Célico",[112526]="Jorge Célico",[112578]="Jorge Célico",[112715]="Jorge Célico",[111723]="Jorge Célico",[112579]="Jorge Célico",[112019]="Jorge Célico",[112834]="Jorge Célico",[114623]="Jorge Célico",[112523]="Jorge Célico", 
  -- Uruguay
  [101109]="Martín Lasarte",[101110]="Diego Aguirre",[110998]="Alejandro Apud",[111001]="Juan Tejera",[111325]="Álvaro Gutiérrez",[111326]="Pablo Peirano",[112184]="Diego López",[112615]="Jorge Célico",[112868]="Jorge Célico",[113143]="Jorge Célico",[114024]="Jorge Célico",[115536]="Jorge Célico",[129992]="Jorge Célico",[130022]="Jorge Célico",[130045]="Jorge Célico",[130984]="Jorge Célico",[129513]="Jorge Célico", 
  -- Liga MX
  [101121]="Martín Varini",[1878]="Nicolás Larcamón",[111678]="Sebastián Abreu",[110781]="Javier Gandolfi",[110147]="Esteban Solari",[1032]="Nicolás Sánchez",[101114]="Diego Cocca",[110150]="Esteban González",[1879]="André Jardine",[112678]="Raúl Chabrand",[1881]="Efraín Juárez",[1880]="Gabriel Milito",[114899]="Sergio Bueno",[110152]="Albert Espigares",[110144]="Omar Tapia",[1882]="Antonio Mohamed",[113134]="Pedro Caixinha",[1970]="Miguel Herrera", 
  -- South Africa
  [110929]="Nasreddine Nabi",[110930]="José Riveiro",[110935]="Rhulani Mokwena",[110932]="Gavin Hunt",[111104]="Dylan Kerr",[130254]="Pablo Franco Martin",[130320]="Eric Tinkler",[130321]="Kurt Lentjies",[130322]="Vusumuzi Vilakazi",[130323]="Sello Chokoe",[130324]="Mabhuti Khanyeza",[130325]="Kaitano Tembo",[130326]="Steve Barker",[130327]="Mogogi Gabonamong",[130328]="Fadlu Davids",[130329]="Vasili Manousakis", 
  -- Japan
  [101146]="Hiroshi Nanami",[101147]="Daiki Iwamasa",[101148]="Akio Kogiku",[101150]="Albert Puig",[101151]="Kevin Muscat",[111038]="Cho Kwi-jae",[111575]="Per-Mathias Høgmo",[111730]="Toru Oniki",[112092]="Kenta Hasegawa",[112093]="Daniel Poyatos",[113157]="Michael Skibbe",[113161]="Satoshi Yamaguchi",[113186]="Shigetoshi Hasebe",[113197]="Yoshiyuki Shinoda",[101145]="Nelsinho Baptista",[112906]="Kazuaki Tasaka",[130572]="Go Kuroda",[130578]="Hiroshi Jofuku",[101149]="Rikizo Matsuhashi",[150722]="Takashi Kiyama",[130573]="Tetsuya Asano", 
  -- Saudi Arabia
  [112390]="Georgios Donis",[111674]="Vítor Pereira",[112096]="Steven Gerrard",[112139]="Luís Castro",[113057]="Marcelo Gallardo",[112883]="Pedro Emanuel",[112393]="Pepa",[113060]="Igor Bišćan",[113217]="Cosmin Contra",[607]="Marcelo Gallardo",[113037]="Hélder",[605]="Jorge Jesus",[112387]="Matthias Jaissle",[112391]="Míchel",[121735]="Nuno Espírito Santo",[113222]="Eduardo Gomes",[115892]="Sami Al-Jaber",[121798]="Rui Vitória", 
  -- Australia
  [111393]="Carl Veart",[111395]="Ben Cahn",[111396]="Mark Jackson",[111397]="Tony Popovic",[111398]="Robbie Stanton",[111399]="David Zdrilic",[111400]="Ufuk Talay",[111766]="Giancarlo Italiano",[112224]="Aurelio Vidmar",[112427]="Marko Rudan",[114023]="John Aloisi",[114604]="Mile Sterjovski",[121739]="Steve Corica", 
  -- Argentina
  [110396]="Gabriel Heinze",[111706]="Daniel Oldrá",[101083]="Eduardo Domínguez",[112713]="Facundo Sava",[111716]="Mariano Soso",[1877]="Fernando Gago",[112965]="Jorge Célico",[111708]="Pablo Peirano",[101085]="Gustavo Costas",[110093]="Ricardo Zielinski",[111711]="Sebastián Battaglia",[112689]="Federico Vilar",[113044]="Cristian Vázquez",[111710]="Hernán Crespo",[101088]="Mauricio Pellegrino",[110395]="Ricardo Caruso Lombardi",[111715]="Diego Martínez",[112670]="Jorge Almirón",[110580]="Carlos Tevez",[1013]="Rubén Insúa",[110404]="Julio César Falcioni",[111019]="Gabriel Milito",[1876]="Marcelo Gallardo",[101084]="Sergio Rondina",[110953]="Diego Dabove",[111022]="Guido Carboni",[111020]="Jorge Célico",[115472]="Pablo Peirano",[111707]="Walter Erviti",[111713]="Leonardo Madelón", 
  -- Spanyol
  [110710]="Julián López de Lerma", 
  -- Hong Kong
  [111622]="Iñigo Calderón",[130181]="Roberto Losada",[130182]="Chu Siu-kei",[129054]="Lee Chi-kin",[129055]="Chan Ming-kong",[129056]="Cheng Siu-wai",[129057]="Tony Cooke",[129058]="Poon Man-chun",[129059]="Tim Bredbury", 
  -- Singapura
  [111637]="William Phang",[111640]="Jesús Casas",[111641]="Firdaus Kassim",[111642]="Kazuaki Yoshinaga",[111645]="Marko Kraljević",[111646]="Noor Ali",[130225]="Akbar Nawas",[130226]="Noh Rahman", 
  -- Qatar
  [111090]="Younes Ali",[111658]="Pejman Montazeri",[111670]="Sami Trabelsi",[111733]="Roberto Mancini",[112094]="Pedro Martins",[112099]="Djamel Belmadi",[112234]="Jesualdo Ferreira",[112631]="Sabri Lamouchi",[130278]="Vicente Moreno",[130281]="Ruben Albes",[130279]="Cosmin Contra",[130382]="Tintín Márquez", 
  -- Kamboja
  [129094]="Scott Cooper",[129095]="Oleg Starynskiy",[129096]="Oriol Mohedano",[129097]="Hok Sochetra",[129098]="Meas Channa",[129099]="Alireza Fard",[129100]="Satyasagara",[129101]="Tum Saray",[129102]="Heo Jae-won",[129103]="Khim Borey",[129104]="Jean Botioba", 
  -- Myanmar
  [129082]="Min Tun Lin",[129083]="Tetsuro Uki",[129084]="Kyaw Min Oo",[129085]="Myo Min Tun",[129086]="Zaw Linn Tun",[129087]="Nyi Nyi Tun",[129088]="Aung Naing Myo",[129089]="Than Htut Aung",[129090]="Khin Maung Tun",[129091]="Min Thu",[129092]="Kyaw Zin Win",[129093]="Aung Myint Myat", 
  -- Laos
  [129074]="Bounlap Khenkitisack",[129075]="Chandalaphone Liepvixay",[129076]="Hatsadong Lokaphone",[129077]="Viengsavanh Sayyaboun",[129078]="Saysamone Phommachanh",[129079]="Phouvanh Vongsouvath",[129080]="Khamla Pinkeo",[129081]="Anouphong Phommachack", 
  -- Bangladesh
  [130445]="Md Akbar Hossain Ridon",[130446]="Md Mizanur Rahman",[130476]="Óscar Bruzón",[130477]="Maruful Haque",[130478]="Mario Lemos",[130479]="Sérgio Farias",[130480]="Óscar Bruzón",[130481]="Mahbubur Rahman Sufil",[130482]="Kamal Babu",[130483]="Saiful Bari Titu", 
  -- China
  [110955]="Leonid Slutsky",[111724]="Choi Kang-hee",[111768]="Ricardo Soares",[111769]="Chen Yang",[111774]="Yu Genwei",[111779]="Sérgio Conceição",[112163]="Jordi Cruyff",[112540]="Kevin Muscat",[112979]="David Patrício",[112985]="Zhao Junzhe",[114628]="Miloš Milojević",[116360]="Seo Jung-won",[116361]="Fábio Carille",[121173]="Yasen Petrov",[121487]="Li Jinyu",[121488]="Wang Bo",[121531]="Gao Hongbo",[122305]="Xie Hui", 
  -- UAE
  [110961]="Luís Castro",[110962]="Darko Milanič",[111701]="Vladimir Ivić",[111836]="Marino Pušić",[112098]="Paulo Sousa",[112100]="José Morais",[112167]="Slaviša Jokanović",[112459]="Hussein Ammouta",[113959]="Goran Tufegdžić",[114693]="Farhad Majidi",[114696]="Ghazi Al Shammari",[130080]="Ivan Hasek",[130221]="Nabil Maâloul",[113729]="Luis Blanagoma", 
  -- Tunisia
  [110947]="Mohamed Kouki",[110948]="Faouzi Benzarti",[111353]="Jorge Sampaoli",[111354]="Nabil Kouki",[111356]="Anis Boujelbene",[111357]="Lassaad Chabbi",[111361]="Sami Trabelsi",[111366]="Karim Touati",[130299]="Maher Guizani",[130302]="Moez Bouakaz",[130303]="Sofiene Hidoussi",[130304]="Hichem Sebai",[130300]="Riadh Bouazizi",[130298]="Zoubeir Baya",[130305]="Lotfi Sellami",[130301]="Fethi Laabidi", 
  -- Brazil
  [111042]="Daniel Paulista",[111046]="Cláudio Tencati",[111976]="Marcelo Cabo",[113372]="Márcio Zanardi",[113629]="Maurício Barbieri",[115530]="Ivo Vieira",[111059]="Guto Ferreira",[111052]="Vagner Mancini",[111041]="Celso Roth",[111057]="Paulo Pezzolano",[112119]="Jair Ventura",[114507]="Ricardo Catalá",[112263]="Hélio dos Anjos",[112717]="Márcio Fernandes",[111043]="Felipe Conceição",[112805]="Luizinho Vieira",[111050]="Marcelo Martelotte",[132067]="Ricardo Colbachini",[130475]="Roger Machado",[112001]="Lúcio Flávio", 
  -- Algeria
  [111156]="Lamine N'Diaye",[111157]="Abdelkader Amrani",[130242]="Billel Dziri",[130599]="Mourad Okbi",[130600]="Khaled Ben Yahia",[130814]="Alain Michel",[130815]="Abdelhak Benchikha",[130816]="Mounir Zeghdoud",[130817]="Faouzi Benzarti",[130818]="Noureddine Zekri",[130819]="Kamel Mouassa",[130820]="Nabil Neghiz",[130821]="Djamel Menad",[130822]="Boualem Charef",[130823]="Abdelkader Amrani",[150650]="Sven Vandenbroeck", 
  -- Germany
  [27]="Mersad Selimbegović",[33]="Markus Kauczinski",[162]="Claus-Dieter Wollitz",[487]="Tobias Schweinsteiger",[492]="Nils Döring",[506]="Carsten Müller",[523]="Rüdiger Rehm",[526]="Uwe Neuhaus",[543]="Marius Ebbers",[583]="Markus Gellhaus",[1825]="Torsten Ziegner",[1826]="Christian Titz",[110176]="Thomas Wörle",[110501]="Alexander Ende",[110532]="Marco Antwerpen",[110645]="Olaf Janßen",[110678]="Daniel Brinkmann",[110685]="Dennis Hillebrand",[110697]="Marc Kienle",[111239]="Sabrina Wittmann", 
  -- Women's National Teams
  [113005]="Andrea Soncin",[113008]="Tony Gustavsson",[113002]="Sarina Wiegman",[116428]="Þorsteinn Halldórsson",[113000]="Casey Stoney",[131144]="Jorge Vilda",[115511]="Satoru Mochizuki",[113010]="Pedro López",[131139]="Ángelo Marsiglia",[115362]="Jakob Michelsen",[131143]="Mark Torcaso",[115682]="Francisco Neto",[131147]="Pia Sundhage",[113007]="Gemma Grainger",[131140]="Rafel Navarro",[113003]="Laurent Bonadei",[113006]="Futoshi Ikeda",[113984]="Stuart McLaren",[113009]="Emma Hayes",[131145]="Bruce Mwape",[116440]="Vera Pauw",[131142]="Amelia Valverde",[131148]="Ignacio Quintana",[113011]="Andries Jonker",[113012]="Jorge Vilda",[113394]="Ives Serneels",[113258]="Jitka Klimková",[113997]="Randy Waldrum",[113004]="Martina Voss-Tecklenburg",[113987]="Colin Bell",[131141]="Mai Đức Chung",[113991]="Lorne Donaldson",[112999]="Pia Sundhage",[113996]="Carlos Borrello",[112998]="Tony Gustavsson",[113001]="Shui Qingxia",[113998]="Desiree Ellis",[121877]="Nina Patalon",[121124]="Marko Saloranta", 
  -- egypt premier league
  [150735]="Jess Thorup",[155450]="Motamed Gamal",[155449]="Krunoslav Jurcic",[155448]="Emad El-Nahhas",[155447]="Miloud Hamdi",[155446]="Ali Maher",[111180]="Hamza El Gamal",[111181]="Haitham Shaaban",[111183]="Ashraf Tawfek",[111184]="Alaa Abdelaal",[111348]="Samy Komsan",[115514]="Mostafa Bebo",[115868]="Gomaa Mashhour",[130037]="Mohamed Shawky",[130040]="Ahmed Abdelaziz",[130046]="Ayman Al Ramadi",[130219]="Talaat Youssef",[130220]="Ahmed Khattab",[155445]="Yasser Bahaa El Din", 
  -- indonesia liga 1
  [155606]="Pieter Huistra",[155603]="Maurício Souza",[155611]="Jan Olde Riekerink",[155604]="Bernardo Tavares",[155614]="Carlos Parreira",[155607]="Johnny Jansen",[155601]="Tomas Trucha",[155600]="Marquinhos Santos",[155612]="Kim Swee Ong",[155617]="Divaldo Alves",[155616]="Leonardo Medina",[155620]="Vacancy",[155621]="Imran Nahumarury",[155618]="Vacancy",[155602]="Bojan Hodak",[155624]="Seto Nurdiantoro",[155609]="Mario Gómez",[155630]="Vacancy", 
  -- thailand thai league 1
  [150601]="Alexandre Gama",[150600]="Mark Jackson",[112730]="Rangsan Viwatchaichok",[111736]="Totchtawan Sripan",[150602]="Vladimir Vujović",[115529]="Sirisak Yodyardthai",[130288]="Worrawoot Srimaka",[130291]="Pipob On-Mo",[130292]="Rattee Ueathanaphaisarn",[130293]="Sasom Pobprasert",[130294]="Wanderley Junior",[130295]="Issara Sritaro",[130296]="Somchai Maiwilai",[130384]="Thongchai Sukkoki",[130386]="Mikael Stahre",[130999]="Jukkapant Punpee", 
  -- indonesia liga 2
  [155622]="Rahmad Darmawan",[155623]="Eko Purdjianto",[155625]="Bima Sakti Tukiman",[155626]="Andhika Mulia Pratomo",[155615]="Ansyari Lubis",[155610]="Stefano Teco Cugurra",[155605]="Kahudi Widodo",[155631]="Stefan Keeltjes",[155632]="Joko Susilo",[155633]="Akhyar Ilyas",[155634]="Widodo Cahyono Putro",[155635]="Aji Santoso",[155636]="I Putu Gede",[155637]="Nil Maizar",[155638]="Widyantoro",[155639]="Alfiat",[155640]="Ade Suhendra",[155641]="Muhammad Nasuha",[155642]="Ridwan Saragih",[155643]="Dedi Kusnandar",[155644]="Herry Kiswanto",[155613]="Angel Alfredo Vera",[155619]="Achmad Zulkifli",[155608]="Budiardjo Thalib",[155628]="I Putu Gede",[155629]="Slamet Riadi",[155627]="Sasi Kirono", 
  -- vietnam vleague 1
  [150632]="Lê Quang Trãi",[150631]="Vũ Hồng Việt",[150630]="Makoto Teguramori",[150633]="Velizar Popov",[150634]="Nobuhiro Ueno",[150636]="Phùng Thanh Phương",[150637]="Mano Pölking",[150638]="Võ Hoàng",[150639]="Ken Morton",[150640]="Chu Đình Nghiêm",[150641]="Gerard Albadalejo",[129671]="Lê Văn Hùng",[129673]="Thạch Bảo Khanh",[129667]="Ueno Nobuhiro", 
  -- national team u23
  [115512]="Gerald Vanenburg",[115515]="Hoàng Anh Tuấn",
}

EAFCInfo = {
  bnd_forceCaps = true,
  bnd_team_crest3_show = false,
  bnd_fontFace = "$CruyffSans-Extended-Heavy",
  bnd_fontFace_player_number_sub = "$CruyffSans-Extended-Heavy",
  bnd_field_width = 1170,
  bnd_field_height = 660,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$Starting11",
    id = 0
  },
  bnd_field_alpha = 0.9,
  
  bnd_TeamRect_cornerRaduis = 30,
  bnd_TeamRect_height = 650,
  bnd_TeamRect_top = 2,
  bnd_TeamRect_left = 0.0001,
  bnd_TeamRect_width = 0.0001,
  
  bnd_card_width = 120,
  bnd_card_height = 110,
  bnd_card_left = 0,
  bnd_card_top = 0,
  bnd_card_alpha = 0,
  bnd_card = {
    name = "$Cardx",
    id = 0
  },
  --card team
  bnd_card_team_width = 120,
  bnd_card_team_height = 110,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 1,
  --FormasiPemain
  bnd_formation_scaleX = 1,
  bnd_formation_scaleY = 1,
  bnd_formation_left = -130,
  bnd_formation_top = 44,
  
  bnd_bg_number_color = "0x05F280",
  bnd_bg_number_alpha = 1,
  
  bnd_player_number_fontColor = "0x000000",
  bnd_player_number_fontSize = 15,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 0,
  bnd_player_number_top = 0,
  
  bnd_bg_name_alpha = 1,
  bnd_bg_name_color = "0x05F280",
  
  bnd_player_name_fontColor = "0x000000",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = -8,
  --TeamCrest
  bnd_team_crest_width = 50,
  bnd_team_crest_height = 50,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 762,
  bnd_team_crest_top = 30,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -2,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 75,
  bnd_team_crest3_height = 75,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 9000000,
  bnd_team_crest3_top = 7,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_width = 140,
  bnd_team_name_fontSize = 21,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 850,
  bnd_team_name_top = 55,
  -- coach name
  bnd_coach_name_fontSize = 20,
  bnd_coach_name_fontColor = "0x000000",
  bnd_coach_name_alignV = "TOP",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 765,
  bnd_coach_name_top = 180,
  -- txt coach
  bnd_text_coach = "COACH",
  bnd_text_coach_fontSize = 25,
  bnd_text_coach_fontColor = "0x000000",
  bnd_text_coach_left = 765,
  bnd_text_coach_top = -80,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0x000000",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 850,
  bnd_team_formation_top = 80,
  --Subt
  bnd_cadangan_scaleX = 0.8,
  bnd_cadangan_scaleY = 0.8,
  bnd_posisi_sub_left = 277,
  bnd_posisi_sub_top = 0,
  bnd_text_sub = "SUBS",
  bnd_text_sub_fontSize = 22,
  bnd_text_sub_fontColor = "0x000000",
  bnd_text_sub_left = -40,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 18,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x000000",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0.0001,
  bnd_team_crest2_height = 0.0001,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 765,
  bnd_team_crest2_top = 90,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "53_2"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 22,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 10,
  bnd_logo_right = 100,
  bnd_logo_bottom = 0,
    -- title
  bnd_title_left = -420,
  bnd_title_top = 0,
  bnd_text_title = "Coach",
  bnd_text_title_fontSize = 20,
  bnd_text_title_fontColor = "0x000000",
  bnd_text_title_left = 660,
  bnd_text_title_top = -130
}
PremierLeagueInfo = {
  bnd_forceCaps = false,
  bnd_team_crest3_show = false,
  bnd_fontFace = "$Epl",
  bnd_fontFace_player_number_sub = "$EPL_Light",
  bnd_field_width = 1430,
  bnd_field_height = 660,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$Starting11",
    id = 13
  },
  bnd_field_alpha = 1,
  
  bnd_TeamRect_cornerRaduis = 30,
  bnd_TeamRect_height = 650,
  bnd_TeamRect_top = 2,
  bnd_TeamRect_left = 605,
  bnd_TeamRect_width = 560,
  
  bnd_card_width = 120,
  bnd_card_height = 110,
  bnd_card_left = 0,
  bnd_card_top = 0,
  bnd_card_alpha = 0,
  bnd_card = {
    name = "$Card",
    id = 13
  },
  -- card team
  bnd_card_team_width = 120,
  bnd_card_team_height = 110,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 1,
  --FormasiPemain
  bnd_formation_scaleX = 1.2,
  bnd_formation_scaleY = 1.2,
  bnd_formation_left = -190,
  bnd_formation_top = -1,
  
  bnd_bg_number_color = "0x38003D",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0xF5F5F5",
  bnd_player_number_fontSize = 20,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 25,
  bnd_player_number_top = -67,
  
  bnd_bg_name_alpha = 0,
  bnd_bg_name_color = "0xF5F5F5",
  
  bnd_player_name_fontColor = "0x38003D",
  bnd_player_name_fontSize = 12,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -37,
  bnd_player_name_top = 0,
  --TeamCrest
  bnd_team_crest_width = 130,
  bnd_team_crest_height = 130,
  bnd_team_crest_alignV = "CENTER",
  bnd_team_crest_alignH = "CENTER",
  bnd_team_crest_left = 340,
  bnd_team_crest_top = 0,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 80,
  bnd_player_avatar_height = 80,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -10,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 1,
  
  bnd_team_crest3_width = 0.00001,
  bnd_team_crest3_height = 0.0001,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 700000,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_width = 310,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0x38003D",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = -100,
  bnd_team_name_top = -50,
  -- coach name
  bnd_coach_name_fontSize = 20,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 950,
  bnd_coach_name_top = -120,
  -- txt coach
  bnd_text_coach = "Manager",
  bnd_text_coach_fontSize = 20,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 950,
  bnd_text_coach_top = -160,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0x38003D",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 230,
  bnd_team_formation_top = -50,
  --Subt
  bnd_posisi_sub_left = 460,
  bnd_posisi_sub_top = -80,
  bnd_cadangan_scaleX = 1.1,
  bnd_cadangan_scaleY = 1.1,
  bnd_text_sub = "Subtitution",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xF5F5F5",
  bnd_text_sub_left = -30,
  bnd_text_sub_top = 5,
  bnd_playersub_fontSize = 20,
  bnd_playersub_fontColor = "0xF5F5F5",
  bnd_playergksub_fontColor = "0xF5F5F5",
  -- number subt
  bnd_player_number_sub_right = 10,
  bnd_player_number_sub_fontColor = "0xF5F5F5",
  --Coach/Manager
  bnd_team_crest2_width = 0.0001,
  bnd_team_crest2_height = 0.0001,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = -160,
  bnd_team_crest2_bottom = -30,
  --Logo
  bnd_logo = {
    name = "$LeagueLogox",
    id = "13_3"
  },
  bnd_logo_width = 220,
  bnd_logo_height = 60,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = -30,
  bnd_logo_right = -100,
  bnd_logo_bottom = 0
}

LALIGAInfo = {
  bnd_forceCaps = true,
  bnd_team_crest3_show = false,
  bnd_fontFace = "$LaLiga",
  bnd_fontFace_player_number_sub = "$LaLiga",
  bnd_field_width = 1070,
  bnd_field_height = 500,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field_alpha = 1,
  bnd_field = {
    name = "$Starting11",
    id = 53
  },
  bnd_card_width = 120,
  bnd_card_height = 120,
  bnd_card_left = 15,
  bnd_card_top = 0,
  bnd_card_alpha = 1,
  bnd_card = {
    name = "$Card",
    id = 53
  },
  --card team
  bnd_card_team_width = 0.0001,
  bnd_card_team_height = 0.0001,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 0,
  --FormasiPemain
  bnd_formation_scaleX = 0.8,
  bnd_formation_scaleY = 0.8,
  bnd_formation_left = 170,
  bnd_formation_top = 25,
  
  bnd_bg_number_color = "0x000000",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0xFFFFFF",
  bnd_player_number_fontSize = 0.00000001,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 0,
  bnd_player_number_top = 0,
  
  bnd_bg_name_alpha = 0,
  bnd_bg_name_color = "0xBDBDBD",
  
  bnd_player_name_fontColor = "0xFFFFFF",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = -8,
  --TeamCrest
  bnd_team_crest_width = 75,
  bnd_team_crest_height = 75,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "CENTER",
  bnd_team_crest_left = -445,
  bnd_team_crest_top = 20,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -2,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 75,
  bnd_team_crest3_height = 75,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 40,
  bnd_team_crest3_top = 20,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_width = 310,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 160,
  bnd_team_name_top = 15,
  -- coach name
  bnd_coach_name_fontSize = 20,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 105,
  bnd_coach_name_top = 165,
  -- txt coach
  bnd_text_coach = "COACH",
  bnd_text_coach_fontSize = 22,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 100,
  bnd_text_coach_top = 142,
  --TeamFormation
  bnd_team_formation_fontSize = 30,
  bnd_team_formation_fontColor = "0xFFFFFF",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = -300,
  bnd_team_formation_top = 75,
  --Subt
  bnd_cadangan_scaleX = 1.1,
  bnd_cadangan_scaleY = 1.1,
  bnd_posisi_sub_left = -420,
  bnd_posisi_sub_top = -140,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 0,
  bnd_text_sub_fontColor = "0x151515",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 20,
  bnd_playersub_fontColor = "0x151515",
  bnd_playergksub_fontColor = "0x151515",
  -- number subt
  bnd_player_number_sub_right = 40,
  bnd_player_number_sub_fontColor = "0xFFFFFF",
  --Coach/Manager
  bnd_team_crest2_width = 0.00001,
  bnd_team_crest2_height = 0.00001,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 135,
  bnd_team_crest2_bottom = 6,
  --Logo
  bnd_logo = {
    name = "$LeagueLogox",
    id = "53_2"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 22,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 10,
  bnd_logo_right = 100,
  bnd_logo_bottom = 0
}
  
LaligaHypermotionInfo = {
  bnd_forceCaps = true,
  bnd_team_crest3_show = false,
  bnd_fontFace = "$LaLiga",
  bnd_fontFace_player_number_sub = "$LaLiga",
  bnd_field_width = 1070,
  bnd_field_height = 500,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field_alpha = 1,
  bnd_field = {
    name = "$Starting11",
    id = 54
  },
  bnd_card_width = 120,
  bnd_card_height = 120,
  bnd_card_left = 0,
  bnd_card_top = 0,
  bnd_card_alpha = 1,
  bnd_card = {
    name = "$Card",
    id = 54
  },
  --card team
  bnd_card_team_width = 0.0001,
  bnd_card_team_height = 0.0001,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 0,
  --FormasiPemain
  bnd_formation_scaleX = 0.8,
  bnd_formation_scaleY = 0.8,
  bnd_formation_left = 170,
  bnd_formation_top = 25,
  
  bnd_bg_number_color = "0x000000",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0xFFFFFF",
  bnd_player_number_fontSize = 0.00000001,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 0,
  bnd_player_number_top = 0,
  
  bnd_bg_name_alpha = 0,
  bnd_bg_name_color = "0xBDBDBD",
  
  bnd_player_name_fontColor = "0xFFFFFF",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = -8,
  --TeamCrest
  bnd_team_crest_width = 75,
  bnd_team_crest_height = 75,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 40,
  bnd_team_crest_top = 20,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -2,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 75,
  bnd_team_crest3_height = 75,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 40,
  bnd_team_crest3_top = 20,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_width = 310,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 160,
  bnd_team_name_top = 15,
  -- coach name
  bnd_coach_name_fontSize = 20,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 105,
  bnd_coach_name_top = 165,
  -- txt coach
  bnd_text_coach = "COACH",
  bnd_text_coach_fontSize = 22,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 100,
  bnd_text_coach_top = 142,
  --TeamFormation
  bnd_team_formation_fontSize = 30,
  bnd_team_formation_fontColor = "0xFFFFFF",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = -300,
  bnd_team_formation_top = 75,
  --Subt
  bnd_cadangan_scaleX = 1.1,
  bnd_cadangan_scaleY = 1.1,
  bnd_posisi_sub_left = -420,
  bnd_posisi_sub_top = -140,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 0,
  bnd_text_sub_fontColor = "0x04D4D4",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 20,
  bnd_playersub_fontColor = "0x04D4D4",
  bnd_playergksub_fontColor = "0x04D4D4",
  -- number subt
  bnd_player_number_sub_right = 40,
  bnd_player_number_sub_fontColor = "0xFFFFFF",
  --Coach/Manager
  bnd_team_crest2_width = 0.00001,
  bnd_team_crest2_height = 0.00001,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 135,
  bnd_team_crest2_bottom = 6,
  --Logo
  bnd_logo = {
    name = "$LeagueLogox",
    id = "54_2"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 22,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 10,
  bnd_logo_right = 100,
  bnd_logo_bottom = 0
}
 
BUNDESLIGAInfo = {
  bnd_forceCaps = true,
  bnd_team_crest3_show = true,
  bnd_forceCaps = true,
  bnd_fontFace = "$Bundesliga",
  bnd_fontFace_player_number_sub = "$Bundesliga",
  bnd_field_width = 1540,
  bnd_field_height = 758,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$Starting11",
    id = 19
  },
  bnd_field_alpha = 1,
  -- card
  bnd_card_width = 90,
  bnd_card_height = 90,
  bnd_card_left = 0,
  bnd_card_top = 0,
  bnd_card_alpha = 1,
  bnd_card = {
    name = "$Cardx",
    id = 19
  },
  -- rect team
  bnd_TeamRect_cornerRaduis = 0,
  bnd_TeamRect_top = -170,
  bnd_TeamRect_left = 370,
  bnd_TeamRect_height = 120,
  bnd_TeamRect_width = 280,
  --card team
  bnd_card_team_width = 90,
  bnd_card_team_height = 90,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 1,
  --FormasiPemain
  bnd_formation_scaleX = 1,
  bnd_formation_scaleY = 1,
  bnd_formation_left = -140,
  bnd_formation_top = -7,
  
  bnd_bg_number_color = "0x2D2D2D",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0xFFFFFF",
  bnd_player_number_fontSize = 20,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 49,
  bnd_player_number_top = -2,
  
  bnd_bg_name_alpha = 0,
  bnd_bg_name_color = "0xf5f5f5",
  
  bnd_player_name_fontColor = "0xFFFFFF",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = 20,
  --TeamCrest
  bnd_team_crest_width = 85,
  bnd_team_crest_height = 85,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 30,
  bnd_team_crest_right = 200,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -2,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 0.0001,
  bnd_team_crest3_height = 0.00001,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 7,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_width = 140,
  bnd_team_name_fontSize = 24,
  bnd_team_name_fontColor = "0x000000",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "CENTER",
  bnd_team_name_left = 410,
  bnd_team_name_top = 50,
  -- coach name
  bnd_coach_name_fontSize = 20,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 775,
  bnd_coach_name_top = 225,
  -- txt coach
  bnd_text_coach = "COACH",
  bnd_text_coach_fontSize = 22,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 770,
  bnd_text_coach_top = 202,
  --TeamFormation
  bnd_team_formation_fontSize = 18,
  bnd_team_formation_fontColor = "0x000000",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 390,
  bnd_team_formation_top = 90,
  --Subt
  bnd_cadangan_scaleX = 1.1,
  bnd_cadangan_scaleY = 1.1,
  bnd_posisi_sub_left = 280,
  bnd_posisi_sub_top = -100,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xf5f5f5",
  bnd_text_sub_left = -40,
  bnd_text_sub_top = 0,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x000000",
  bnd_playergksub_fontColor = "0x2D2D2D",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0x000000",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 135,
  bnd_team_crest2_bottom = 6,
  --Logo
  bnd_logo = {
    name = "$ScoreBoardx",
    id = 19
  },
  bnd_logo_width = 235,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_left = 30,
  bnd_logo_top = 10,
  bnd_logo_right = 0,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -420,
  bnd_title_top = 0,
  bnd_text_title = "BUNDESLIGA",
  bnd_text_title_fontSize = 30,
  bnd_text_title_fontColor = "0xffffff",
  bnd_text_title_left = 0,
  bnd_text_title_top = -211
}

LIGUE1Info = {
  bnd_forceCaps = true,
  bnd_team_crest3_show = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$Ligue1", 
  bnd_fontFace_player_number_sub = "$Ligue1",
  bnd_field_width = 1200,
  bnd_field_height = 600,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$Starting11",
    id = 16
  },
  bnd_field_alpha = 1,
  -- card
  bnd_card_width = 120,
  bnd_card_height = 120,
  bnd_card_left = 0,
  bnd_card_top = 0,
  bnd_card_alpha = 1,
  bnd_card = {
    name = "$Card",
    id = 16
  },
  --card team
  bnd_card_team_width = 0.0001,
  bnd_card_team_height = 0.0001,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 0,
  --FormasiPemain
  bnd_formation_scaleX = 0.8,
  bnd_formation_scaleY = 0.8,
  bnd_formation_left = -110,
  bnd_formation_top = 20,
  
  bnd_bg_number_color = "0x292B2A",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0xFFFFFF",
  bnd_player_number_fontSize = 20,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 70,
  bnd_player_number_top = -60,
  
  bnd_bg_name_alpha = 0,
  bnd_bg_name_color = "0xFFFFFF",
  
  bnd_player_name_fontColor = "0xFFFFFF",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = 12,
  --TeamCrest
  bnd_team_crest_width = 47,
  bnd_team_crest_height = 47,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "CENTER",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = 20,
  bnd_team_crest_right = 150,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = 18,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 75,
  bnd_team_crest3_height = 75,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 7,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_width = 180,
  bnd_team_name_fontSize = 25,
  bnd_team_name_fontColor = "0xFFFFFF",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 420,
  bnd_team_name_top = 30,
  -- coach name
  bnd_coach_name_fontSize = 18,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 775,
  bnd_coach_name_top = 180,
  -- txt coach
  bnd_text_coach = "COACH",
  bnd_text_coach_fontSize = 22,
  bnd_text_coach_fontColor = "0x2D2D2D",
  bnd_text_coach_left = 770,
  bnd_text_coach_top = 150,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0x000000",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "CENTER",
  bnd_team_formation_left = 345,
  bnd_team_formation_top = 35,
  --Subt
  bnd_cadangan_scaleX = 0.9,
  bnd_cadangan_scaleY = 0.9,
  bnd_posisi_sub_left = 290,
  bnd_posisi_sub_top = -130,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0x2D2D2D",
  bnd_text_sub_left = -40,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0xFFFFFF",
  --Coach/Manager
  bnd_team_crest2_width = 0.0001,
  bnd_team_crest2_height = 0.0001,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 48,
  bnd_team_crest2_bottom = -10,
  --Logo
  bnd_logo = {
    name = "$LeagueLogoX",
    id = "0"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 22,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 10,
  bnd_logo_right = 100,
  bnd_logo_bottom = 0
}

SERIEAInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Seria_Bold", 
  bnd_fontFace_player_number_sub = "$Seria_Bold",
  bnd_field_width = 1430,
  bnd_field_height = 660,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$Starting11",
    id = 31
  },
  bnd_field_alpha = 1,
  -- card
  bnd_card_width = 120,
  bnd_card_height = 100,
  bnd_card_left = 0,
  bnd_card_top = -5,
  bnd_card_alpha = 1,
  bnd_card = {
    name = "$Card",
    id = 31
  },
  --card team
  bnd_card_team_width = 0.0001,
  bnd_card_team_height = 0.0001,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 0,
  --FormasiPemain
  bnd_formation_scaleX = 1.2,
  bnd_formation_scaleY = 1.2,
  bnd_formation_left = -185,
  bnd_formation_top = 25,
  
  bnd_bg_number_color = "0x151C87",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0x04D4D4",
  bnd_player_number_fontSize = 20,
  bnd_player_number_alignV = "TOP",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 47,
  bnd_player_number_top = -20,
  
  bnd_bg_name_alpha = 0,
  bnd_bg_name_color = "0x2100C9",
  
  bnd_player_name_fontColor = "0xFFFFFF",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -37,
  bnd_player_name_top = -12,
  --TeamCrest
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 0,
  bnd_team_crest_top = -50,
  bnd_team_crest_right = 80,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 55,
  bnd_player_avatar_height = 55,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -15,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 0.00001,
  bnd_team_crest3_height = 0.0001,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 700000,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_width = 310,
  bnd_team_name_fontSize = 0,
  bnd_team_name_fontColor = "0x38003D",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = -100,
  bnd_team_name_top = -50,
  -- coach name
  bnd_coach_name_fontSize = 18,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 925,
  bnd_coach_name_top = 190,
  -- txt coach
  bnd_text_coach = "MANAGER",
  bnd_text_coach_fontSize = 22,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 920,
  bnd_text_coach_top = 160,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 895,
  bnd_team_formation_top = 60,
  --Subt
  bnd_posisi_sub_left = 420,
  bnd_posisi_sub_top = -130,
  bnd_cadangan_scaleX = 1,
  bnd_cadangan_scaleY = 1,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xF5F5F5",
  bnd_text_sub_left = -40,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 18,
  bnd_playersub_fontColor = "0xF5F5F5",
  bnd_playergksub_fontColor = "0xF5F5F5",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0xF5F5F5",
  --Coach/Manager
  bnd_team_crest2_width = 0.00001,
  bnd_team_crest2_height = 0.00001,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = -90,
  bnd_team_crest2_bottom = -100,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 31
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_left = -100,
  bnd_logo_top = -55,
  bnd_logo_right = 0,
  bnd_logo_bottom = 0
}

UCLInfo = {
  bnd_forceCaps = true,
  bnd_team_crest3_show = false,
  bnd_fontFace = "$UCL-Regular",
  bnd_fontFace_player_number_sub = "$UCL-Regular",
  bnd_field_width = 1150,
  bnd_field_height = 600,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$Starting11",
    id = 2236
  },
  bnd_field_alpha = 1,
  -- card
  bnd_card_width = 120,
  bnd_card_height = 120,
  bnd_card_left = 0,
  bnd_card_top = -10,
  bnd_card_alpha = 1,
  bnd_card = {
    name = "$Cardx",
    id = 0
  },
  --card team
  bnd_card_team_width = 0.0001,
  bnd_card_team_height = 0.0001,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 0,
  --FormasiPemain
  bnd_formation_scaleX = 0.8,
  bnd_formation_scaleY = 0.8,
  bnd_formation_left = 150,
  bnd_formation_top = 70,
  
  bnd_bg_number_color = "0x091C94",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0xFFFFFF",
  bnd_player_number_fontSize = 20,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = -5,
  bnd_player_number_top = 5,
  
  bnd_bg_name_alpha = 0,
  bnd_bg_name_color = "0x091C94",
  
  bnd_player_name_fontColor = "0xFFFFFF",
  bnd_player_name_fontSize = 20,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = -8,
  --TeamCrest
  bnd_team_crest_width = 47,
  bnd_team_crest_height = 47,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "CENTER",
  bnd_team_crest_left = 60,
  bnd_team_crest_top = 20,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 80,
  bnd_team_kits_height = 80,
  bnd_team_kits_alignV = "TOP",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = -15,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 1,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -2,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 0,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 75,
  bnd_team_crest3_height = 75,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 7,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_width = 180,
  bnd_team_name_fontSize = 25,
  bnd_team_name_fontColor = "0xFFFFFF",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 630,
  bnd_team_name_top = 30,
  -- coach name
  bnd_coach_name_fontSize = 22,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 90,
  bnd_coach_name_top = 180,
  -- txt coach
  bnd_text_coach = "Coach",
  bnd_text_coach_fontSize = 20,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 90,
  bnd_text_coach_top = 150,
  --TeamFormation
  bnd_team_formation_fontSize = 25,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 630,
  bnd_team_formation_top = 60,
  --Subt
  bnd_cadangan_scaleX = 1.1,
  bnd_cadangan_scaleY = 1.1,
  bnd_posisi_sub_left = -400,
  bnd_posisi_sub_top = -130,
  bnd_text_sub = "SUBSTITUTES",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = -40,
  bnd_text_sub_top = 0,
  bnd_playersub_fontSize = 19,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0xFFFFFF",
  --Coach/Manager
  bnd_team_crest2_width = 0.00001,
  bnd_team_crest2_height = 0.00001,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 0,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 90,
  bnd_team_crest2_bottom = -10,
  --Logo
  bnd_logo = {
    name = "$LeagueLogoX",
    id = "0"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 22,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 10,
  bnd_logo_right = 100,
  bnd_logo_bottom = 0
}

BRISuperLeagueinfo = { 
  bnd_forceCaps = true,
  bnd_forceCaps = true, 
  bnd_fontFace = "$Liga1",
  bnd_fontFace_player_number_sub = "$Liga1",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 20,
  bnd_field = {
    name = "$Starting11",
    id = 2235
  },
  bnd_field_alpha = 1,
  bnd_TeamRect_cornerRaduis = 30,
  bnd_TeamRect_height = 565,
  bnd_TeamRect_top = 19,
  bnd_TeamRect_left = 370,
  bnd_TeamRect_width = 455,
  -- card
  bnd_card_width = 120,
  bnd_card_height = 120,
  bnd_card_left = 0,
  bnd_card_top = -10,
  bnd_card_alpha = 1,
  bnd_card = {
    name = "$Cardx",
    id = 2235
  },
  --card team
  bnd_card_team_width = 130,
  bnd_card_team_height = 120,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 1,
  --FormasiPemain
  bnd_formation_scaleX = 1,
  bnd_formation_scaleY = 1,
  bnd_formation_left = -220,
  bnd_formation_top = 40,
  
  bnd_bg_number_color = "0xffffff",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0x163582",
  bnd_player_number_fontSize = 20,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 25,
  bnd_player_number_top = -65,
  
  bnd_bg_name_alpha = 0,
  bnd_bg_name_color = "0x00519D",
  
  bnd_player_name_fontColor = "0x163582",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = 0,
  --TeamCrest
  bnd_team_crest_width = 0.00001,
  bnd_team_crest_height = 0.00001,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 188,
  bnd_team_crest_top = 45,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = 10,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 0.00001,
  bnd_team_crest3_height = 0.0001,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 700000,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 0.0000001,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 310,
  bnd_team_name_top = 63,
  -- coach name
  bnd_coach_name_fontSize = 20,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 790,
  bnd_coach_name_top = 220,
  -- txt coach
  bnd_text_coach = "HEAD COACH",
  bnd_text_coach_fontSize = 22,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 790,
  bnd_text_coach_top = 180,
  --TeamFormation
  bnd_team_formation_fontSize = 23,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "CENTER",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 540,
  bnd_team_formation_top = 260,
  --Subt
  bnd_posisi_sub_left = 250,
  bnd_posisi_sub_top = -170,
  bnd_cadangan_scaleX = 1.3,
  bnd_cadangan_scaleY = 1.3,
  bnd_text_sub = "SUBTITUTES",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = -30,
  bnd_text_sub_top = 0,
  bnd_playersub_fontSize = 20,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0xF5F5F5",
  --Coach/Manager
  bnd_team_crest2_width = 0.00001,
  bnd_team_crest2_height = 0.00001,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = -15,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -70,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -485,
  bnd_title_top = 205,
  bnd_text_title = "",
  bnd_text_title_fontSize = 0,
  bnd_text_title_fontColor = "0xffffff",
  bnd_text_title_left = -65,
  bnd_text_title_top = 0
}

AfrikaCupInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Liga1",
  bnd_fontFace_player_number_sub = "$Liga1",
  bnd_field_width = 1430,
  bnd_field_height = 660,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$Starting11",
    id = "CupID26"
  },
  --card team
  bnd_card_team_width = 0.0001,
  bnd_card_team_height = 0.0001,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 0,
  --FormasiPemain
  bnd_formation_left = 240,
  bnd_formation_top = 20,
  
  bnd_bg_number_color = "0x860000",
  bnd_bg_number_alpha = 1,
  
  bnd_player_number_fontColor = "0xffffff",
  bnd_player_number_fontSize = 15,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 0,
  bnd_player_number_top = 0,
  
  bnd_bg_name_alpha = 1,
  bnd_bg_name_color = "0x860000",
  
  bnd_player_name_fontColor = "0xffffff",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = -8,
  --TeamCrest
  bnd_team_crest_width = 65,
  bnd_team_crest_height = 65,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 200,
  bnd_team_crest_top = 446,
  bnd_team_crest_right = 100,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -2,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 0.00001,
  bnd_team_crest3_height = 0.0001,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 700000,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 50,
  bnd_team_name_color_height = 50,
  bnd_team_name_color_left = 550,
  bnd_team_name_color_top = 0,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontSize = 35,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 440,
  bnd_team_name_top = 455,
  -- coach name
  bnd_coach_name_fontSize = 0.00001,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 790,
  bnd_coach_name_top = 220,
  -- txt coach
  bnd_text_coach = "HEAD COACH",
  bnd_text_coach_fontSize = 0.000001,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 790,
  bnd_text_coach_top = 180,
  --TeamFormation
  bnd_team_formation_fontSize = 30,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 710,
  bnd_team_formation_top = 460,
  --Subt
  bnd_posisi_sub_left = -440,
  bnd_posisi_sub_top = -100,
  bnd_text_sub = "SUBTITUTES :",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = -20,
  bnd_text_sub_top = 0,
  bnd_playersub_fontSize = 20,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0xFFFFFF",
  --Coach/Manager
  bnd_team_crest2_width = 0,
  bnd_team_crest2_height = 0,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 60,
  bnd_team_crest2_top = -60,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -70,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -485,
  bnd_title_top = 205,
  bnd_text_title = "",
  bnd_text_title_fontSize = 20,
  bnd_text_title_fontColor = "0xffffff",
  bnd_text_title_left = -65,
  bnd_text_title_top = 0
}
EASPORTSInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Seria_Bold", 
  bnd_fontFace_player_number_sub = "$Seria_Bold",
  bnd_field_width = 1430,
  bnd_field_height = 660,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$Starting11",
    id = "CupID14"
  },
  bnd_field_alpha = 1,
  --FormasiPemain
  bnd_formation_scaleX = 1.2,
  bnd_formation_scaleY = 1.2,
  bnd_formation_left = 0,
  bnd_formation_top = 50,
  
  bnd_bg_number_color = "0x080838",
  bnd_bg_number_alpha = 1,
  
  bnd_player_number_fontColor = "0xDFFF00",
  bnd_player_number_fontSize = 15,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 0,
  bnd_player_number_top = 0,
  
  bnd_bg_name_alpha = 1,
  bnd_bg_name_color = "0x080838",
  
  bnd_player_name_fontColor = "0xDFFF00",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = -8,
  --TeamCrest
  bnd_team_crest_width = 80,
  bnd_team_crest_height = 80,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "RIGHT",
  bnd_team_crest_left = 80,
  bnd_team_crest_top = -50,
  bnd_team_crest_right = 880,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -2,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 75,
  bnd_team_crest3_height = 75,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 700000,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_width = 310,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xFFDE21",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 210,
  bnd_team_name_top = 0,
  -- coach name
  bnd_coach_name_fontSize = 0.00001,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 790,
  bnd_coach_name_top = 220,
  -- txt coach
  bnd_text_coach = "HEAD COACH",
  bnd_text_coach_fontSize = 0.000001,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 790,
  bnd_text_coach_top = 180,
  --TeamFormation
  bnd_team_formation_fontSize = 30,
  bnd_team_formation_fontColor = "0x080838",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 230,
  bnd_team_formation_top = -55,
  --Subt
  bnd_posisi_sub_left = 400,
  bnd_posisi_sub_top = -1300000000,
  bnd_text_sub = "SUBTITUTION",
  bnd_text_sub_fontSize = 20,
  bnd_text_sub_fontColor = "0xF5F5F5",
  bnd_text_sub_left = 10000000000,
  bnd_text_sub_top = 10,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xF5F5F5",
  bnd_playergksub_fontColor = "0xF5F5F5",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0xF5F5F5",
  --Coach/Manager
  bnd_team_crest2_width = 250,
  bnd_team_crest2_height = 250,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "RIGHT",
  bnd_team_crest2_left = 10000000,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = -9000000,
  bnd_team_crest2_bottom = -100,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo",
    id = 11
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "LEFT",
  bnd_logo_left = -1000000000,
  bnd_logo_top = -55,
  bnd_logo_right = 0,
  bnd_logo_bottom = 0
}
ChampionshipLiga2Info = { 
  bnd_forceCaps = true, 
  bnd_fontFace = "$Liga1",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 20,
  bnd_field = {
    name = "$Starting11",
    id = 2254
  },
  -- card
  bnd_card_width = 130,
  bnd_card_height = 130,
  bnd_card_left = 0,
  bnd_card_top = -5,
  bnd_card_alpha = 1,
  bnd_card = {
    name = "$Card",
    id = 2254
  },
  --card team
  bnd_card_team_width = 0.0001,
  bnd_card_team_height = 0.0001,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 0,
  --FormasiPemain
  bnd_formation_left = 130,
  bnd_formation_top = 38,
  
  bnd_bg_number_color = "0xAEDE26",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0x09533A",
  bnd_player_number_fontSize = 20,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 15,
  bnd_player_number_top = -70,
  
  bnd_bg_name_alpha = 0,
  bnd_bg_name_color = "0x09533A",
  
  bnd_player_name_fontColor = "0x09533A",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = -11,
  --TeamCrest
  bnd_team_crest_width = 90,
  bnd_team_crest_height = 90,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 188,
  bnd_team_crest_top = 45,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -2,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 0.00001,
  bnd_team_crest3_height = 0.0001,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 700000,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -150,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 25,
  bnd_team_name_fontColor = "0xAEDE26",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 310,
  bnd_team_name_top = 63,
  -- coach name
  bnd_coach_name_fontSize = 0.00001,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 790,
  bnd_coach_name_top = 220,
  -- txt coach
  bnd_text_coach = "HEAD COACH",
  bnd_text_coach_fontSize = 0.000001,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 790,
  bnd_text_coach_top = 180,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xAEDE26",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 310,
  bnd_team_formation_top = 90,
  --Subt
  bnd_posisi_sub_left = -550,
  bnd_posisi_sub_top = -100,
  bnd_text_sub = "SUBTITUTES :",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0x09533A",
  bnd_text_sub_left = 0,
  bnd_text_sub_top = -40,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0x09533A",
  bnd_playergksub_fontColor = "0x09533A",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0x09533A",
  --Coach/Manager
  bnd_team_crest2_width = 180,
  bnd_team_crest2_height = 180,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = -15,
  bnd_team_crest2_top = 0,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -70,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -485,
  bnd_title_top = 205,
  bnd_text_title = "",
  bnd_text_title_fontSize = 0,
  bnd_text_title_fontColor = "0xffffff",
  bnd_text_title_left = -65,
  bnd_text_title_top = 0
}
-- Starting11 Tournaments --
AseanChampionshipInfo = {
  bnd_forceCaps = true,
  bnd_fontFace = "$Liga1",
  bnd_fontFace_player_number_sub = "$Liga1",
  bnd_field_width = 1200,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 20,
  bnd_field = {
    name = "$Starting11",
    id = "CupID27"
  },
  --card team
  bnd_card_team_width = 0.0001,
  bnd_card_team_height = 0.0001,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 0,
  --FormasiPemain
  bnd_formation_left = 117,
  bnd_formation_top = 38,
  
  bnd_bg_number_color = "0xffffff",
  bnd_bg_number_alpha = 1,
  
  bnd_player_number_fontColor = "0xc82727",
  bnd_player_number_fontSize = 15,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 0,
  bnd_player_number_top = 0,
  
  bnd_bg_name_alpha = 1,
  bnd_bg_name_color = "0xc82727",
  
  bnd_player_name_fontColor = "0xffffff",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = -8,
  --TeamCrest
  bnd_team_crest_width = 70,
  bnd_team_crest_height = 70,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "CENTER",
  bnd_team_crest_left = -200,
  bnd_team_crest_top = 70,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "TOP",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 0,
  bnd_player_avatar_top = -2,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 75,
  bnd_team_crest3_height = 75,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 90,
  bnd_team_crest3_top = 700000,
  bnd_team_crest3_right = 0,
  bnd_team_crest3_bottom = 0,
  --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 0,
  bnd_team_name_color_height = 0,
  bnd_team_name_color_left = -15000000,
  bnd_team_name_color_top = -30,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontSize = 20,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 20000000,
  bnd_team_name_top = 125,
  -- coach name
  bnd_coach_name_fontSize = 18,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 30,
  bnd_coach_name_top = -70,
  -- txt coach
  bnd_text_coach = "HEAD COACH",
  bnd_text_coach_fontSize = 16,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 30,
  bnd_text_coach_top = -100,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 31000000000,
  bnd_team_formation_top = 75,
  --Subt
  bnd_posisi_sub_left = -450,
  bnd_posisi_sub_top = -30,
  bnd_text_sub = "SUBTITUTES",
  bnd_text_sub_fontSize = 18,
  bnd_text_sub_fontColor = "0xffffff",
  bnd_text_sub_left = -40,
  bnd_text_sub_top = 0,
  bnd_playersub_fontSize = 16,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  -- number subt
  bnd_player_number_sub_right = 20,
  bnd_player_number_sub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 150,
  bnd_team_crest2_height = 150,
  bnd_team_crest2_alignV = "BOTTOM",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 6000000000,
  bnd_team_crest2_top = -60,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = -70,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = 2235
  },
  bnd_logo_width = 80,
  bnd_logo_height = 80,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 30,
  bnd_logo_right = 60,
  bnd_logo_bottom = 0,
  -- title
  bnd_title_left = -485,
  bnd_title_top = 205,
  bnd_text_title = "",
  bnd_text_title_fontSize = 20,
  bnd_text_title_fontColor = "0xffffff",
  bnd_text_title_left = -65,
  bnd_text_title_top = 0
}

WC26Info = {
  bnd_team_crest3_show = false,
  bnd_forceCaps = true,
  bnd_fontFace = "$CruyffSansMedium",
  bnd_fontFace_player_number_sub = "$Liga1",
  bnd_field_width = 1150,
  bnd_field_height = 566,
  bnd_field_left = 0,
  bnd_field_top = 0,
  bnd_field = {
    name = "$Starting11",
    id = "CupID2"
  },
  bnd_field_alpha = 0.9,
  
  bnd_TeamRect_cornerRaduis = 30,
  bnd_TeamRect_height = 650,
  bnd_TeamRect_top = 2,
  bnd_TeamRect_left = 0.0001,
  bnd_TeamRect_width = 0.0001,
  
  bnd_card_width = 85,
  bnd_card_height = 95,
  bnd_card_left = 0,
  bnd_card_top = 0,
  bnd_card_alpha = 1,
  bnd_card = {
    name = "$Cardx",
    id = "CupID2"
  },
  --card team
  bnd_card_team_width = 0000.1,
  bnd_card_team_height = 0000.1,
  bnd_card_team_left = 0,
  bnd_card_team_top = 0,
  bnd_card_team_alpha = 1,
  --FormasiPemain
  bnd_formation_scaleX = 0.8,
  bnd_formation_scaleY = 0.8,
  bnd_formation_left = 115,
  bnd_formation_top = 5,
  
  bnd_bg_number_color = "0x05F280",
  bnd_bg_number_alpha = 0,
  
  bnd_player_number_fontColor = "0xffffff",
  bnd_player_number_fontSize = 21,
  bnd_player_number_alignV = "CENTER",
  bnd_player_number_alignH = "CENTER",
  bnd_player_number_left = 20,
  bnd_player_number_top = -22,
  
  bnd_bg_name_alpha = 1,
  bnd_bg_name_color = "0x083C65",
  
  bnd_player_name_fontColor = "0xffffff",
  bnd_player_name_fontSize = 15,
  bnd_player_name_alignV = "CENTER",
  bnd_player_name_alignH = "CENTER",
  bnd_player_name_left = -35,
  bnd_player_name_top = -7,
   --TeamCrest
  bnd_team_crest_width = 65,
  bnd_team_crest_height = 65,
  bnd_team_crest_alignV = "TOP",
  bnd_team_crest_alignH = "LEFT",
  bnd_team_crest_left = 400,
  bnd_team_crest_top = -24,
  bnd_team_crest_right = 0,
  bnd_team_crest_bottom = 0,
  
  bnd_team_kits_width = 60,
  bnd_team_kits_height = 60,
  bnd_team_kits_alignV = "CENTER",
  bnd_team_kits_alignH = "CENTER",
  bnd_team_kits_left = 0,
  bnd_team_kits_top = 0,
  bnd_team_kits_right = 0,
  bnd_team_kits_bottom = 0,
  bnd_team_kits_alpha = 0,
  
  bnd_player_avatar_width = 60,
  bnd_player_avatar_height = 60,
  bnd_player_avatar_alignV = "CENTER",
  bnd_player_avatar_alignH = "CENTER",
  bnd_player_avatar_left = 20,
  bnd_player_avatar_top = -10,
  bnd_player_avatar_right = 0,
  bnd_player_avatar_bottom = 0,
  bnd_player_avatar_alpha = 1,
  
  bnd_country_player_width = 25,
  bnd_country_player_height = 25,
  bnd_country_player_left = -40,
  bnd_country_player_top = 20,
  bnd_country_player_alpha = 0,
  
  bnd_team_crest3_width = 70,
  bnd_team_crest3_height = 70,
  bnd_team_crest3_alignV = "TOP",
  bnd_team_crest3_alignH = "LEFT",
  bnd_team_crest3_left = 350,
  bnd_team_crest3_top = -20,
  bnd_team_crest3_right = 50,
  bnd_team_crest3_bottom = 0,
  
  bnd_team_crest4_width = 130,
  bnd_team_crest4_height = 130,
  bnd_team_crest4_alignV = "TOP",
  bnd_team_crest4_alignH = "LEFT",
  bnd_team_crest4_left = 400,
  bnd_team_crest4_top = -20,
  bnd_team_crest4_right = 300,
  bnd_team_crest4_bottom = 0,
 --TeamName
  bnd_team_name_color = "",
  bnd_team_name_color_width = 50,
  bnd_team_name_color_height = 50,
  bnd_team_name_color_left = 550,
  bnd_team_name_color_top = 0,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontSize = 30,
  bnd_team_name_fontColor = "0xffffff",
  bnd_team_name_alignV = "TOP",
  bnd_team_name_alignH = "LEFT",
  bnd_team_name_left = 520,
  bnd_team_name_top = -5,
  -- coach name
  bnd_coach_name_fontSize = 0.00001,
  bnd_coach_name_fontColor = "0xFFFFFF",
  bnd_coach_name_alignV = "CENTER",
  bnd_coach_name_alignH = "LEFT",
  bnd_coach_name_left = 790,
  bnd_coach_name_top = 220,
  -- txt coach
  bnd_text_coach = "HEAD COACH",
  bnd_text_coach_fontSize = 0.000001,
  bnd_text_coach_fontColor = "0xffffff",
  bnd_text_coach_left = 790,
  bnd_text_coach_top = 180,
  --TeamFormation
  bnd_team_formation_fontSize = 20,
  bnd_team_formation_fontColor = "0xffffff",
  bnd_team_formation_alignV = "TOP",
  bnd_team_formation_alignH = "LEFT",
  bnd_team_formation_left = 880,
  bnd_team_formation_top = -2,
  --Subt
  bnd_posisi_sub_left = -430,
  bnd_posisi_sub_top = -160,
  bnd_text_sub = "SUBTITUTES :",
  bnd_text_sub_fontSize = 25,
  bnd_text_sub_fontColor = "0x06E7E0",
  bnd_text_sub_left = -20,
  bnd_text_sub_top = 0,
  bnd_playersub_fontSize = 15,
  bnd_playersub_fontColor = "0xffffff",
  bnd_playergksub_fontColor = "0xffffff",
  -- number subt
  bnd_player_number_sub_right = 5,
  bnd_player_number_sub_fontColor = "0xffffff",
  --Coach/Manager
  bnd_team_crest2_width = 180,
  bnd_team_crest2_height = 180,
  bnd_team_crest2_alignV = "TOP",
  bnd_team_crest2_alignH = "LEFT",
  bnd_team_crest2_left = 765000000,
  bnd_team_crest2_top = 90,
  bnd_team_crest2_right = 0,
  bnd_team_crest2_bottom = 0,
  --Logo
  bnd_logo = {
    name = "$LeagueLogo1",
    id = "53_2"
  },
  bnd_logo_width = 100,
  bnd_logo_height = 22,
  bnd_logo_alignV = "TOP",
  bnd_logo_alignH = "RIGHT",
  bnd_logo_left = 0,
  bnd_logo_top = 10,
  bnd_logo_right = 100,
  bnd_logo_bottom = 0,
    -- title
  bnd_title_left = -420,
  bnd_title_top = 0,
  bnd_text_title = "Coach",
  bnd_text_title_fontSize = 20,
  bnd_text_title_fontColor = "0x000000",
  bnd_text_title_left = 660,
  bnd_text_title_top = -130
}

-- Finish

function Starting11:new(init)
  print("[Starting11]: new()")
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    TacticsService = o.api("TacticsService"),
    SquadManagementService = o.api("SquadMgtService"),
    eventManService = o.api("EventManagerService"),
    MatchInfoService = o.api("MatchInfoService"),
    OverlayService = o.api("OverlayService"),
    TeamService = o.api("TeamService")
  }
  o.TeamsData = o.services.MatchInfoService.GetMatchTeams()
  o.handlerId = o.services.eventManService.RegisterHandler(function(...)
  o:handleEvent(...) end)
  
  local currentdata = nil
  
  local PremierLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.PremierLeague, 0, 0, true)
  local Ligue1Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue1, 0, 0, true)
  local Ligue2Teams = o.services.TeamService.GetTeams(leagueIDs.Ligue2, 0, 0, true)
  local BundesligaTeams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga, 0, 0, true)
  local Bundesliga2Teams = o.services.TeamService.GetTeams(leagueIDs.Bundesliga2, 0, 0, true)
  local SerieATeams = o.services.TeamService.GetTeams(leagueIDs.SerieA, 0, 0, true)
  local SerieBTeams = o.services.TeamService.GetTeams(leagueIDs.SerieB, 0, 0, true)
  local LaligaTeams = o.services.TeamService.GetTeams(leagueIDs.Laliga, 0, 0, true)
  local LaligaHypermotionTeams = o.services.TeamService.GetTeams(leagueIDs.LaligaHypermotion, 0, 0, true)
  local BRISuperLeagueTeams = o.services.TeamService.GetTeams(leagueIDs.BRILiga1, 0, 0, true)
  local  ChampionshipLiga2Teams= o.services.TeamService.GetTeams(leagueIDs.ChampionshipLiga2, 0, 0, true)
  
-- Cup Data
if currentCupData and currentCupData.cupIndex and currentCupData.cupIndex > 0 then
  if currentCupData.cupIndex == 1 then
    currentdata = UCLInfo
    
  elseif currentCupData.cupIndex >= 2 and currentCupData.cupIndex <= 34 then
    currentdata = EAFCInfo
  elseif currentCupData.cupIndex >= 16 and currentCupData.cupIndex <= 34 then
    currentdata = EAFCInfo
  else
    currentdata = EAFCInfo
  end

   elseif currentTourData and currentTourData.tourIndex and currentTourData.tourIndex > 0 then
    if currentTourData.tourIndex == 1 then
    currentdata = UCLInfo
  elseif currentTourData.tourIndex >= 35 then
    currentdata = UCLInfo
  elseif currentTourData.tourIndex >= 34 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 33 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 32 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 31 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 30 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 29 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 28 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 27 then
    currentdata = AseanChampionshipInfo
  elseif currentTourData.tourIndex >= 26 then
    currentdata = AfrikaCupInfo
  elseif currentTourData.tourIndex >= 25 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 24 then
    currentdata = EAFCInfo    -- ✔ SEKARANG TERBACA
  elseif currentTourData.tourIndex >= 23 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 22 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 21 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 20 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 19 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 18 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 17 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 16 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 15 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 14 then
    currentdata = EASPORTSInfo
  elseif currentTourData.tourIndex >= 13 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 12 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 11 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 10 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 9 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 8 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 7 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 6 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 5 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 4 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 3 then
    currentdata = EAFCInfo
  elseif currentTourData.tourIndex >= 2 then
    currentdata = WC26Info
  elseif currentTourData.tourIndex >= 2 and currentTourData.tourIndex <= 34 then
    currentdata = EAFCInfo
else
    currentdata = EAFCInfo
end
-- League / Friendly
else
  if o:isInTable(o.TeamsData[1], PremierLeagueTeams) and o:isInTable(o.TeamsData[2], PremierLeagueTeams) then
    currentdata = PremierLeagueInfo
    o.currentLeague = "PremierLeagueTeamsData"
    elseif o:isInTable(o.TeamsData[1], Ligue1Teams) and o:isInTable(o.TeamsData[2], Ligue1Teams) then
      currentdata = LIGUE1Info
    elseif o:isInTable(o.TeamsData[1], Ligue2Teams) and o:isInTable(o.TeamsData[2], Ligue2Teams) then
      currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], BundesligaTeams) and o:isInTable(o.TeamsData[2], BundesligaTeams) then
      currentdata = BUNDESLIGAInfo
      o.currentLeague = "Bundesliga1TeamsData"
    elseif o:isInTable(o.TeamsData[1], Bundesliga2Teams) and o:isInTable(o.TeamsData[2], Bundesliga2Teams) then
      currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], SerieATeams) and o:isInTable(o.TeamsData[2], SerieATeams) then
    currentdata = SERIEAInfo
    elseif o:isInTable(o.TeamsData[1], SerieBTeams) and o:isInTable(o.TeamsData[2], SerieBTeams) then
      currentdata = EAFCInfo
    elseif o:isInTable(o.TeamsData[1], LaligaTeams) and o:isInTable(o.TeamsData[2], LaligaTeams) then
      currentdata = LALIGAInfo
    elseif o:isInTable(o.TeamsData[1], LaligaHypermotionTeams) and o:isInTable(o.TeamsData[2], LaligaHypermotionTeams) then
      currentdata = LaligaHypermotionInfo
    elseif o:isInTable(o.TeamsData[1], BRISuperLeagueTeams) and o:isInTable(o.TeamsData[2], BRISuperLeagueTeams) then
      currentdata = BRISuperLeagueinfo
      o.currentLeague = "BRILiga1TeamsData"
    elseif o:isInTable(o.TeamsData[1], ChampionshipLiga2Teams) and o:isInTable(o.TeamsData[2], ChampionshipLiga2Teams) then
      currentdata = ChampionshipLiga2Info
  else
    currentdata = EAFCInfo
  end
end
   
   o.currentData = currentdata

  o.gamemode = o.data.gamemode or "real"
  o.flow = o.data.flow or "offline"
  o.playerLineup = nil
  o.isActive = false
  o.isVisible = false
  o.models = {
    FormationModel = FormationModel:new({
      im = o.im,
      api = o.api,
      nav = o.nav,
      loc = o.loc,
      gamemode = o.gamemode
    })
  }
  o.bndList = {
    bnd_player1_name = "",
    bnd_player2_name = "",
    bnd_player3_name = "",
    bnd_player4_name = "",
    bnd_player5_name = "",
    bnd_player6_name = "",
    bnd_player7_name = "",
    bnd_player8_name = "",
    bnd_player9_name = "",
    bnd_player10_name = "",
    bnd_player11_name = "",
    bnd_player12_name = "",
    bnd_player13_name = "",
    bnd_player14_name = "",
    bnd_player15_name = "",
    bnd_player16_name = "",
    bnd_player17_name = "",
    bnd_player18_name = "",
    bnd_player1_number = "",
    bnd_player2_number = "",
    bnd_player3_number = "",
    bnd_player4_number = "",
    bnd_player5_number = "",
    bnd_player6_number = "",
    bnd_player7_number = "",
    bnd_player8_number = "",
    bnd_player9_number = "",
    bnd_player10_number = "",
    bnd_player11_number = "",
    bnd_player12_number = "",
    bnd_player13_number = "",
    bnd_player14_number = "",
    bnd_player15_number = "",
    bnd_player16_number = "",
    bnd_player17_number = "",
    bnd_player18_number = "",
    bnd_player1_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player2_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player3_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player4_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player5_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player6_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player7_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player8_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player9_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player10_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_player11_avatar = {
      name = "$Head",
      id = 0
    },
    bnd_country_player1 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player2 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player3 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player4 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player5 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player6 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player7 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player8 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player9 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player10 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_country_player11 = { 
      name = "$Flag128x128", 
      id = 0 
    },
    bnd_player1_bottom = 0,
    bnd_player2_bottom = 0,
    bnd_player3_bottom = 0,
    bnd_player4_bottom = 0,
    bnd_player5_bottom = 0,
    bnd_player6_bottom = 0,
    bnd_player7_bottom = 0,
    bnd_player8_bottom = 0,
    bnd_player9_bottom = 0,
    bnd_player10_bottom = 0,
    bnd_player11_bottom = 0,
    bnd_player1_left= 0,
    bnd_player2_left= 0,
    bnd_player3_left= 0,
    bnd_player4_left= 0,
    bnd_player5_left= 0,
    bnd_player6_left= 0,
    bnd_player7_left= 0,
    bnd_player8_left= 0,
    bnd_player9_left= 0,
    bnd_player10_left= 0,
    bnd_player11_left= 0
  }

  o.crest = {
    name = "$Crest",
    id = 0
  }
  o.crest2 = {
    name = "$ManagerCard",
    id = 0
  }
  o.crest3 = {
    name = "$Crest_Laliga",
    id = 0
  }
  o.kits = {
  name = "$HomeKit",
  id = 0
  }
  o.kits_gk = {
  name = "$GKKit",
  id = 0
  }
  o.card_team = {
  name = "$CardTeam",
  id = 0
  }
  o.teamRectColor = "0xFFFFFF"
  o.teamFontColor = "0xFFFFFF"

  o.formationName = ""

  o.teamName = ""
  
  o.coachName = ""

  o.im.Subscribe("bnd_active", function()
    o:_publishActivity()
  end
  )
  o.im.Subscribe("bnd_visible", function()
    o:_publishActivity()
  end
  )
  o.im.Subscribe("bnd_team_crest", function()
    o:_publishTeamCrest()
  end
  )
  o.im.Subscribe("bnd_team_crest2", function()
    o:_publishTeamCrest2()
  end
  )
  o.im.Subscribe("bnd_team_crest3", function()
    o:_publishTeamCrest3()
  end
  )
  o.im.Subscribe("bnd_team_kits", function()
  o:_publishTeamKits()
  end)
  
  o.im.Subscribe("bnd_team_kits_gk", function()
  o:_publishTeamKitsGK()
  end)
  
  o.im.Subscribe("bnd_card_team", function()
  o:_publishCardTeam()
  end)

  o.im.Subscribe("bnd_team_name", function()
    o:_publishTeamName()
  end
  )
  
  o.im.Subscribe("bnd_coach_name", function()
  o:_publishCoachName()
  end)
  
  o.im.Subscribe("bnd_team_formation", function()
    o:_publishTeamFormation()
  end
  )
  
  o.im.Subscribe("bnd_TeamRect_color", function()
  o:_publishTeamRectColor()
  end)

  for k,v in pairs(o.bndList) do
    o.im.Subscribe(k, function()
    end)
  end
  
  o.im.Subscribe("bnd_active", function()
    o:_publishActive()
  end)

  for k,v in pairs(currentdata) do
    o.im.Subscribe(k, function()
      o.im.Publish(k, v)
    end)
  end
  return o
end

function Starting11:handleEvent(eventType, data)
  if eventType == EventTypes.OverlayTypeIntroSequenceTeamList then
    self:updatePlayerLineup(data.subtype, data.hideshow, data.subtypestr, data.msg)
  end
end

function Starting11:updatePlayerLineup(subtype, hideshow, subtypestr, msg)
  print("[Starting11]: updatePlayerLineup(subtype = " .. tostring(subtype) .. ", hideshow = " .. tostring(hideshow) .. ", subtypestr = " .. tostring(subtypestr) .. ", msg = " .. tostring(msg) .. ")")
  
  if hideshow ~= "HIDE" then
    self.isActive = true
    self.isVisible = true
    
    local params = OverlayParam.split(msg, "|")
    
    if params and table.getn(params) > 0 then
      local teamSide = tonumber(params[5])
      local teamID = tonumber(params[3])
      
      local playerColor = self:getPlayerNameColor(teamID, teamSide)

      self.im.Publish("bnd_player_", playerColor)

      if self.currentData and self.currentData.bnd_player_number_fontColor then
        self.im.Publish("bnd_player_number_fontColor", self.currentData.bnd_player_number_fontColor)
      end

      if self.currentLeague == "PremierLeagueTeamsData" then
        self.im.Publish("bnd_player_name_fontColor", playerColor)
        self.im.Publish("bnd_player_number_fontColor", playerColor)
        self.im.Publish("bnd_playersub_fontColor", playerColor)
        self.im.Publish("bnd_player_number_sub_fontColor", playerColor)
        self.im.Publish("bnd_text_sub_fontColor", playerColor)
        self.im.Publish("bnd_coach_name_fontColor", playerColor)
        self.im.Publish("bnd_text_coach_fontColor", playerColor)
      end

      if self.currentLeague == "Bundesliga1TeamsData" then
        self.im.Publish("bnd_player_number_fontColor", playerColor)
        self.im.Publish("bnd_team_name_fontColor", playerColor)
        self.im.Publish("bnd_team_formation_fontColor", playerColor)
      end

      if self.currentLeague == "BRILiga1TeamsData" then
        self.im.Publish("bnd_player_name_fontColor", playerColor)
        self.im.Publish("bnd_player_number_fontColor", playerColor)
        self.im.Publish("bnd_playersub_fontColor", playerColor)
        self.im.Publish("bnd_player_number_sub_fontColor", playerColor)
        self.im.Publish("bnd_text_sub_fontColor", playerColor)
        self.im.Publish("bnd_coach_name_fontColor", playerColor)
        self.im.Publish("bnd_text_coach_fontColor", playerColor)
      end

        self.coachName = coachNames[teamID] or "Unknown Coach"
      local teamColor = nil
      local leagueData = TeamColors[self.currentLeague]

      if leagueData then
          for i = 1, #leagueData do
              if leagueData[i].teamid == teamID then
                  teamColor = leagueData[i]
                  break
              end
          end
      end
      
      if teamColor then

    if teamSide == 0 then

        if currentMatch.HomeKitIndex == 0 then
            self.teamRectColor = teamColor.homeColor or "0xFFFFFF"

        elseif currentMatch.HomeKitIndex == 1 then
            self.teamRectColor = teamColor.awayColor or teamColor.homeColor or "0xFFFFFF"

        elseif currentMatch.HomeKitIndex == 3 then
            self.teamRectColor = teamColor.thirdColor or teamColor.awayColor or teamColor.homeColor or "0xFFFFFF"

        else
            self.teamRectColor = teamColor.homeColor or "0xFFFFFF"
        end

    else

        if currentMatch.AwayKitIndex == 0 then
            self.teamRectColor = teamColor.homeColor or "0xFFFFFF"

        elseif currentMatch.AwayKitIndex == 1 then
            self.teamRectColor = teamColor.awayColor or teamColor.homeColor or "0xFFFFFF"

        elseif currentMatch.AwayKitIndex == 3 then
            self.teamRectColor = teamColor.thirdColor or teamColor.awayColor or teamColor.homeColor or "0xFFFFFF"

        else
            self.teamRectColor = teamColor.awayColor or teamColor.homeColor or "0xFFFFFF"
        end

    end

else
    self.teamRectColor = "0xFFFFFF"
end

      if teamSide == 0 then
        self.crest.id = self.TeamsData[1].assetId
        self.crest2.id = self.TeamsData[1].assetId
        self.crest3.id = self.TeamsData[1].assetId
      else
        self.crest.id = self.TeamsData[2].assetId
        self.crest2.id = self.TeamsData[2].assetId
        self.crest3.id = self.TeamsData[2].assetId
      end

      if teamSide == 0 then

  self.kits.id = self.TeamsData[1].assetId

  if currentMatch.HomeKitIndex == 0 then
    self.kits.name = "$HomeKit"

  elseif currentMatch.HomeKitIndex == 1 then
    self.kits.name = "$AwayKit"

  elseif currentMatch.HomeKitIndex == 3 then
    self.kits.name = "$ThirdKit"

  else
    self.kits.name = "$HomeKit"
  end

else

  self.kits.id = self.TeamsData[2].assetId

  if currentMatch.AwayKitIndex == 0 then
    self.kits.name = "$HomeKit"

  elseif currentMatch.AwayKitIndex == 1 then
    self.kits.name = "$AwayKit"

  elseif currentMatch.AwayKitIndex == 3 then
    self.kits.name = "$ThirdKit"

  else
    self.kits.name = "$AwayKit"
  end

end

      if teamSide == 0 then
        self.kits_gk.id = self.TeamsData[1].assetId
      else
        self.kits_gk.id = self.TeamsData[2].assetId
      end
      self.kits_gk.name = "$GKKit"

      if teamSide == 0 then
        self.card_team.id = self.TeamsData[1].assetId
      else
        self.card_team.id = self.TeamsData[2].assetId
      end

      local CardLeagueMap = {
    PremierLeagueTeamsData = {
        home = "$card_premier_league_home",
        away = "$card_premier_league_away",
        third = "$card_premier_league_third"
    },

    BRILiga1TeamsData = {
        home = "$card_bri_liga1_Home",
        away = "$card_bri_liga1_Away",
        third = "$card_bri_liga1_Third"
    },

    Bundesliga1TeamsData = {
        home = "$card_bundesliga_Home",
        away = "$card_bundesliga_Away",
        third = "$card_bundesliga_Third"
    }
}

local leagueCard = CardLeagueMap[self.currentLeague]

if leagueCard then

    if teamSide == 0 then

        if currentMatch.HomeKitIndex == 0 then
            self.card_team.name = leagueCard.home

        elseif currentMatch.HomeKitIndex == 1 then
            self.card_team.name = leagueCard.away or leagueCard.home

        elseif currentMatch.HomeKitIndex == 3 then
            self.card_team.name = leagueCard.third or leagueCard.away or leagueCard.home

        else
            self.card_team.name = leagueCard.home
        end

    else

        if currentMatch.AwayKitIndex == 0 then
            self.card_team.name = leagueCard.home

        elseif currentMatch.AwayKitIndex == 1 then
            self.card_team.name = leagueCard.away or leagueCard.home

        elseif currentMatch.AwayKitIndex == 3 then
            self.card_team.name = leagueCard.third or leagueCard.away or leagueCard.home

        else
            self.card_team.name = leagueCard.away or leagueCard.home
        end

    end

else
    self.card_team.name = "$CardTeam"
end

      self.teamName = params[2]

      local lineup = self.services.SquadManagementService.GetCurrentPlayerLineup(teamSide, teamID, 0)
      local formationID = self.services.TacticsService.GetFormation(teamSide, teamID)

      if self.gamemode == "fut" then
        formationID = self.services.SquadManagementService.GetFUTRelativeSquadFormation(formationID)
      end

      local formation = self.models.FormationModel:getFormationInfoByID(formationID)
      local formationCoords = formation.coords
      local formationName = formation.name
      local formationPosition = formation.positions

      self.formationName = formationName

      self.playerLineup = {
        players = {},
        teamID = params[1],
        teamName = params[2],
        formationName = formationName,
        starting11Label = "",
        subsLabel = ""
      }

      for i = 1, table.getn(lineup) do
        self.playerLineup.players[i] = {}
        self.playerLineup.players[i].assetId = lineup[i].CARD_ID
        self.playerLineup.players[i].countryId = lineup[i].nationalityID
        self.playerLineup.players[i].name = lineup[i].playerName
        self.playerLineup.players[i].number = lineup[i].jerseyNumber
        self.playerLineup.players[i].hasYellowCard = false

        if i <= 11 then
          self.playerLineup.players[i].coords = formationCoords[i]
          self.playerLineup.players[i].jerseyColor = "0x00FF00"

          if formationPosition[i] then
            self.playerLineup.players[i].position = {
              xPos = formationPosition[i].xPos,
              yPos = formationPosition[i].yPos
            }
          end
        end
      end


      self:_publishPlayerLineup()
      self:_publishTeamCrest()
      self:_publishTeamCrest2()
      self:_publishTeamCrest3()
      self:_publishTeamKits()
      self:_publishTeamKitsGK()
      self:_publishTeamName()
      self:_publishCoachName()
      self:_publishTeamRectColor()
      self:_publishTeamFormation()
      self:_publishCardTeam()
    end

  else
    self.isActive = false
    self.isVisible = false
  end

  self:_publishActivity()
end

function Starting11:_publishActive()
  self.im.Publish("bnd_active", self.active)
end

function Starting11:_publishActivity()
  self.im.Publish("bnd_active", self.isActive)
  self.im.Publish("bnd_visible", self.isVisible)
end

function Starting11:_publishTeamCrest()
  local crestData = {
    id = self.crest.id,
    name = "$Crest"
  }

  if self.currentData == LALIGAInfo then
    crestData.name = "$Crest_Laliga"
  elseif self.currentData == WC26Info then
    crestData.name = "$CrestWorldCup2026"
  end

  self.im.Publish("bnd_team_crest", crestData)
end

function Starting11:_publishTeamCrest2()
  self.im.Publish("bnd_team_crest2", self.crest2)
end

function Starting11:_publishTeamCrest3()
  self.im.Publish("bnd_team_crest3", self.crest3)
end

function Starting11:_publishTeamKits()
  self.im.Publish("bnd_team_kits", self.kits)
end

function Starting11:_publishTeamKitsGK()
  self.im.Publish("bnd_team_kits_gk", self.kits_gk)
end

function Starting11:_publishCardTeam()
  self.im.Publish("bnd_card_team", self.card_team)
end

function Starting11:_publishTeamName()
  self.im.Publish("bnd_team_name", self.teamName)
end

function Starting11:_publishCoachName()
  self.im.Publish("bnd_coach_name", self.coachName)
end

function Starting11:_publishTeamRectColor()
  self.im.Publish("bnd_TeamRect_color", self.teamRectColor)
end

function Starting11:_publishTeamFormation()
  self.im.Publish("bnd_team_formation", self.formationName)
end

function Starting11:_publishPlayerLineup()
  if self.playerLineup == nil then
    return
  end

  for index = 1, table.getn(self.playerLineup.players) do
    local bindingPlayer = "bnd_player"..index
    local avatarName = "$Head"

    -- Cek league
    if self.currentLeague == "PremierLeagueTeamsData" then
      avatarName = "$MiniFaceEpl"
    elseif self.currentLeague == "" then
      avatarName = "$"
    end

    local player = self.playerLineup.players[index]

    local playerAvatar = {
      name = avatarName,
      id = player.assetId
    }

    -- Publish nama & nomor
    self.im.Publish(bindingPlayer.."_name", player.name.." ")
    self.im.Publish(bindingPlayer.."_number", player.number)

    if index <= 11 then
      -- Avatar
      self.im.Publish(bindingPlayer.."_avatar", playerAvatar)

      -- Posisi
      self.im.Publish(bindingPlayer.."_left", player.position.xPos)
      self.im.Publish(bindingPlayer.."_bottom", player.position.yPos)

      -- 🔥 FLAG NEGARA
      local flagData = {
        name = "$Flag128x128",
        id = player.countryId or 0
      }

      self.im.Publish("bnd_country_player"..index, flagData)
    end
  end
end

function Starting11:isInTable(value, tbl) 
  for i = 1, #tbl do
    if tbl[i].id == value.assetId then
      return true
    end
  end
  return false
end

function Starting11:finalize()
  print("[Starting11]: finalize()")
  self.models.FormationModel:finalize()
  self.im.Unsubscribe("bnd_active")
  self.im.Unsubscribe("bnd_visible")
  self.im.Unsubscribe("bnd_team_crest")
  self.im.Unsubscribe("bnd_team_crest2")
  self.im.Unsubscribe("bnd_team_crest3")
  self.im.Unsubscribe("bnd_team_kits")
  self.im.Unsubscribe("bnd_team_kits_gk")
  self.im.Unsubscribe("bnd_team_name")
  self.im.Unsubscribe("bnd_coach_name")
  self.im.Unsubscribe("bnd_TeamRect_color")
  self.im.Unsubscribe("bnd_card_team")
  self.im.Unsubscribe("bnd_team_formation")
  for k,v in pairs(self.bndList) do
    self.im.Unsubscribe(k)
  end
  self.services.eventManService.UnregisterHandler(self.handlerId)
end

return Starting11