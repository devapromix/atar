  (
  ID           : 'VALLEYOFBEAR';
  Level        : 3;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1;
  Creatures    : 'GOBLIN,DARKGOBLIN,BAT,';
  Underground  : False;
  Village      : False;
  GenID        : G_DARK_FOREST;
  DecorType    : '';
  DecTypSize   : 0;
  DecTypCount  : 0;
  IsAutoEnt    : False;
  PrevMap      : 'THEUNDERGROUNDP';
  NextMap      : 'STONYFIELD';
  AltNextMap   : 'INTERNALPIT';
  IsAltMapEnt  : False;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : 'GRASS';
  FloorRes     : 'GRASS1';
  WallRes      : 'WALL3';
  ),

  (
  ID           : 'INTERNALPIT';
  Level        : 4;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1;
  Creatures    : 'DARKGOBLIN,CAVEGOBLIN,CAVEBAT,DARKEYE,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : 'BONE';
  DecTypSize   : 20;
  DecTypCount  : 50;
  IsAutoEnt    : False;
  PrevMap      : 'VALLEYOFBEAR';
  NextMap      : 'CAVEOFDARKNESS';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : 'FLOOR';
  FloorRes     : 'FLOOR1';
  WallRes      : 'WALL2';
  ),

  (
  ID           : 'CAVEOFDARKNESS';
  Level        : 5;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1 + AmmuntLevel2 + RarityLevel1 + ScrollLevel1;
  Creatures    : 'DARKGOBLIN,CAVEGOBLIN,CAVEBAT,DARKEYE,DARKEYE,TUORG,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : 'BONE';
  DecTypSize   : 35;
  DecTypCount  : 105;
  IsAutoEnt    : False;
  PrevMap      : 'INTERNALPIT';
  NextMap      : '';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : 'FLOOR';
  FloorRes     : 'FLOOR1';
  WallRes      : 'WALL2';
  ),
