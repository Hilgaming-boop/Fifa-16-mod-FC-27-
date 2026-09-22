-- CustomCup By Mounsta
-- Patch Mod InisialA (SaveTur & Sistem) + Multi-Save Mandiri per Turnamen

local TournamentSaveDatabase = {
    -- [ UEFA Champions League ]
    [1]   = "<Version>v2</Version>|<Status>complete</Status>|<TourID>1</TourID>|<TeamID>22</TeamID>|<TeamCount>32</TeamCount>|<FixtureIndex>0</FixtureIndex>|<Participants>73,243,10,21,9,5,44,22,241,240,1,32,39,45,234,483,1824,231,18,247,48,280,245,237,219,819,266,918,325,113888,69,2014</Participants>|<TournamentType>Group   Knockout</TournamentType>|<Fixtures>73,243,2,1,1,73,0,1,A,1;10,21,3,5,1,21,0,1,A,1;9,5,5,0,1,9,0,1,B,1;44,22,0,1,1,22,0,1,B,1;241,240,4,0,1,241,0,1,C,1;1,32,0,5,1,32,0,1,C,1;39,45,4,1,1,39,0,1,D,1;234,483,3,2,1,234,0,1,D,1;1824,231,2,3,1,231,0,1,E,1;18,247,2,0,1,18,0,1,E,1;48,280,5,2,1,48,0,1,F,1;245,237,1,4,1,237,0,1,F,1;219,819,3,4,1,819,0,1,G,1;266,918,2,1,1,266,0,1,G,1;325,113888,3,1,1,325,0,1,H,1;69,2014,1,0,1,69,0,1,H,1;243,10,0,0,0,0,0,1,A,2;73,21,0,0,0,0,0,1,A,2;5,22,0,0,0,0,0,1,B,2;9,44,0,0,0,0,0,1,B,2;241,32,0,0,0,0,0,1,C,2;1,240,0,0,0,0,0,1,C,2;234,45,0,0,0,0,0,1,D,2;39,483,0,0,0,0,0,1,D,2;231,247,0,0,0,0,0,1,E,2;1824,18,0,0,0,0,0,1,E,2;245,48,0,0,0,0,0,1,F,2;237,280,0,0,0,0,0,1,F,2;266,819,0,0,0,0,0,1,G,2;918,219,0,0,0,0,0,1,G,2;69,113888,0,0,0,0,0,1,H,2;325,2014,0,0,0,0,0,1,H,2;243,21,0,0,0,0,0,1,A,3;73,10,0,0,0,0,0,1,A,3;9,22,0,0,0,0,0,1,B,3;44,5,0,0,0,0,0,1,B,3;241,1,0,0,0,0,0,1,C,3;32,240,0,0,0,0,0,1,C,3;234,39,0,0,0,0,0,1,D,3;483,45,0,0,0,0,0,1,D,3;231,18,0,0,0,0,0,1,E,3;1824,247,0,0,0,0,0,1,E,3;48,237,0,0,0,0,0,1,F,3;245,280,0,0,0,0,0,1,F,3;266,219,0,0,0,0,0,1,G,3;918,819,0,0,0,0,0,1,G,3;69,325,0,0,0,0,0,1,H,3;2014,113888,0,0,0,0,0,1,H,3</Fixtures>|<Results>xByftkvUKeOEVxcwqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq</Results>|<Goals>79922:1;212811:1;270571:1;244260:1;72866:1;239085:1;247229:1;235212:1;245992:1;83019:1;278228:1;76955:1;222514:1;227055:1;242835:1;266866:1;210324:1;251806:1;71305:1;253124:1;275029:1;239837:1;188545:1;246267:1;262236:1;267920:1;241236:1;238744:1;252143:1;71672:1;259065:1;216409:1;215441:1;237238:1;263672:1;213648:1;77126:1;242287:1;79690:1;83381:1;207790:1;203362:1;240716:1;247463:1;216547:1;279709:1;263765:1;241186:1;70289:1;275028:1;173426:1;258892:1;208618:1;192505:1;241461:1;81240:1;251854:1;82746:2;238216:1;253399:1;248243:1;264219:1;240020:1;186569:1;238235:1;263887:1;208461:1;232487:2</Goals>|<YellowCards>278399:1;202316:1;261530:1;240020:1;237238:1;240753:1;265188:1;210044:1;259586:1;83177:1;257711:1;276614:1;245211:1;251570:1;223550:1;83168:1;258966:1;83381:1;79690:1</YellowCards>|<RedCards></RedCards>|<Trophies></Trophies>|<GroupStandings>true</GroupStandings>", 
    
    -- [ FIFA World Cup 2026 ]
    [2]   = "<Version>v2</Version>|<Status>complete</Status>|<TourID>2</TourID>|<TeamID>111510</TeamID>|<TeamCount>48</TeamCount>|<FixtureIndex>0</FixtureIndex>|<Participants>111099,974,1386,1330,105013,111527,111455,1364,1370,1359,111111,112048,1375,1365,1387,1415,112054,111112,1337,111465,105035,1363,1411,1391,1325,1369,1354,111130,1362,111114,111473,111456,1335,1667,1377,111512,1352,1322,111448,111513,111545,111485,111109,1318,111462,111510,1328,111475</Participants>|<TournamentType>Group   Knockout</TournamentType>|<Fixtures>111099,974,5,4,1,111099,0,1,A,1;1386,1330,4,1,1,1386,0,1,A,1;105013,111527,1,5,1,111527,0,1,B,1;111455,1364,0,3,1,1364,0,1,B,1;1370,1359,5,5,1,0,0,1,C,1;111111,112048,5,2,1,111111,0,1,C,1;1375,1365,4,1,1,1375,0,1,D,1;1387,1415,5,4,1,1387,0,1,D,1;112054,111112,1,3,1,111112,0,1,E,1;1337,111465,2,3,1,111465,0,1,E,1;105035,1363,1,4,1,1363,0,1,F,1;1411,1391,5,5,1,0,0,1,F,1;1325,1369,5,1,1,1325,0,1,G,1;1354,111130,5,4,1,1354,0,1,G,1;1362,111114,2,2,1,0,0,1,H,1;111473,111456,5,3,1,111473,0,1,H,1;1335,1667,2,1,1,1335,0,1,I,1;1377,111512,3,3,1,0,0,1,I,1;1352,1322,5,1,1,1352,0,1,J,1;111448,111513,0,4,1,111513,0,1,J,1;111545,111485,3,2,1,111545,0,1,K,1;111109,1318,4,1,1,111109,0,1,K,1;111462,111510,3,3,1,0,0,1,L,1;1328,111475,2,1,1,1328,0,1,L,1;111099,1330,0,0,0,0,0,1,A,2;1386,974,0,0,0,0,0,1,A,2;105013,1364,0,0,0,0,0,1,B,2;111455,111527,0,0,0,0,0,1,B,2;111111,1359,0,0,0,0,0,1,C,2;1370,112048,0,0,0,0,0,1,C,2;1415,1365,0,0,0,0,0,1,D,2;1387,1375,0,0,0,0,0,1,D,2;1337,112054,0,0,0,0,0,1,E,2;111112,111465,0,0,0,0,0,1,E,2;105035,1391,0,0,0,0,0,1,F,2;1411,1363,0,0,0,0,0,1,F,2;1325,111130,0,0,0,0,0,1,G,2;1354,1369,0,0,0,0,0,1,G,2;111456,111114,0,0,0,0,0,1,H,2;111473,1362,0,0,0,0,0,1,H,2;1377,1667,0,0,0,0,0,1,I,2;1335,111512,0,0,0,0,0,1,I,2;1352,111513,0,0,0,0,0,1,J,2;111448,1322,0,0,0,0,0,1,J,2;111545,1318,0,0,0,0,0,1,K,2;111485,111109,0,0,0,0,0,1,K,2;111475,111510,0,0,0,0,0,1,L,2;1328,111462,0,0,0,0,0,1,L,2;974,1330,0,0,0,0,0,1,A,3;1386,111099,0,0,0,0,0,1,A,3;111455,105013,0,0,0,0,0,1,B,3;111527,1364,0,0,0,0,0,1,B,3;1370,111111,0,0,0,0,0,1,C,3;112048,1359,0,0,0,0,0,1,C,3;1375,1415,0,0,0,0,0,1,D,3;1387,1365,0,0,0,0,0,1,D,3;112054,111465,0,0,0,0,0,1,E,3;1337,111112,0,0,0,0,0,1,E,3;1363,1391,0,0,0,0,0,1,F,3;105035,1411,0,0,0,0,0,1,F,3;1354,1325,0,0,0,0,0,1,G,3;111130,1369,0,0,0,0,0,1,G,3;111473,111114,0,0,0,0,0,1,H,3;1362,111456,0,0,0,0,0,1,H,3;1667,111512,0,0,0,0,0,1,I,3;1377,1335,0,0,0,0,0,1,I,3;1322,111513,0,0,0,0,0,1,J,3;1352,111448,0,0,0,0,0,1,J,3;111485,1318,0,0,0,0,0,1,K,3;111545,111109,0,0,0,0,0,1,K,3;1328,111510,0,0,0,0,0,1,L,3;111462,111475,0,0,0,0,0,1,L,3</Fixtures>|<Results>HvRhdOvHWKEdbHpDxabjUvaxqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq</Results>|<Goals>63877:1;193348:1;277809:1;257896:1;233225:1;240716:1;203263:1;244191:1;260798:1;216460:1;256782:2;243586:1;268825:1;231443:1;275522:1;238616:1;212511:1;264432:1;210822:1;63042:1;269278:1;277503:1;211142:1;260740:1;244261:1;246875:1;73092:1;231416:1;230938:1;73921:1;83882:1;223671:1;245539:1;241746:1;228518:1;76042:1;270564:1;218191:1;80170:1;229348:1;210287:1;269164:1;277643:1;207865:1;233493:1;60008:1;237255:1;268785:1;204424:2;276564:1;275353:1;257784:1;247361:1;210514:1;177683:1;246055:1;221671:1;218930:1;277846:1;261357:1;79823:1;433843:1;79632:1;263887:1;258490:1;254952:1;206566:1;251223:1;61731:1;261742:1;247686:1;223273:1;62003:1;235183:1;197756:1;241590:1;273624:1;270141:1;274000:1;192129:1;262881:1;261298:1;238545:1;251162:1;254254:1;226491:1;223150:1;62957:1;207993:1;255434:1;243481:1;257278:1;273906:1;253036:1;190059:1;209981:1;224293:1;213615:1;228182:1;61732:1;180561:1;210257:1;62680:1;62663:1;242654:1;257400:1;213991:1;261875:1;237566:2;202014:1;232500:1;256903:1;80911:1;16981:1;244349:1;264453:1;191043:1;243580:1;267920:1;261283:1;255981:2;253727:1;72656:1;199641:1;262265:1;226677:1;237424:1;274616:1;257289:1;225859:1;234051:1;231065:1;190765:1;277295:1;268821:1;242271:1;264311:1;182091:1;412967:1</Goals>|<YellowCards>238227:1;233195:1;231447:1;229880:1;267594:1;276493:1;238370:1;245371:1;74735:1;272951:1;275298:1;263376:1;237647:1;230977:1;190059:1;207865:1;263112:1;257470:1;218229:1;198904:1;260952:1;209316:1;237942:1;233225:1;241731:1;233510:1;241943:1;198032:1;433911:1;254252:1;256331:1;73348:1;220886:1;265774:1</YellowCards>|<RedCards>200145:1;256903:1</RedCards>|<Trophies>111130=2:1</Trophies>|<GroupStandings>true</GroupStandings>",
    
    -- [ UEFA Europa League ]
    [3]   = "", 
    
    -- [ UEFA Conference League ]
    [17]  = "", 
    
    -- [ FIFA Club World Cup ]
    [15]  = "", 
    
    -- [ Classic Tour ]
    [22]  = "", 
    
    -- [ The Emirates FA Cup ]
    [9]   = "", 
    
    -- [ Copa del Rey ]
    [10]  = "", 
    
    -- [ Coppa Italia ]
    [11]  = "", 
    
    -- [ Coupe de France ]
    [18]  = "", 
    
    -- [ Dfb Pokal ]
    [7]   = "", 
    
    -- [ Copa America ]
    [25]  = "", 
    
    -- [ Kratingdaeng Piala Indonesia ]
    [29]  = "", 
    
    -- [ AFC Champions League Elit ]
    [24]  = "", 
    
    -- [ AFC Champions League Two ]
    [31]  = "", 
    
    -- [ AFC Challenge League ]
    [21]  = "", 
    
    -- [ CONMEBOL Libertadores ]
    [4]   = "", 
    
    -- [ AFC Asian Cup Qatar 2023™ ]
    [34]  = "", 
    
    -- [ UEFA Euro ]
    [6]   = "", 
    
    -- [ UEFA Nations League ]
    [28]  = "", 
    
    -- [ US Open Tour ]
    [13]  = "", 
    
    -- [ Africa Cup Of Nations ]
    [26]  = "", 
    
    -- [ ASEAN Hyundai Cup 2026 ]
    [27]  = "", 
    
    -- [ Piala Presiden ]
    [32]  = "", 
    
    -- [ Sea Games U-23 ]
    [23]  = "", 
    
    -- [ Asean Shopee Cup ]
    [12]  = "", 
    
    -- [ Saudi Arab Tour ]
    [50]  = "", 
    
    -- [ UEFA Women CL ]
    [16]  = "", 
    
    -- [ FIFA Women World Cup ]
    [35]  = "", 
    
    -- [ EA Sports Cup ]
    [14]  = "", 

    -- [ Premier League ]
    [133]  = "<Version>v2</Version>|<Status>complete</Status>|<TourID>133</TourID>|<TeamID>9</TeamID>|<TeamCount>20</TeamCount>|<FixtureIndex>0</FixtureIndex>|<Participants>1,1952,2,1943,5,1925,7,1808,8,1800,9,1799,10,144,11,106,13,94,14,18</Participants>|<TournamentType>League</TournamentType>|<Fixtures>1,1952,4,0,1,1,0,1,LEAGUE,1;2,1943,3,0,1,2,0,1,LEAGUE,1;5,1925,1,1,1,0,0,1,LEAGUE,1;7,1808,0,2,1,1808,0,1,LEAGUE,1;8,1800,3,2,1,8,0,1,LEAGUE,1;9,1799,4,3,1,9,0,1,LEAGUE,1;10,144,4,2,1,10,0,1,LEAGUE,1;11,106,5,2,1,11,0,1,LEAGUE,1;13,94,1,3,1,94,0,1,LEAGUE,1;14,18,2,5,1,18,0,1,LEAGUE,1;1943,1,2,5,1,1,0,1,LEAGUE,2;1925,1952,3,1,1,1925,0,1,LEAGUE,2;1808,2,5,1,1,1808,0,1,LEAGUE,2;1800,5,0,0,1,0,0,1,LEAGUE,2;1799,7,0,0,1,0,0,1,LEAGUE,2;144,8,3,3,1,0,0,1,LEAGUE,2;106,9,3,4,1,9,0,1,LEAGUE,2;94,10,4,5,1,10,0,1,LEAGUE,2;18,11,4,2,1,18,0,1,LEAGUE,2;14,13,3,3,1,0,0,1,LEAGUE,2;1,1925,4,2,1,1,0,1,LEAGUE,3;1943,1808,3,1,1,1943,0,1,LEAGUE,3;1952,1800,4,4,1,0,0,1,LEAGUE,3;2,1799,5,5,1,0,0,1,LEAGUE,3;5,144,5,2,1,5,0,1,LEAGUE,3;7,106,0,4,1,106,0,1,LEAGUE,3;8,94,0,2,1,94,0,1,LEAGUE,3;9,18,0,0,1,0,0,1,LEAGUE,3;10,14,5,4,1,10,0,1,LEAGUE,3;11,13,1,2,1,13,0,1,LEAGUE,3;1808,1,0,0,0,0,0,1,LEAGUE,4;1800,1925,0,0,0,0,0,1,LEAGUE,4;1799,1943,0,0,0,0,0,1,LEAGUE,4;144,1952,0,0,0,0,0,1,LEAGUE,4;106,2,0,0,0,0,0,1,LEAGUE,4;94,5,0,0,0,0,0,1,LEAGUE,4;18,7,0,0,0,0,0,1,LEAGUE,4;14,8,0,0,0,0,0,1,LEAGUE,4;13,9,0,0,0,0,0,1,LEAGUE,4;11,10,0,0,0,0,0,1,LEAGUE,4;1,1800,0,0,0,0,0,1,LEAGUE,5;1808,1799,0,0,0,0,0,1,LEAGUE,5;1925,144,0,0,0,0,0,1,LEAGUE,5;1943,106,0,0,0,0,0,1,LEAGUE,5;1952,94,0,0,0,0,0,1,LEAGUE,5;2,18,0,0,0,0,0,1,LEAGUE,5;5,14,0,0,0,0,0,1,LEAGUE,5;7,13,0,0,0,0,0,1,LEAGUE,5;8,11,0,0,0,0,0,1,LEAGUE,5;9,10,0,0,0,0,0,1,LEAGUE,5;1799,1,0,0,0,0,0,1,LEAGUE,6;144,1800,0,0,0,0,0,1,LEAGUE,6;106,1808,0,0,0,0,0,1,LEAGUE,6;94,1925,0,0,0,0,0,1,LEAGUE,6;18,1943,0,0,0,0,0,1,LEAGUE,6;14,1952,0,0,0,0,0,1,LEAGUE,6;13,2,0,0,0,0,0,1,LEAGUE,6;11,5,0,0,0,0,0,1,LEAGUE,6;10,7,0,0,0,0,0,1,LEAGUE,6;9,8,0,0,0,0,0,1,LEAGUE,6;1,144,0,0,0,0,0,1,LEAGUE,7;1799,106,0,0,0,0,0,1,LEAGUE,7;1800,94,0,0,0,0,0,1,LEAGUE,7;1808,18,0,0,0,0,0,1,LEAGUE,7;1925,14,0,0,0,0,0,1,LEAGUE,7;1943,13,0,0,0,0,0,1,LEAGUE,7;1952,11,0,0,0,0,0,1,LEAGUE,7;2,10,0,0,0,0,0,1,LEAGUE,7;5,9,0,0,0,0,0,1,LEAGUE,7;7,8,0,0,0,0,0,1,LEAGUE,7;106,1,0,0,0,0,0,1,LEAGUE,8;94,144,0,0,0,0,0,1,LEAGUE,8;18,1799,0,0,0,0,0,1,LEAGUE,8;14,1800,0,0,0,0,0,1,LEAGUE,8;13,1808,0,0,0,0,0,1,LEAGUE,8;11,1925,0,0,0,0,0,1,LEAGUE,8;10,1943,0,0,0,0,0,1,LEAGUE,8;9,1952,0,0,0,0,0,1,LEAGUE,8;8,2,0,0,0,0,0,1,LEAGUE,8;7,5,0,0,0,0,0,1,LEAGUE,8;1,94,0,0,0,0,0,1,LEAGUE,9;106,18,0,0,0,0,0,1,LEAGUE,9;144,14,0,0,0,0,0,1,LEAGUE,9;1799,13,0,0,0,0,0,1,LEAGUE,9;1800,11,0,0,0,0,0,1,LEAGUE,9;1808,10,0,0,0,0,0,1,LEAGUE,9;1925,9,0,0,0,0,0,1,LEAGUE,9;1943,8,0,0,0,0,0,1,LEAGUE,9;1952,7,0,0,0,0,0,1,LEAGUE,9;2,5,0,0,0,0,0,1,LEAGUE,9;18,1,0,0,0,0,0,1,LEAGUE,10;14,94,0,0,0,0,0,1,LEAGUE,10;13,106,0,0,0,0,0,1,LEAGUE,10;11,144,0,0,0,0,0,1,LEAGUE,10;10,1799,0,0,0,0,0,1,LEAGUE,10;9,1800,0,0,0,0,0,1,LEAGUE,10;8,1808,0,0,0,0,0,1,LEAGUE,10;7,1925,0,0,0,0,0,1,LEAGUE,10;5,1943,0,0,0,0,0,1,LEAGUE,10;2,1952,0,0,0,0,0,1,LEAGUE,10;1,14,0,0,0,0,0,1,LEAGUE,11;18,13,0,0,0,0,0,1,LEAGUE,11;94,11,0,0,0,0,0,1,LEAGUE,11;106,10,0,0,0,0,0,1,LEAGUE,11;144,9,0,0,0,0,0,1,LEAGUE,11;1799,8,0,0,0,0,0,1,LEAGUE,11;1800,7,0,0,0,0,0,1,LEAGUE,11;1808,5,0,0,0,0,0,1,LEAGUE,11;1925,2,0,0,0,0,0,1,LEAGUE,11;1943,1952,0,0,0,0,0,1,LEAGUE,11;13,1,0,0,0,0,0,1,LEAGUE,12;11,14,0,0,0,0,0,1,LEAGUE,12;10,18,0,0,0,0,0,1,LEAGUE,12;9,94,0,0,0,0,0,1,LEAGUE,12;8,106,0,0,0,0,0,1,LEAGUE,12;7,144,0,0,0,0,0,1,LEAGUE,12;5,1799,0,0,0,0,0,1,LEAGUE,12;2,1800,0,0,0,0,0,1,LEAGUE,12;1952,1808,0,0,0,0,0,1,LEAGUE,12;1943,1925,0,0,0,0,0,1,LEAGUE,12;1,11,0,0,0,0,0,1,LEAGUE,13;13,10,0,0,0,0,0,1,LEAGUE,13;14,9,0,0,0,0,0,1,LEAGUE,13;18,8,0,0,0,0,0,1,LEAGUE,13;94,7,0,0,0,0,0,1,LEAGUE,13;106,5,0,0,0,0,0,1,LEAGUE,13;144,2,0,0,0,0,0,1,LEAGUE,13;1799,1952,0,0,0,0,0,1,LEAGUE,13;1800,1943,0,0,0,0,0,1,LEAGUE,13;1808,1925,0,0,0,0,0,1,LEAGUE,13;10,1,0,0,0,0,0,1,LEAGUE,14;9,11,0,0,0,0,0,1,LEAGUE,14;8,13,0,0,0,0,0,1,LEAGUE,14;7,14,0,0,0,0,0,1,LEAGUE,14;5,18,0,0,0,0,0,1,LEAGUE,14;2,94,0,0,0,0,0,1,LEAGUE,14;1952,106,0,0,0,0,0,1,LEAGUE,14;1943,144,0,0,0,0,0,1,LEAGUE,14;1925,1799,0,0,0,0,0,1,LEAGUE,14;1808,1800,0,0,0,0,0,1,LEAGUE,14;1,9,0,0,0,0,0,1,LEAGUE,15;10,8,0,0,0,0,0,1,LEAGUE,15;11,7,0,0,0,0,0,1,LEAGUE,15;13,5,0,0,0,0,0,1,LEAGUE,15;14,2,0,0,0,0,0,1,LEAGUE,15;18,1952,0,0,0,0,0,1,LEAGUE,15;94,1943,0,0,0,0,0,1,LEAGUE,15;106,1925,0,0,0,0,0,1,LEAGUE,15;144,1808,0,0,0,0,0,1,LEAGUE,15;1799,1800,0,0,0,0,0,1,LEAGUE,15;8,1,0,0,0,0,0,1,LEAGUE,16;7,9,0,0,0,0,0,1,LEAGUE,16;5,10,0,0,0,0,0,1,LEAGUE,16;2,11,0,0,0,0,0,1,LEAGUE,16;1952,13,0,0,0,0,0,1,LEAGUE,16;1943,14,0,0,0,0,0,1,LEAGUE,16;1925,18,0,0,0,0,0,1,LEAGUE,16;1808,94,0,0,0,0,0,1,LEAGUE,16;1800,106,0,0,0,0,0,1,LEAGUE,16;1799,144,0,0,0,0,0,1,LEAGUE,16;1,7,0,0,0,0,0,1,LEAGUE,17;8,5,0,0,0,0,0,1,LEAGUE,17;9,2,0,0,0,0,0,1,LEAGUE,17;10,1952,0,0,0,0,0,1,LEAGUE,17;11,1943,0,0,0,0,0,1,LEAGUE,17;13,1925,0,0,0,0,0,1,LEAGUE,17;14,1808,0,0,0,0,0,1,LEAGUE,17;18,1800,0,0,0,0,0,1,LEAGUE,17;94,1799,0,0,0,0,0,1,LEAGUE,17;106,144,0,0,0,0,0,1,LEAGUE,17;5,1,0,0,0,0,0,1,LEAGUE,18;2,7,0,0,0,0,0,1,LEAGUE,18;1952,8,0,0,0,0,0,1,LEAGUE,18;1943,9,0,0,0,0,0,1,LEAGUE,18;1925,10,0,0,0,0,0,1,LEAGUE,18;1808,11,0,0,0,0,0,1,LEAGUE,18;1800,13,0,0,0,0,0,1,LEAGUE,18;1799,14,0,0,0,0,0,1,LEAGUE,18;144,18,0,0,0,0,0,1,LEAGUE,18;106,94,0,0,0,0,0,1,LEAGUE,18;1,2,0,0,0,0,0,1,LEAGUE,19;5,1952,0,0,0,0,0,1,LEAGUE,19;7,1943,0,0,0,0,0,1,LEAGUE,19;8,1925,0,0,0,0,0,1,LEAGUE,19;9,1808,0,0,0,0,0,1,LEAGUE,19;10,1800,0,0,0,0,0,1,LEAGUE,19;11,1799,0,0,0,0,0,1,LEAGUE,19;13,144,0,0,0,0,0,1,LEAGUE,19;14,106,0,0,0,0,0,1,LEAGUE,19;18,94,0,0,0,0,0,1,LEAGUE,19;1952,1,0,0,0,0,0,1,LEAGUE,20;1943,2,0,0,0,0,0,1,LEAGUE,20;1925,5,0,0,0,0,0,1,LEAGUE,20;1808,7,0,0,0,0,0,1,LEAGUE,20;1800,8,0,0,0,0,0,1,LEAGUE,20;1799,9,0,0,0,0,0,1,LEAGUE,20;144,10,0,0,0,0,0,1,LEAGUE,20;106,11,0,0,0,0,0,1,LEAGUE,20;94,13,0,0,0,0,0,1,LEAGUE,20;18,14,0,0,0,0,0,1,LEAGUE,20;1,1943,0,0,0,0,0,1,LEAGUE,21;1952,1925,0,0,0,0,0,1,LEAGUE,21;2,1808,0,0,0,0,0,1,LEAGUE,21;5,1800,0,0,0,0,0,1,LEAGUE,21;7,1799,0,0,0,0,0,1,LEAGUE,21;8,144,0,0,0,0,0,1,LEAGUE,21;9,106,0,0,0,0,0,1,LEAGUE,21;10,94,0,0,0,0,0,1,LEAGUE,21;11,18,0,0,0,0,0,1,LEAGUE,21;13,14,0,0,0,0,0,1,LEAGUE,21;1925,1,0,0,0,0,0,1,LEAGUE,22;1808,1943,0,0,0,0,0,1,LEAGUE,22;1800,1952,0,0,0,0,0,1,LEAGUE,22;1799,2,0,0,0,0,0,1,LEAGUE,22;144,5,0,0,0,0,0,1,LEAGUE,22;106,7,0,0,0,0,0,1,LEAGUE,22;94,8,0,0,0,0,0,1,LEAGUE,22;18,9,0,0,0,0,0,1,LEAGUE,22;14,10,0,0,0,0,0,1,LEAGUE,22;13,11,0,0,0,0,0,1,LEAGUE,22;1,1808,0,0,0,0,0,1,LEAGUE,23;1925,1800,0,0,0,0,0,1,LEAGUE,23;1943,1799,0,0,0,0,0,1,LEAGUE,23;1952,144,0,0,0,0,0,1,LEAGUE,23;2,106,0,0,0,0,0,1,LEAGUE,23;5,94,0,0,0,0,0,1,LEAGUE,23;7,18,0,0,0,0,0,1,LEAGUE,23;8,14,0,0,0,0,0,1,LEAGUE,23;9,13,0,0,0,0,0,1,LEAGUE,23;10,11,0,0,0,0,0,1,LEAGUE,23;1800,1,0,0,0,0,0,1,LEAGUE,24;1799,1808,0,0,0,0,0,1,LEAGUE,24;144,1925,0,0,0,0,0,1,LEAGUE,24;106,1943,0,0,0,0,0,1,LEAGUE,24;94,1952,0,0,0,0,0,1,LEAGUE,24;18,2,0,0,0,0,0,1,LEAGUE,24;14,5,0,0,0,0,0,1,LEAGUE,24;13,7,0,0,0,0,0,1,LEAGUE,24;11,8,0,0,0,0,0,1,LEAGUE,24;10,9,0,0,0,0,0,1,LEAGUE,24;1,1799,0,0,0,0,0,1,LEAGUE,25;1800,144,0,0,0,0,0,1,LEAGUE,25;1808,106,0,0,0,0,0,1,LEAGUE,25;1925,94,0,0,0,0,0,1,LEAGUE,25;1943,18,0,0,0,0,0,1,LEAGUE,25;1952,14,0,0,0,0,0,1,LEAGUE,25;2,13,0,0,0,0,0,1,LEAGUE,25;5,11,0,0,0,0,0,1,LEAGUE,25;7,10,0,0,0,0,0,1,LEAGUE,25;8,9,0,0,0,0,0,1,LEAGUE,25;144,1,0,0,0,0,0,1,LEAGUE,26;106,1799,0,0,0,0,0,1,LEAGUE,26;94,1800,0,0,0,0,0,1,LEAGUE,26;18,1808,0,0,0,0,0,1,LEAGUE,26;14,1925,0,0,0,0,0,1,LEAGUE,26;13,1943,0,0,0,0,0,1,LEAGUE,26;11,1952,0,0,0,0,0,1,LEAGUE,26;10,2,0,0,0,0,0,1,LEAGUE,26;9,5,0,0,0,0,0,1,LEAGUE,26;8,7,0,0,0,0,0,1,LEAGUE,26;1,106,0,0,0,0,0,1,LEAGUE,27;144,94,0,0,0,0,0,1,LEAGUE,27;1799,18,0,0,0,0,0,1,LEAGUE,27;1800,14,0,0,0,0,0,1,LEAGUE,27;1808,13,0,0,0,0,0,1,LEAGUE,27;1925,11,0,0,0,0,0,1,LEAGUE,27;1943,10,0,0,0,0,0,1,LEAGUE,27;1952,9,0,0,0,0,0,1,LEAGUE,27;2,8,0,0,0,0,0,1,LEAGUE,27;5,7,0,0,0,0,0,1,LEAGUE,27;94,1,0,0,0,0,0,1,LEAGUE,28;18,106,0,0,0,0,0,1,LEAGUE,28;14,144,0,0,0,0,0,1,LEAGUE,28;13,1799,0,0,0,0,0,1,LEAGUE,28;11,1800,0,0,0,0,0,1,LEAGUE,28;10,1808,0,0,0,0,0,1,LEAGUE,28;9,1925,0,0,0,0,0,1,LEAGUE,28;8,1943,0,0,0,0,0,1,LEAGUE,28;7,1952,0,0,0,0,0,1,LEAGUE,28;5,2,0,0,0,0,0,1,LEAGUE,28;1,18,0,0,0,0,0,1,LEAGUE,29;94,14,0,0,0,0,0,1,LEAGUE,29;106,13,0,0,0,0,0,1,LEAGUE,29;144,11,0,0,0,0,0,1,LEAGUE,29;1799,10,0,0,0,0,0,1,LEAGUE,29;1800,9,0,0,0,0,0,1,LEAGUE,29;1808,8,0,0,0,0,0,1,LEAGUE,29;1925,7,0,0,0,0,0,1,LEAGUE,29;1943,5,0,0,0,0,0,1,LEAGUE,29;1952,2,0,0,0,0,0,1,LEAGUE,29;14,1,0,0,0,0,0,1,LEAGUE,30;13,18,0,0,0,0,0,1,LEAGUE,30;11,94,0,0,0,0,0,1,LEAGUE,30;10,106,0,0,0,0,0,1,LEAGUE,30;9,144,0,0,0,0,0,1,LEAGUE,30;8,1799,0,0,0,0,0,1,LEAGUE,30;7,1800,0,0,0,0,0,1,LEAGUE,30;5,1808,0,0,0,0,0,1,LEAGUE,30;2,1925,0,0,0,0,0,1,LEAGUE,30;1952,1943,0,0,0,0,0,1,LEAGUE,30;1,13,0,0,0,0,0,1,LEAGUE,31;14,11,0,0,0,0,0,1,LEAGUE,31;18,10,0,0,0,0,0,1,LEAGUE,31;94,9,0,0,0,0,0,1,LEAGUE,31;106,8,0,0,0,0,0,1,LEAGUE,31;144,7,0,0,0,0,0,1,LEAGUE,31;1799,5,0,0,0,0,0,1,LEAGUE,31;1800,2,0,0,0,0,0,1,LEAGUE,31;1808,1952,0,0,0,0,0,1,LEAGUE,31;1925,1943,0,0,0,0,0,1,LEAGUE,31;11,1,0,0,0,0,0,1,LEAGUE,32;10,13,0,0,0,0,0,1,LEAGUE,32;9,14,0,0,0,0,0,1,LEAGUE,32;8,18,0,0,0,0,0,1,LEAGUE,32;7,94,0,0,0,0,0,1,LEAGUE,32;5,106,0,0,0,0,0,1,LEAGUE,32;2,144,0,0,0,0,0,1,LEAGUE,32;1952,1799,0,0,0,0,0,1,LEAGUE,32;1943,1800,0,0,0,0,0,1,LEAGUE,32;1925,1808,0,0,0,0,0,1,LEAGUE,32;1,10,0,0,0,0,0,1,LEAGUE,33;11,9,0,0,0,0,0,1,LEAGUE,33;13,8,0,0,0,0,0,1,LEAGUE,33;14,7,0,0,0,0,0,1,LEAGUE,33;18,5,0,0,0,0,0,1,LEAGUE,33;94,2,0,0,0,0,0,1,LEAGUE,33;106,1952,0,0,0,0,0,1,LEAGUE,33;144,1943,0,0,0,0,0,1,LEAGUE,33;1799,1925,0,0,0,0,0,1,LEAGUE,33;1800,1808,0,0,0,0,0,1,LEAGUE,33;9,1,0,0,0,0,0,1,LEAGUE,34;8,10,0,0,0,0,0,1,LEAGUE,34;7,11,0,0,0,0,0,1,LEAGUE,34;5,13,0,0,0,0,0,1,LEAGUE,34;2,14,0,0,0,0,0,1,LEAGUE,34;1952,18,0,0,0,0,0,1,LEAGUE,34;1943,94,0,0,0,0,0,1,LEAGUE,34;1925,106,0,0,0,0,0,1,LEAGUE,34;1808,144,0,0,0,0,0,1,LEAGUE,34;1800,1799,0,0,0,0,0,1,LEAGUE,34;1,8,0,0,0,0,0,1,LEAGUE,35;9,7,0,0,0,0,0,1,LEAGUE,35;10,5,0,0,0,0,0,1,LEAGUE,35;11,2,0,0,0,0,0,1,LEAGUE,35;13,1952,0,0,0,0,0,1,LEAGUE,35;14,1943,0,0,0,0,0,1,LEAGUE,35;18,1925,0,0,0,0,0,1,LEAGUE,35;94,1808,0,0,0,0,0,1,LEAGUE,35;106,1800,0,0,0,0,0,1,LEAGUE,35;144,1799,0,0,0,0,0,1,LEAGUE,35;7,1,0,0,0,0,0,1,LEAGUE,36;5,8,0,0,0,0,0,1,LEAGUE,36;2,9,0,0,0,0,0,1,LEAGUE,36;1952,10,0,0,0,0,0,1,LEAGUE,36;1943,11,0,0,0,0,0,1,LEAGUE,36;1925,13,0,0,0,0,0,1,LEAGUE,36;1808,14,0,0,0,0,0,1,LEAGUE,36;1800,18,0,0,0,0,0,1,LEAGUE,36;1799,94,0,0,0,0,0,1,LEAGUE,36;144,106,0,0,0,0,0,1,LEAGUE,36;1,5,0,0,0,0,0,1,LEAGUE,37;7,2,0,0,0,0,0,1,LEAGUE,37;8,1952,0,0,0,0,0,1,LEAGUE,37;9,1943,0,0,0,0,0,1,LEAGUE,37;10,1925,0,0,0,0,0,1,LEAGUE,37;11,1808,0,0,0,0,0,1,LEAGUE,37;13,1800,0,0,0,0,0,1,LEAGUE,37;14,1799,0,0,0,0,0,1,LEAGUE,37;18,144,0,0,0,0,0,1,LEAGUE,37;94,106,0,0,0,0,0,1,LEAGUE,37;2,1,0,0,0,0,0,1,LEAGUE,38;1952,5,0,0,0,0,0,1,LEAGUE,38;1943,7,0,0,0,0,0,1,LEAGUE,38;1925,8,0,0,0,0,0,1,LEAGUE,38;1808,9,0,0,0,0,0,1,LEAGUE,38;1800,10,0,0,0,0,0,1,LEAGUE,38;1799,11,0,0,0,0,0,1,LEAGUE,38;144,13,0,0,0,0,0,1,LEAGUE,38;106,14,0,0,0,0,0,1,LEAGUE,38;94,18,0,0,0,0,0,1,LEAGUE,38</Fixtures>|<Results>trogUS*OWZZcbqqaVJ*a*csdOjgqHQqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq</Results>|<Goals>246420:2;228092:1;222514:1;227678:1;199915:3;253306:2;210881:1;225193:1;235744:1;264298:1;231633:1;251555:2;253149:2;271248:2;242663:1;243715:1;213147:1;222104:1;235173:3;236480:1;238074:1;243908:2;241645:1;248148:1;221660:2;271574:1;250954:1;206585:2;246174:1;240947:1;212419:1;218667:1;268903:1;269796:1;212484:1;230621:1;203751:1;237985:1;73253:1;213697:1;229348:1;73429:1;76250:2;242641:1;248602:2;250961:1;242578:1;78227:1;262118:1;243057:1;264133:1;205923:1;258485:1;271975:1;248158:2;230978:1;206594:1;224221:2;254088:1;251570:1;266815:1;226166:1;231936:1;205990:1;248384:1;234742:1;213418:2;208892:1;183711:1;236784:1;264337:1;251479:1;258906:1;224258:1;243702:1;277663:1;222665:1;223877:1;243576:1;235735:1;260247:1;251809:1;207410:1;232580:1;250789:1;246669:2;83494:1;256781:1;274699:2;79922:1;278016:1;254796:1;235458:1;260105:1;71493:1;278928:1;194150:1;243390:1;83381:1;235642:1;232104:1;269087:1;258433:1;239085:1;210047:1;259377:1;204246:1;236663:1;236461:1;238756:2;220031:1;276718:1;232488:1;237646:1;270617:1;203263:1;233934:1;277869:1;251805:1;203376:1;270409:2;261336:1;232999:1;207421:1;245367:1;278124:1;70824:1;216393:1;269136:1;248465:1</Goals>|<YellowCards>277283:2;233064:1;82899:1;264349:1;163264:1;232580:1;74413:1;270519:1;79402:1;244472:1;232755:1;243702:1;213884:1;235805:1;70994:1;251809:1;237522:2;239231:1;241159:1;275048:1;274219:1;82968:1;248484:1;71998:1;277909:1;251570:1;79579:1;183711:1;258433:1;251555:1;206516:1;72281:1</YellowCards>|<RedCards>227678:1;278292:1;74360:1</RedCards>|<Trophies>111130=2:1</Tplyrgs>|<GroupStandings>true</GroupStandings>",

    -- [ Championship ]
    [144]  = "", 
    
    -- [ LA LIGA ]
    [533]  = "", 
    
    -- [ Segunda División ]
    [544]  = "", 
    
    -- [ SERIE A ]
    [311]  = "", 
    
    -- [ Serie B ]
    [322]  = "", 
    
    -- [ BUNDESLIGA ]
    [199]  = "", 
    
    -- [ 2. Bundesliga ]
    [200]  = "", 
    
    -- [ LIGUE 1 ]
    [166]  = "", 
    
    -- [ Ligue 2 ]
    [177]  = "", 
    
    -- [ Saudi League ]
    [350]  = "", 
    
    -- [ Bri Super League ]
    [2235] = "", 
    
    -- [ Pegadaian Liga 2 ]
    [2254] = "", 

    -- [ FA WSL ]
    [366]  = "", 
    
    -- [ Liga F ]
    [377]  = "", 
    
    -- [ Frauen-Bundesliga ]
    [388]  = "", 
    
    -- [ Serie A Femminile ]
    [399]  = ""  
    
}

