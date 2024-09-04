  (
  ID           : 'BLOODYFIELDS';    
  Level        : 11;
  Items        : PotionLevel1 + PotionLevel2 + WeaponLevel1 + AmmuntLevel1 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'SKELETON,SKELETONMAGE,DARKEYE,';
  Underground  : False;  
  Village      : False;
  GenID        : G_STONY_FIELD;
  DecorType    : dtStone;
  DecTypSize   : 50;
  DecTypCount  : 150;
  IsAutoEnt    : False;
  PrevMap      : 'PLAINOFBONES';
  NextMap      : '';
  AltNextMap   : 'PASSAGEOFTHEDEAD';
  IsAltMapEnt  : False;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlGrass;
  FloorRes     : 'GRASS3';
  WallRes      : '';
  ),

  (
  ID           : 'PASSAGEOFTHEDEAD';
  Level        : 12;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1 + AmmuntLevel2 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'DARKEYE,BAT,BLUEBAT,CAVEBAT,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : dtBone;
  DecTypSize   : 45;
  DecTypCount  : 125;
  IsAutoEnt    : False;
  PrevMap      : 'BLOODYFIELDS';
  NextMap      : 'CITADELOFCHAOS';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR1';
  WallRes      : 'WALL2';
  ),

  (
  ID           : 'CITADELOFCHAOS';
  Level        : 13;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1 + AmmuntLevel2 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'DARKEYE,BAT,BLUEBAT,CAVEBAT,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : dtBone;
  DecTypSize   : 45;
  DecTypCount  : 125;
  IsAutoEnt    : False;
  PrevMap      : 'PASSAGEOFTHEDEAD';
  NextMap      : 'STONEWORMLAIR';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR1';
  WallRes      : 'WALL2';
  ),

  (
  ID           : 'STONEWORMLAIR';
  Level        : 14;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1 + AmmuntLevel2 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'DARKEYE,BAT,BLUEBAT,CAVEBAT,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : dtBone;
  DecTypSize   : 45;
  DecTypCount  : 125;
  IsAutoEnt    : False;
  PrevMap      : 'CITADELOFCHAOS';
  NextMap      : 'ASYLUMOFDEATH';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR1';
  WallRes      : 'WALL2';
  ),

  (
  ID           : 'ASYLUMOFDEATH';
  Level        : 15;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1 + AmmuntLevel2 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'DARKEYE,BAT,BLUEBAT,CAVEBAT,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : dtBone;
  DecTypSize   : 45;
  DecTypCount  : 125;
  IsAutoEnt    : False;
  PrevMap      : 'STONEWORMLAIR';
  NextMap      : '';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR1';
  WallRes      : 'WALL2';
  ),
