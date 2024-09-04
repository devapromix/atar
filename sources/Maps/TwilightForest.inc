  (
  ID           : 'TWILIGHTFOREST';
  Level        : 5;
  Items        : PotionLevel1;
  Creatures    : 'BIGSPIDER,REDSPIDER';
  Underground  : False;
  Village      : False;
  GenID        : G_DARK_FOREST;
  DecorType    : dtWeb;
  DecTypSize   : 10;
  DecTypCount  : 50;
  IsAutoEnt    : False;    
  PrevMap      : 'STONYFIELD';
  NextMap      : 'FORESTMARSH'; 
  AltNextMap   : 'DENOFTHIEVES';
  IsAltMapEnt  : False;
  IsVillageEnt : True;
  IsTraps      : False;
  FloorTile    : tlGrass;
  FloorRes     : 'GRASS5';
  WallRes      : '';
  ),

  (
  ID           : 'DENOFTHIEVES';
  Level        : 6;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1;
  Creatures    : 'CAVESPIDER,REDSPIDER,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : dtWeb;
  DecTypSize   : 30;
  DecTypCount  : 90;
  IsAutoEnt    : False;
  PrevMap      : 'TWILIGHTFOREST';
  NextMap      : '';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : tlFloor;
  FloorRes     : 'FLOOR2';
  WallRes      : 'WALL2';
  ),
  