local CustomCup = {}

do
    CustomCup.BND_TOURNAMENT_TYPE_LABEL = "bnd_tournament_type_toggle"
    CustomCup.BND_TOURNAMENT_TYPE_TEXT = "bnd_tournament_type_text"
    CustomCup.BND_TOURNAMENT_CREST = "bnd_tournament_crest"
    CustomCup.BND_PREV_TOURNAMENT_CREST = "bnd_prev_tournament_crest"
    CustomCup.BND_NEXT_TOURNAMENT_CREST = "bnd_next_tournament_crest"
    CustomCup.BND_TEAM_COUNT_LABEL = "bnd_number_of_teams_toggle"
    CustomCup.BND_TEAM_COUNT_TEXT = "bnd_team_count_text"
    CustomCup.BND_AUTO_FILL_LABEL = "bnd_auto_fills_toggle"
    CustomCup.BND_AUTO_FILL_TEXT = "bnd_auto_fill_text"
    CustomCup.BND_TEAM_GENDER_LABEL = "bnd_team_type_toggle"
    CustomCup.BND_TEAM_GENDER_TEXT = "bnd_team_type_text"
    CustomCup.BND_CUP_ID_LABEL = "bnd_tour_id_toggle"
    CustomCup.BND_CUP_ID_TEXT = "bnd_tour_id_text"
    CustomCup.BND_DESCRIPTION = "bnd_description"
    CustomCup.BND_TAB1_VISIBLE = "bnd_tab1_visible"
    CustomCup.BND_TAB2_VISIBLE = "bnd_tab2_visible"
    CustomCup.BND_TAB3_VISIBLE = "bnd_tab3_visible"
    CustomCup.BND_TAB4_VISIBLE = "bnd_tab4_visible"
    CustomCup.BND_TAB5_VISIBLE = "bnd_tab5_visible"
    CustomCup.ACT_NEXT_TOURNAMENT_TYPE = "act_next_tournament_type"
    CustomCup.ACT_PREV_TOURNAMENT_TYPE = "act_prev_tournament_type"
    CustomCup.ACT_NEXT_TEAM_COUNT = "act_next_team_count"
    CustomCup.ACT_PREV_TEAM_COUNT = "act_prev_team_count"
    CustomCup.ACT_NEXT_AUTO_FILL = "act_next_auto_fill"
    CustomCup.ACT_PREV_AUTO_FILL = "act_prev_auto_fill"
    CustomCup.ACT_NEXT_TEAM_GENDER = "act_next_team_gender"
    CustomCup.ACT_PREV_TEAM_GENDER = "act_prev_team_gender"
    CustomCup.ACT_NEXT_CUP_ID = "act_next_tour_id"
    CustomCup.ACT_PREV_CUP_ID = "act_prev_tour_id"
    CustomCup.ACT_CONFIRM_SETUP = "act_confirm_setup"
    CustomCup.ACT_BNT_CLICK = "act_btn_click"
    CustomCup.ACT_LOAD_GAME = "act_load_game"
