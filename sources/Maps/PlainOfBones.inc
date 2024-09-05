  (
  ID           : 'PLAINOFBONES';    
  Level        : 10;
  Items        : PotionLevel1 + PotionLevel2 + WeaponLevel1 + AmmuntLevel1 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'SKELETON,SKELETONMAGE,DARKEYE,';
  Underground  : False;  
  Village      : False;
  GenID        : G_STONY_FIELD;
  DecorType    : 'STONE';
  DecTypSize   : 50;
  DecTypCount  : 150;
  IsAutoEnt    : False;
  PrevMap      : 'GRAVEYARDS';
  NextMap      : 'BLOODYFIELDS';
  AltNextMap   : 'MOONCAVE';
  IsAltMapEnt  : False;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlGrass;
  FloorRes     : 'GRASS3';
  WallRes      : '';
  ),

  (
  ID           : 'MOONCAVE';
  Level        : 11;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1 + AmmuntLevel2 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'DARKEYE,BAT,BLUEBAT,CAVEBAT,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : 'BONE';
  DecTypSize   : 45;
  DecTypCount  : 125;
  IsAutoEnt    : False;
  PrevMap      : 'PLAINOFBONES';
  NextMap      : 'GROTTOOFCLAWS';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR1';
  WallRes      : 'WALL2';
  ),

  (
  ID           : 'GROTTOOFCLAWS';
  Level        : 12;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1 + AmmuntLevel2 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'DARKEYE,BAT,BLUEBAT,CAVEBAT,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : 'BONE';
  DecTypSize   : 45;
  DecTypCount  : 125;
  IsAutoEnt    : False;
  PrevMap      : 'MOONCAVE';
  NextMap      : '';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR1';
  WallRes      : 'WALL2';
  ),
