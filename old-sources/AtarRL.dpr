program AtarRL;

{
v. 0.01
* Рандомные подземелья.
* Враги (пока 2 вида - пауки и гоблины, есть ИИ). По 3 разновидности каждого существа.
* Ближний бой.
* Алтари (колодцы).
* Загрузка и сохранение.
* Таблица рекордов.

v. 0.02
* Тайминг и новый атрибут - Скорость.
* Предметы на полу и их поднятие по кл. G (инвентаря еще нет).
* Повышение уровня и прокачка аттрибутов.
* Подстраивание под размер экрана.

v. 0.03
* Полностью рабочий инвентарь.
* Одетые вещи отображаются на персонаже.    
* Добавлены зелья здоровья и маны.
* Добавлены новые враги: слизни, скелеты и скелеты-маги.
* Дистанционный бой у мобов.
* Отравление игрока мобами.
* Окно растягивается.
* Ключи -r (размер окна, например, -r800x600) и -d (отладочный режим)

v. 0.04
* Добавлены предметы: ключи, разнообразные зелья (кубическое зелье, масло).
* Добавлены сундуки двух типов.
* Добавлена алхимия (зелья можно смешивать).
* Добавлены декораторы (камни, пятна крови, кости и т. д.).
* Добавлен новый враг: Magan - змеевидное существо, плюющееся ядом.
* Добавлена сцена подбора нескольких предметов с одного тайла.
* Добавлена сцена подробной информации о персонаже.
* Новый ключ -s задает размер шрифта в игре.

v. 0.05   
* Добавлена сцена с настройками.
* Игра переведена на русский язык.
* Размер шрифта можно менять из меню.
* Добавлено динамическое освещение.
* Новый ключ -l отключает динамическое освещение.
* Добавлены новые декораторы (факела, светильники).
* Расширен список алхимических рецептов.
* Ключ -a сохраняет в файл все рецепты.
* Добавлены новые враги: Dark Eye, Necromancer.

v. 0.06
* Добавлены новые растения: тамарилис.
* Добавлены новые эликсиры и пустые колбы для зельеварения.
* Расширен список алхимических рецептов.
* Добавлены новые враги: Slime, Tuorg.
* Добавлены новые топоры, кольца и амулеты.  
* Игра свертывается в трей.
* Добавлены бочки.
* Добавлены кузнечные молоты для ремонта экипировки.
* Добавлен дистанционный бой, луки, арбалеты и команды Shoot и Look.
* В настройках можно выбрать размер тайлов: 32, 48 или 64.

v. 0.07
* Появилась заставка. Игра переименована в AtarRL.
* Добавлено время, календарь и команды Wait и Rest.
* Добавлена справка (F1) по клавишам управления.
* Добавлены расы и сцена выбора расы персонажа.
* Добавлены навыки. Расам добавлены расовые навыки.
* Добавлена команда "Обнаружение ловушек" - клавиша D.
* Добавлены некоторые магические свитки.

v. 0.08
* Локации поделены на наземные и подземные.
* Добавлены сублокации, бонусные локации и скрытые локации.
* Добавлены новые магические свитки.
* Добавлены новые эликсиры.
* Доработана сцена выбора расы персонажа.

v. 0.09
* Добавлен свиток "Глаз Чародея", показывающий невидимых монстров на миникарте.
* Добавлен свиток "Снятие Эффектов", снимающий все эффекты с персонажа, в том числе и позитивные :)
* Добавлен свиток "Починить Все"; ремонтирует все предметы в инвентаре.
}



uses
  uLostMemory in 'uLostMemory.pas',
  Windows,
  Forms,
  uMain in 'uMain.pas' {fMain},
  uZip in 'uZip.pas',
  uScenes in 'uScenes.pas',
  uSceneGame in 'uSceneGame.pas',
  uCreatures in 'uCreatures.pas',
  uGraph in 'uGraph.pas',
  uMap in 'uMap.pas',
  uSceneMenu in 'uSceneMenu.pas',
  uScene in 'uScene.pas',
  uUtils in 'uUtils.pas',
  uBox in 'uBox.pas',
  uItem in 'uItem.pas',
  uTrap in 'uTrap.pas',
  uScript in 'uScript.pas',
  uTile in 'uTile.pas',
  uScreenshot in 'uScreenshot.pas',
  uLog in 'uLog.pas',
  uSceneAbout in 'uSceneAbout.pas',
  uGame in 'uGame.pas',
  uSceneName in 'uSceneName.pas',
  uSceneRecords in 'uSceneRecords.pas',
  uSceneLoad in 'uSceneLoad.pas',
  uScores in 'uScores.pas',
  uColor in 'uColor.pas',
  uName in 'uName.pas',
  uMapGenerator in 'uMapGenerator.pas',
  uAStar in 'uAStar.pas',
  uError in 'uError.pas',
  uSceneLevelUp in 'uSceneLevelUp.pas',
  uInv in 'uInv.pas',
  uSceneInv in 'uSceneInv.pas',
  uSceneItem in 'uSceneItem.pas',
  uProjectiles in 'uProjectiles.pas',
  uTempSys in 'uTempSys.pas',
  uSceneItems in 'uSceneItems.pas',
  uDecorator in 'uDecorator.pas',
  uSceneChar in 'uSceneChar.pas',
  uSceneSettings in 'uSceneSettings.pas',
  uSettings in 'uSettings.pas',
  uLang in 'uLang.pas',
  uLight in 'uLight.pas',
  uNews in 'uNews.pas',
  uEffect in 'uEffect.pas',
  uLook in 'uLook.pas',
  uResources in 'uResources.pas',
  uDocs in 'uDocs.pas',
  uSceneBaseMenu in 'uSceneBaseMenu.pas',
  uSceneBaseGame in 'uSceneBaseGame.pas',
  uTime in 'uTime.pas',
  uSceneHelp in 'uSceneHelp.pas',
  uSceneRace in 'uSceneRace.pas',
  uRace in 'uRace.pas',
  uSkill in 'uSkill.pas',
  uEntity in 'uEntity.pas',
  uBar in 'uBar.pas',
  uMiniMap in 'uMiniMap.pas',
  uCustomMap in 'uCustomMap.pas',
  uRandItems in 'uRandItems.pas',
  uSceneIntro in 'uSceneIntro.pas',
  uPC in 'uPC.pas',
  uBaseCreature in 'uBaseCreature.pas',
  uCreature in 'uCreature.pas',
  uEnemy in 'uEnemy.pas',
  uFormulas in 'uFormulas.pas',
  uGlobalMap in 'uGlobalMap.pas',
  uStatistics in 'uStatistics.pas',
  uSceneStatistics in 'uSceneStatistics.pas',
  uTown in 'uTown.pas';

{$R *.res}

var UniqueMapping: THandle;

begin
  UniqueMapping := CreateFileMapping($ffffffff,
    nil, PAGE_READONLY, 0, 32,'m6gh7jq2lb6mbpfrwchmaltdr45');
  if UniqueMapping = 0 then Halt else
    if GetLastError = ERROR_ALREADY_EXISTS then Halt;
  Application.Initialize;
  Application.Title := 'AtarRL';
  Application.CreateForm(TfMain, fMain);
  if ParamCraftDoc then Items.MakeCraftDoc;
  Application.Run;
end.