end

GlobalTournamentSettings = GlobalTournamentSettings or {}
SavedTrophyData = SavedTrophyData or {}

local womenKeywords = {"Women", "W World Tour", "Féminine", "Frauen-Bundesliga", "NWSL", "Liga F"}
local function containsWomenKeyword(name)
    for _, keyword in ipairs(womenKeywords) do
        if string.find(name, keyword) then return true end
    end
    return false
end

function CustomCup:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = { settingsService = o.api("SettingsService") }   
    o.teamCountLists = {
        full = { { name = "8 Teams", value = 8 }, { name = "16 Teams", value = 16 }, { name = "24 Teams", value = 24 }, { name = "32 Teams", value = 32 }, { name = "48 Teams", value = 48 } },
        knockoutOnly = { { name = "8 Teams", value = 8 }, { name = "16 Teams", value = 16 }, { name = "32 Teams", value = 32 } },
        league = { { name = "8 Teams", value = 8 }, { name = "16 Teams", value = 16 }, { name = "20 Teams", value = 20 } },
        women = { { name = "8 Teams", value = 8 } }
    }
    
    o.allTournaments = {    	        
        { name = "UEFA Champions League", value = 1, availableTeamCounts = {32} },
        { name = "FIFA World Cup 2026", value = 2, availableTeamCounts = {32, 48} },
        { name = "UEFA Europa League", value = 3, availableTeamCounts = {32} },
        { name = "UEFA Conference League", value = 17, availableTeamCounts = {32} },
        { name = "FIFA Club World Cup", value = 15, availableTeamCounts = {32} },      
        { name = "Classic Tour", value = 22, availableTeamCounts = {32} },
        { name = "The Emirates FA Cup", value = 9, availableTeamCounts = {32} },
        { name = "Copa del Rey", value = 10, availableTeamCounts = {32} },
        { name = "Coppa Italia", value = 11, availableTeamCounts = {32} },
        { name = "Coupe de France", value = 18, availableTeamCounts = {32} },
        { name = "Dfb Pokal", value = 7, availableTeamCounts = {32} },
        { name = "Copa America", value = 25, availableTeamCounts = {16, 24, 32} },     
        { name = "Kratingdaeng Piala Indonesia", value = 29, availableTeamCounts = {32} },       
        { name = "AFC Champions League Elit", value = 24, availableTeamCounts = {32} },
        { name = "AFC Champions League Two", value = 31, availableTeamCounts = {32} },
        { name = "AFC Challenge League", value = 21, availableTeamCounts = {32} },
        { name = "CONMEBOL Libertadores", value = 4, availableTeamCounts = {32} },
        { name = "AFC Asian Cup Qatar 2023™", value = 34, availableTeamCounts = {16, 24} },
        { name = "UEFA Euro", value = 6, availableTeamCounts = {16, 24} },
        { name = "UEFA Nations League", value = 28, availableTeamCounts = {16, 24} },
        { name = "US Open Tour", value = 13, availableTeamCounts = {16, 24} },                
        { name = "Africa Cup Of Nations", value = 26, availableTeamCounts = {16, 24} },
        { name = "ASEAN Hyundai Cup 2026", value = 27, availableTeamCounts = {8} },
        { name = "Piala Presiden", value = 32, availableTeamCounts = {8} },
        { name = "Sea Games U-23", value = 23, availableTeamCounts = {8} },
        { name = "Asean Shopee Cup", value = 12, availableTeamCounts = {8} },
        { name = "Saudi Arab Tour", value = 50, availableTeamCounts = {8} },
        { name = "UEFA Women CL", value = 16, availableTeamCounts = {8} },
        { name = "FIFA Women World Cup", value = 35, availableTeamCounts = {8} },    
        { name = "EA Sports Cup", value = 14, availableTeamCounts = {32} }   
    }

    o.leagueTournamentsMen = {
        { name = "Premier League", value = 133, availableTeamCounts = {8,16,20} },
        { name = "Championship", value = 144, availableTeamCounts = {8,16,20} },
        { name = "LA LIGA", value = 533, availableTeamCounts = {8,16,20} },
        { name = "Segunda División", value = 544, availableTeamCounts = {8,16,20} },
        { name = "SERIE A", value = 311, availableTeamCounts = {8,16,20} },
        { name = "Serie B", value = 322, availableTeamCounts = {8,16,20} },
        { name = "BUNDESLIGA", value = 199, availableTeamCounts = {8,16,20} },
        { name = "2. Bundesliga", value = 200, availableTeamCounts = {8,16,20} },
        { name = "LIGUE 1", value = 166, availableTeamCounts = {8,16,20} },
        { name = "Ligue 2", value = 177, availableTeamCounts = {8,16,20} },
        { name = "Saudi League", value = 350, availableTeamCounts = {8,16,20} },
        { name = "Bri Super League", value = 2235, availableTeamCounts = {8,16,20} },
        { name = "Pegadaian Liga 2", value = 2254, availableTeamCounts = {8,16,20} }
    }

    o.leagueTournamentsWomen = {
        { name = "FA WSL", value = 366, availableTeamCounts = {8,16,20} },
        { name = "Liga F", value = 377, availableTeamCounts = {8,16,20} },
        { name = "Frauen-Bundesliga", value = 388, availableTeamCounts = {8,16,20} },
        { name = "Serie A Femminile", value = 399, availableTeamCounts = {8,16,20} }
    }
    
    o.options = {
        tournamentType = { { name = "Group + Knockout", value = 1 }, { name = "Knockout", value = 2 }, { name = "League", value = 3 } },        
        teamCount = o.teamCountLists.full,
        autoFill  = { { name = "No", value = false }, { name = "Yes", value = true } },
        teamGender = { { name = "Men's Team", value = "Men" }, { name = "Women's Team", value = "Women" } },
        tourId = {}
    }    
    
    o.options.menDefaultTours = {}
    o.options.womenDefaultTours = {}

    for _, tour in ipairs(o.allTournaments) do
        if containsWomenKeyword(tour.name) then
            table.insert(o.options.womenDefaultTours, tour)
        else
            table.insert(o.options.menDefaultTours, tour)
        end
    end

    o.selectedIndices = { tournamentType = 1, teamCount = 1, autoFill = 1, teamGender = 1, tourId = 1 }
    o.tournamentName = "Tournament"

    o:RegisterBindingsAndActions()
    o:PublishInitialData()
    
    o.tabBindings = { self.BND_TAB1_VISIBLE, self.BND_TAB2_VISIBLE, self.BND_TAB3_VISIBLE, self.BND_TAB4_VISIBLE, self.BND_TAB5_VISIBLE }
    for _, binding in ipairs(o.tabBindings) do o.im.Subscribe(binding, function() end) end
    o:HideSelections()
    o.im.Publish(self.BND_TAB1_VISIBLE, true)

    o.im.RegisterAction(self.ACT_BNT_CLICK, function(_, data)
        o:HideSelections()
        local tabIndex = data.buttonID + 1
        if o.tabBindings[tabIndex] then o.im.Publish(o.tabBindings[tabIndex], true) end
    end)
    
    return o
