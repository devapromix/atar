  (
  ID           : 'SPIDERFOREST';
  Level        : 1;
  Items        : PotionLevel1;
  Creatures    : 'BIGSPIDER,REDSPIDER';
  Underground  : False;
  Village      : False;
  GenID        : G_DARK_FOREST;
  DecorType    : dtWeb;
  DecTypSize   : 10;
  DecTypCount  : 50;
  IsAutoEnt    : False;    
  PrevMap      : '';
  NextMap      : 'THEUNDERGROUNDP'; 
  AltNextMap   : 'SPIDERCAVERN1';
  IsAltMapEnt  : False;
  IsVillageEnt : True;
  IsTraps      : False;
  FloorTile    : tlGrass;
  FloorRes     : 'GRASS5';
  WallRes      : '';
  ),

  (
  ID           : 'SPIDERCAVERN1';
  Level        : 2;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1;
  Creatures    : 'CAVESPIDER,REDSPIDER,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : dtWeb;
  DecTypSize   : 30;
  DecTypCount  : 90;
  IsAutoEnt    : False;
  PrevMap      : 'SPIDERFOREST';
  NextMap      : '';
  AltNextMap   : 'SPIDERCAVERN2';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR2';
  WallRes      : 'WALL2';
  ),

  (
  ID           : 'SPIDERCAVERN2';
  Level        : 3;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1 + RarityLevel1;
  Creatures    : 'CAVESPIDER,REDSPIDER,BAT,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : dtWeb;
  DecTypSize   : 50;
  DecTypCount  : 150;
  IsAutoEnt    : False;
  PrevMap      : 'SPIDERCAVERN1';
  NextMap      : '';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR2';
  WallRes      : 'WALL2';
  ),


