  (
  ID           : 'BLACKMARSH';
  Level        : 7;
  Items        : PotionLevel1;
  Creatures    : 'BIGSPIDER,REDSPIDER';
  Underground  : False;
  Village      : False;
  GenID        : G_DARK_FOREST;
  DecorType    : 'WEB';
  DecTypSize   : 10;
  DecTypCount  : 50;
  IsAutoEnt    : False;    
  PrevMap      : 'FORESTMARSH';
  NextMap      : 'BADLANDS'; 
  AltNextMap   : 'BLACKCAVE';
  IsAltMapEnt  : False;
  IsVillageEnt : True;
  IsTraps      : False;
  FloorTile    : 'GRASS';
  FloorRes     : 'GRASS5';
  WallRes      : '';
  ),

  (
  ID           : 'SWAMPYPIT';
  Level        : 8;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1;
  Creatures    : 'CAVESPIDER,REDSPIDER,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : 'WEB';
  DecTypSize   : 30;
  DecTypCount  : 90;
  IsAutoEnt    : False;
  PrevMap      : 'BLACKMARSH';
  NextMap      : 'BLACKCAVEPIT';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : 'FLOOR';
  FloorRes     : 'FLOOR2';
  WallRes      : 'WALL2';
  ),

  (
  ID           : 'BLACKCAVEPIT';
  Level        : 9;
  Items        : PotionLevel1 + WeaponLevel1 + AmmuntLevel1;
  Creatures    : 'CAVESPIDER,REDSPIDER,';
  Underground  : True;
  Village      : False;
  GenID        : G_CAVES;
  DecorType    : 'WEB';
  DecTypSize   : 30;
  DecTypCount  : 90;
  IsAutoEnt    : False;
  PrevMap      : 'BLACKCAVE';
  NextMap      : '';
  AltNextMap   : '';
  IsAltMapEnt  : True;
  IsVillageEnt : False;
  IsTraps      : True;
  FloorTile    : 'FLOOR';
  FloorRes     : 'FLOOR2';
  WallRes      : 'WALL2';
  ),

  