end

function CustomCup:RegisterBindingsAndActions()
    self.im.RegisterAction(self.ACT_NEXT_TOURNAMENT_TYPE, function() self:nextTournamentType() end)
    self.im.RegisterAction(self.ACT_PREV_TOURNAMENT_TYPE, function() self:prevTournamentType() end)
    self.im.Subscribe(self.BND_TOURNAMENT_TYPE_TEXT, function() self:updateTournamentTypeUI() end)
    self.im.Subscribe(self.BND_TOURNAMENT_CREST, function() self:updateTournamentTypeUI() end)
    self.im.Subscribe(self.BND_PREV_TOURNAMENT_CREST, function() self:updateTournamentTypeUI() end)
    self.im.Subscribe(self.BND_NEXT_TOURNAMENT_CREST, function() self:updateTournamentTypeUI() end)   
    self.im.RegisterAction(self.ACT_NEXT_TEAM_COUNT, function() self:nextTeamCount() end)
    self.im.RegisterAction(self.ACT_PREV_TEAM_COUNT, function() self:prevTeamCount() end)
    self.im.Subscribe(self.BND_TEAM_COUNT_TEXT, function() self:updateTeamCountUI() end)
    self.im.RegisterAction(self.ACT_NEXT_AUTO_FILL, function() self:nextAutoFill() end)
    self.im.RegisterAction(self.ACT_PREV_AUTO_FILL, function() self:prevAutoFill() end)
    self.im.Subscribe(self.BND_AUTO_FILL_TEXT, function() self:updateAutoFillUI() end)   
    self.im.RegisterAction(self.ACT_NEXT_TEAM_GENDER, function() self:nextTeamGender() end)
    self.im.RegisterAction(self.ACT_PREV_TEAM_GENDER, function() self:prevTeamGender() end)
    self.im.Subscribe(self.BND_TEAM_GENDER_TEXT, function() self:updateTeamGenderUI() end)    
    self.im.RegisterAction(self.ACT_NEXT_CUP_ID, function() self:nexttourId() end)
    self.im.RegisterAction(self.ACT_PREV_CUP_ID, function() self:prevtourId() end)
    self.im.Subscribe(self.BND_CUP_ID_TEXT, function() self:updatetourIdUI() end)  
    self.im.Subscribe(self.BND_DESCRIPTION, function() self:PublishDescription() end)
    self.im.RegisterAction(self.ACT_CONFIRM_SETUP, function() self:ConfirmAndProceed() end)
    self.im.RegisterAction(self.ACT_LOAD_GAME, function() self:LoadGameProcess() end)
