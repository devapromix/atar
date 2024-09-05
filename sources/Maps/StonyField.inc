  (
  ID           : 'STONYFIELD';    
  Level        : 4;
  Items        : PotionLevel1 + PotionLevel2 + WeaponLevel1 + AmmuntLevel1 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'SKELETON,SKELETONMAGE,DARKEYE,';
  Underground  : False;  
  Village      : False;
  GenID        : G_STONY_FIELD;
  DecorType    : 'STONE';
  DecTypSize   : 50;
  DecTypCount  : 150;
  IsAutoEnt    : False;
  PrevMap      : 'VALLEYOFBEAR';
  NextMap      : 'TWILIGHTFOREST';
  AltNextMap   : 'BATCAVE';
  IsAltMapEnt  : False;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlGrass;
  FloorRes     : 'GRASS3';
  WallRes      : '';
  ),

  (
  ID           : 'BATCAVE';
  Level        : 5;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1 + AmmuntLevel2 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'DARKEYE,BAT,BLUEBAT,CAVEBAT,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : 'BONE';
  DecTypSize   : 45;
  DecTypCount  : 125;
  IsAutoEnt    : False;
  PrevMap      : 'STONYFIELD';
  NextMap      : '';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR1';
  WallRes      : 'WALL2';
  ),