end

function CustomCup:navigate(settingName, direction)
    local options = self.options[settingName]
    local currentIndex = self.selectedIndices[settingName]
    local newIndex = currentIndex + direction   
    if newIndex > #options then newIndex = 1 elseif newIndex < 1 then newIndex = #options end    
    self.selectedIndices[settingName] = newIndex
end

function CustomCup:nextTournamentType() self:navigate("tournamentType", 1); self:updateTournamentTypeUI() end
function CustomCup:prevTournamentType() self:navigate("tournamentType", -1); self:updateTournamentTypeUI() end
function CustomCup:nextTeamCount() self:navigate("teamCount", 1); self:updateTeamCountUI() end
function CustomCup:prevTeamCount() self:navigate("teamCount", -1); self:updateTeamCountUI() end
function CustomCup:nexttourId() self:navigate("tourId", 1); self:updatetourIdUI() end
function CustomCup:prevtourId() self:navigate("tourId", -1); self:updatetourIdUI() end
function CustomCup:nextAutoFill() self:navigate("autoFill", 1); self:updateAutoFillUI() end
function CustomCup:prevAutoFill() self:navigate("autoFill", -1); self:updateAutoFillUI() end
function CustomCup:nextTeamGender() self:navigate("teamGender", 1); self:updateTeamGenderUI() end
function CustomCup:prevTeamGender() self:navigate("teamGender", -1); self:updateTeamGenderUI() end

function CustomCup:refreshTeamCountList()
    local tourType = self.options.tournamentType[self.selectedIndices.tournamentType].name
    local gender = self.options.teamGender[self.selectedIndices.teamGender].value
    if gender == "Women" then
        self.options.teamCount = (tourType == "League") and self.teamCountLists.league or self.teamCountLists.women
    else
        if tourType == "League" then self.options.teamCount = self.teamCountLists.league
        elseif tourType == "Knockout" then self.options.teamCount = self.teamCountLists.knockoutOnly
        else self.options.teamCount = self.teamCountLists.full end
    end
    if self.selectedIndices.teamCount > #self.options.teamCount then self.selectedIndices.teamCount = 1 end
end

function CustomCup:updateTournamentTypeUI()
    local options = self.options.tournamentType
    local totalOptions = #options
    local currentIndex = self.selectedIndices.tournamentType
    local currentOpt = options[currentIndex]
    if not currentOpt then return end
    self:refreshTeamCountList()
    self:updateTourIdListBasedOnSelections()
    self:updateTeamCountUI()
    local prevIndex = (currentIndex - 2 + totalOptions) % totalOptions + 1
    local nextIndex = (currentIndex % totalOptions) + 1 
    self.im.Publish(self.BND_TOURNAMENT_TYPE_LABEL, { data = {{ name = currentOpt.name }}, index = 0 })
    self.im.Publish(self.BND_TOURNAMENT_TYPE_TEXT, currentOpt.name)
    self.im.Publish(self.BND_TOURNAMENT_CREST, { name = "$Set_Cup", id = currentOpt.value })
    self.im.Publish(self.BND_PREV_TOURNAMENT_CREST, { name = "$Set_Cup", id = options[prevIndex].value })
    self.im.Publish(self.BND_NEXT_TOURNAMENT_CREST, { name = "$Set_Cup", id = options[nextIndex].value })   
    self:PublishDescription()
end

function CustomCup:updateTourIdListBasedOnSelections()
    local genderOpt = self.options.teamGender[self.selectedIndices.teamGender]
    local teamCountOpt = self.options.teamCount[self.selectedIndices.teamCount]
    local teamCount = teamCountOpt and teamCountOpt.value or 8
    local tourType = self.options.tournamentType[self.selectedIndices.tournamentType].name
    local baseTournaments = (tourType == "League") and ((genderOpt.value == "Women") and self.leagueTournamentsWomen or self.leagueTournamentsMen) or ((genderOpt.value == "Women") and self.options.womenDefaultTours or self.options.menDefaultTours)
    local filteredTournaments = {}   
    for _, tour in ipairs(baseTournaments) do
        for _, availableCount in ipairs(tour.availableTeamCounts) do
            if availableCount == teamCount then table.insert(filteredTournaments, tour); break end
        end
    end   
    if #filteredTournaments == 0 then filteredTournaments = baseTournaments end    
    self.options.tourId = filteredTournaments
    if self.selectedIndices.tourId > #self.options.tourId then self.selectedIndices.tourId = 1 end
    self:updatetourIdUI()
end

function CustomCup:updateTeamCountUI()
    self:refreshTeamCountList()
    local current = self.options.teamCount[self.selectedIndices.teamCount]
    if current then self.im.Publish(self.BND_TEAM_COUNT_TEXT, current.name); self:updateTourIdListBasedOnSelections(); self:PublishDescription() end
end

function CustomCup:updateAutoFillUI()
    local current = self.options.autoFill[self.selectedIndices.autoFill]
    if current then self.im.Publish(self.BND_AUTO_FILL_LABEL, { data = {{ name = current.name }}, index = 0 }); self.im.Publish(self.BND_AUTO_FILL_TEXT, current.name); self:PublishDescription() end
end

function CustomCup:updatetourIdUI()
    local current = self.options.tourId[self.selectedIndices.tourId]
    if current then self.im.Publish(self.BND_CUP_ID_TEXT, current.name); self:PublishDescription() end
end

function CustomCup:updateTeamGenderUI()
    local current = self.options.teamGender[self.selectedIndices.teamGender]
    if current then self.im.Publish(self.BND_TEAM_GENDER_LABEL, { data = {{ name = current.name }}, index = 0 }); self.im.Publish(self.BND_TEAM_GENDER_TEXT, current.name); self:refreshTeamCountList(); self:updateTeamCountUI() end
end

function CustomCup:PublishInitialData()
    self:updateTournamentTypeUI(); self:updateTeamCountUI(); self:updateAutoFillUI(); self:updatetourIdUI(); self:updateTeamGenderUI()
end

function CustomCup:PublishDescription()
    local currentTour = self.options.tourId[self.selectedIndices.tourId]
    local tourName = currentTour and currentTour.name or "Tournament"
    local desc = string.format("Pilih turnamen '%s' lalu tekan Load Game untuk melanjutkan save turnamen ini.", tourName)
    self.im.Publish(self.BND_DESCRIPTION, desc)
end

function CustomCup:ConfirmAndProceed()
    local selectedTourId = self.options.tourId[self.selectedIndices.tourId].value
    local selectedTeamOpt = self.options.teamCount[self.selectedIndices.teamCount]
    local selectedTournamentType = self.options.tournamentType[self.selectedIndices.tournamentType].name    
    local selectedFormatOpt = self.options.autoFill[self.selectedIndices.autoFill]
    
    GlobalTournamentSettings = {
        tourId = selectedTourId,
        teamCount = tonumber(selectedTeamOpt.value) or 32,
        tournamentType = selectedTournamentType,
        tournamentName = self.tournamentName,
        selectedTourId = selectedTourId,
        isKnockoutOnly = (selectedTournamentType == "Knockout"),
        isLeagueMode = (selectedTournamentType == "League"),
        isTwoLegs = selectedFormatOpt.value,
        isLoadedGame = false
    }
    
    if GlobalTournamentSettings.isLeagueMode then self.nav.Event(nil, "evt_goto_team_select_league") 
    elseif GlobalTournamentSettings.isKnockoutOnly then self.nav.Event(nil, "evt_goto_team_select_knockout") 
    else self.nav.Event(nil, "evt_group_stage") end
end

function CustomCup:LoadGameProcess()
    local currentTour = self.options.tourId[self.selectedIndices.tourId]
    if not currentTour then 
        self.im.Publish(self.BND_DESCRIPTION, "Pilih turnamen yang valid terlebih dahulu!")
        return 
    end
    
    local tourId = currentTour.value
    local rawSaveString = TournamentSaveDatabase[tourId] or ""
    
    if rawSaveString == "" or rawSaveString:find("<Version>") == nil then 
        local popupMsg = "Belum ada kode save untuk:\n" .. currentTour.name .. " (ID: " .. tostring(tourId) .. ")"
        
        self.nav.Event(nil, "evt_show_popup", {
            title = "INFO",
            message = popupMsg,
            buttons = { { icon = "$FooterIconYes", label = "OK", clickEvents = { "evt_hide_popup" } } }
        })
        return 
    end
    
    self.im.Publish(self.BND_DESCRIPTION, "Memuat Save: " .. currentTour.name)
    
    local savedData = {}
    for key, val in string.gmatch(rawSaveString, "<([^>]+)>([^<]*)</%1>") do
        savedData[key] = val:gsub("^%s+", ""):gsub("%s+$", "")
    end   
    
    local savedTeamCount = tonumber(savedData.TeamCount) or 32
    local savedFixtureIndex = tonumber(savedData.FixtureIndex) or 0       
    local teamId = tonumber(savedData.TeamID) or 1
    local savedType = savedData.TournamentType or "Group + Knockout"     
    
    GlobalTournamentSettings = {
        tourId = tourId,
        teamCount = savedTeamCount,
        tournamentType = savedType,
        tournamentName = currentTour.name,
        selectedTourId = tourId,
        isKnockoutOnly = (savedType == "Knockout"),
        isLeagueMode = (savedType == "League"),
        isTwoLegs = true,
        isLoadedGame = true
    }      
    
    currentTourInfo = currentTourInfo or {}
    currentTourInfo[tourId] = { tourIndex = tourId, homeID = teamId, stage = "GROUP" }       
    
    QuickTourGrouping = QuickTourGrouping or {}
    QuickTourGrouping[tourId] = {}
    if savedData.Fixtures and savedData.Fixtures ~= "" then
        for row in string.gmatch(savedData.Fixtures, "[^;]+") do
            local match = {}
            local index = 1
            for value in string.gmatch(row, "[^,]+") do
                if index == 5 or index == 7 or index == 8 then match[index] = (tonumber(value) == 1)
                elseif index == 9 then match[index] = value
                else match[index] = tonumber(value) or 0 end
                index = index + 1
            end
            table.insert(QuickTourGrouping[tourId], match)
        end
    end
    
    TournamentStats = TournamentStats or {}
    TournamentStats[tourId] = TournamentStats[tourId] or { Goals = {}, Appearances = {}, YellowCards = {}, RedCards = {} }      
    
    if savedData.Goals and savedData.Goals ~= "" then
        for goalEntry in string.gmatch(savedData.Goals, "[^;]+") do
            local cardId, count = string.match(goalEntry, "(%d+):(%d+)")
            if cardId and count then
                TournamentStats[tourId].Goals[tonumber(cardId)] = tonumber(count)
            end
        end
    end
    
    if savedData.YellowCards and savedData.YellowCards ~= "" then
        for ycEntry in string.gmatch(savedData.YellowCards, "[^;]+") do
            local cardId, count = string.match(ycEntry, "(%d+):(%d+)")
            if cardId and count then
                TournamentStats[tourId].YellowCards[tonumber(cardId)] = tonumber(count)
            end
        end
    end
    
    if savedData.RedCards and savedData.RedCards ~= "" then
        for rcEntry in string.gmatch(savedData.RedCards, "[^;]+") do
            local cardId, count = string.match(rcEntry, "(%d+):(%d+)")
            if cardId and count then
                TournamentStats[tourId].RedCards[tonumber(cardId)] = tonumber(count)
            end
        end
    end        
    
    SavedTrophyData = SavedTrophyData or {}
    if savedData.Trophies and savedData.Trophies ~= "" then
        for teamEntry in string.gmatch(savedData.Trophies, "[^;]+") do
            (function()
                local tId, rest = string.match(teamEntry, "(%d+)=(.+)")
                if tId and rest then
                    SavedTrophyData[tId] = { totalTeamTrophies = 0, tournaments = {} }
                    local totalCalc = 0
                    for tourPart in string.gmatch(rest, "[^,]+") do
                        local tid, count = string.match(tourPart, "(%d+):(%d+)")
                        if tid and count then
                            local cNum = tonumber(count) or 0
                            SavedTrophyData[tId].tournaments[tid] = cNum
                            totalCalc = totalCalc + cNum
                        end
                    end
                    SavedTrophyData[tId].totalTeamTrophies = totalCalc
                end
            end)()
        end
    end        
    
    currentPlayedMatchIndex = savedFixtureIndex  
    self.nav.Event(nil, "evt_group_stage")
end

function CustomCup:HideSelections()
    for _, binding in ipairs(self.tabBindings or {}) do self.im.Publish(binding, false) end
end

function CustomCup:finalize()
    local actions = {
        self.ACT_NEXT_TOURNAMENT_TYPE, self.ACT_PREV_TOURNAMENT_TYPE,
        self.ACT_NEXT_TEAM_COUNT, self.ACT_PREV_TEAM_COUNT,
        self.ACT_NEXT_AUTO_FILL, self.ACT_PREV_AUTO_FILL,
        self.ACT_NEXT_CUP_ID, self.ACT_PREV_CUP_ID,
        self.ACT_NEXT_TEAM_GENDER, self.ACT_PREV_TEAM_GENDER,
        self.ACT_CONFIRM_SETUP, self.ACT_BNT_CLICK, self.ACT_LOAD_GAME
    }
    for _, action in ipairs(actions) do self.im.UnregisterAction(action) end
end

return CustomCup
