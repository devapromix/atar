unit Trollhunter.Scene.Item;

interface

uses
  Classes,
  Graphics,
  Windows,
  Trollhunter.Scene;

type
  TSceneItem = class(TScene)
  private
    FMenuCount: Integer;
    Icon: Graphics.TBitmap;
    Commands: string;
    FCursorPos: Integer;
    FItemIndex: Integer;
    procedure Drink(I: Integer);
    procedure Drop(I: Integer);
    procedure Read(I: Integer);
    procedure Use(I: Integer);
    procedure SetCursorPos(const Value: Integer);
    procedure SetItemIndex(const Value: Integer);
  public
    property CursorPos: Integer read FCursorPos write SetCursorPos;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    function KeyIDToInvItemID(I: Integer): Integer;
    procedure Equip(I: Integer; IsShowLog: Boolean = True);
    procedure UnEquip(I: Integer; IsShowLog: Boolean = True);
    procedure KeyPress(var Key: Char); override;
    procedure Render(); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    constructor Create;
    destructor Destroy; override;
  end;

var
  SceneItem: TSceneItem;

implementation

uses
  SysUtils,
  Trollhunter.Error,
  Trollhunter.Log,
  Trollhunter.Creatures,
  Trollhunter.Scenes,
  Trollhunter.Scene.Inv,
  Trollhunter.Item,
  Trollhunter.Graph,
  Trollhunter.Game,
  Trollhunter.Scene.Game,
  Trollhunter.Color,
  Trollhunter.Utils,
  Trollhunter.Map,
  Trollhunter.Map.Tiles,
  Trollhunter.Lang,
  Trollhunter.Skill, Trollhunter.Item.Pattern;

{ TSceneItem }

constructor TSceneItem.Create;
begin
  Icon := Graphics.TBitmap.Create;
  FMenuCount := 0;
  CursorPos := 0;
end;

destructor TSceneItem.Destroy;
begin
  Icon.Free;
  inherited;
end;

procedure TSceneItem.Equip(I: Integer; IsShowLog: Boolean = True);
var
  V, J: Integer;
  // B: Boolean;
begin
  try
    V := KeyIDToInvItemID(I);
    { B := True;{((DungeonItems[V].MaxTough > 0)
      and (Creatures.PC.Inv.GetTough(I) > 0))
      or (DungeonItems[V].MaxTough = 0); }
    for J := 1 to 26 do
      if (ItemPatterns.Patterns[V].Category = ItemPatterns.Patterns
        [KeyIDToInvItemID(J)].Category) then
        UnEquip(J);
    // if (B and (DungeonItems[V].Category in WeapArmSet))
    // or (DungeonItems[V].Category in AmuRingSet)
    if Items.IsCategory(ItemPatterns.Patterns[V].Category, EquipmentCategories)
      and Creatures.PC.Inv.Equip(I) then
    begin
      Creatures.PC.Prop.MinDamage := Creatures.PC.Prop.MinDamage +
        ItemPatterns.Patterns[V].MinDamage;
      Creatures.PC.Prop.MaxDamage := Creatures.PC.Prop.MaxDamage +
        ItemPatterns.Patterns[V].MaxDamage;
      Creatures.PC.Prop.Protect := Creatures.PC.Prop.Protect +
        ItemPatterns.Patterns[V].Protect;
      Creatures.PC.Calc;

      if IsShowLog then
        Log.Add(Format(Language.GetLang(96),
          [Language.GetItemLang(ItemPatterns.Patterns[V].ID)]));
      // You equip a %s.
      Scenes.Render;
    end;
  except
    on E: Exception do
      Error.Add('SceneItem.Equip', E.Message);
  end;
end;

procedure TSceneItem.UnEquip(I: Integer; IsShowLog: Boolean = True);
begin
  try
    if Creatures.PC.Inv.UnEquip(I) then
    begin
      Creatures.PC.Prop.MinDamage := Creatures.PC.Prop.MinDamage +
        ItemPatterns.Patterns[KeyIDToInvItemID(I)].MinDamage;
      Creatures.PC.Prop.MaxDamage := Creatures.PC.Prop.MaxDamage +
        ItemPatterns.Patterns[KeyIDToInvItemID(I)].MaxDamage;
      Creatures.PC.Prop.Protect := Creatures.PC.Prop.Protect +
        ItemPatterns.Patterns[KeyIDToInvItemID(I)].Protect;
      Creatures.PC.Calc;

      if IsShowLog then
        Log.Add(Format(Language.GetLang(97),
          [Language.GetItemLang(ItemPatterns.Patterns
          [KeyIDToInvItemID(I)].ID)]));
      // You unequip a %s.
      Scenes.Render;
    end;
  except
    on E: Exception do
      Error.Add('SceneItem.UnEquip', E.Message);
  end;
end;

procedure TSceneItem.KeyDown(var Key: Word; Shift: TShiftState);
var
  I: Integer;
  K: Word;
  C: Char;
begin
  try
    I := KeyIDToInvItemID(ItemIndex);
    case Key of
      27, 123:
        Scenes.Scene := SceneInv;
      38, 40:
        begin
          CursorPos := CursorPos + (Key - 39);
          CursorPos := ClampCycle(CursorPos, 0, FMenuCount - 1);
          Render;
        end;
      13:
        begin
          if (Length(Commands) > 0) then
          begin
            C := Commands[CursorPos + 1];
            K := ord(C);
            KeyDown(K, Shift);
            Exit;
          end;
        end;
      ord('W'):
        if Items.IsCategory(ItemPatterns.Patterns[I].Category,
          EquipmentCategories) then
        begin
          if not Creatures.PC.Inv.GetDoll(ItemIndex) then
            Equip(ItemIndex)
          else
            UnEquip(ItemIndex);
          SceneInv.RedrawPCIcon;
          Scenes.Scene := SceneInv;
        end;
      ord('U'):
        if Items.IsCategory(ItemPatterns.Patterns[I].Category, UseCategories)
        then
        begin
          Use(ItemIndex);
          Log.Apply;
          Game.Save;
          Scenes.Scene := SceneInv;
        end;
      ord('R'):
        if Items.IsCategory(ItemPatterns.Patterns[I].Category, ScrollCategories)
        then
        begin
          Read(ItemIndex);
          Log.Apply;
          Game.Save;
          Scenes.Scene := SceneGame;
        end;
      ord('Q'):
        if Items.IsCategory(ItemPatterns.Patterns[I].Category, PotionCategories)
        then
        begin
          Drink(ItemIndex);
          Log.Apply;
          Game.Save;
          Scenes.Scene := SceneGame;
        end;
      ord('D'):
        if Items.IsCategory(ItemPatterns.Patterns[I].Category, DropCategories)
          and not Creatures.PC.Inv.GetDoll(ItemIndex) then
        begin
          Drop(ItemIndex);
          Log.Apply;
          Game.Save;
          Creatures.PC.Redraw;
          Scenes.Scene := SceneGame;
        end;
    end;
  except
    on E: Exception do
      Error.Add('SceneItem.KeyDown (#' + IntToStr(Key) + ')', E.Message);
  end;
end;

procedure TSceneItem.KeyPress(var Key: Char);
begin
  inherited;

end;

procedure TSceneItem.Render;
var
  Tileset: Graphics.TBitmap;
  P, I, T: Integer;
  ID: string;

  procedure Add(S: string);
  begin
    S := Trim(S);
    if (S = '') then
      Exit;
    Graph.Text.TextCenter(P, S);
    Inc(P);
  end;

  procedure AddMenu(S: string);
  begin
    with Graph.Surface.Canvas do
    begin
      if (CursorPos = FMenuCount) then
      begin
        Font.Color := cAcColor;
        Font.Style := [fsBold];
        Graph.RenderMenuLine(FMenuCount + P, Graph.CharHeight, False,
          50, cDkGray);
      end
      else
      begin
        Font.Color := cBgColor;
        Font.Style := [];
      end;
      Graph.Text.TextCenter((FMenuCount + P) + 1, S);
      Inc(FMenuCount);
    end;
  end;

  procedure AddCommand(C: Char; S: string);
  begin
    Graph.Text.BarOut(LowerCase(C), AnsiLowerCase(S), False);
    Commands := Commands + UpperCase(C);
    AddMenu(S);
  end;

  procedure RenderItemInfo(I: Integer);
  begin
    with Graph.Surface.Canvas do
    begin
      Font.Color := cWhiteGre;
      with ItemPatterns.Patterns[I] do
      begin
        // Life
        { if (scLife = SubCats) then
          Add(Language.GetLang(223));
          if (scLife25 = SubCats) then
          Add(Format(Language.GetLang(81), [25]));
          if (scLife50 = SubCats) then
          Add(Format(Language.GetLang(81), [50]));
          if (scLife75 = SubCats) then
          Add(Format(Language.GetLang(81), [75]));
          if (scLife100 = SubCats) then
          Add(Format(Language.GetLang(81), [100]));
          if (scLife200 = SubCats) then
          Add(Format(Language.GetLang(81), [200]));
          // Mana
          if (scMana = SubCats) then
          Add(Language.GetLang(224));
          if (scMana25 = SubCats) then
          Add(Format(Language.GetLang(82), [25]));
          if (scMana50 = SubCats) then
          Add(Format(Language.GetLang(82), [50]));
          if (scMana75 = SubCats) then
          Add(Format(Language.GetLang(82), [75]));
          if (scMana100 = SubCats) then
          Add(Format(Language.GetLang(82), [100]));
          if (scMana200 = SubCats) then
          Add(Format(Language.GetLang(82), [200]));
          // Atr
          if (scStrength = SubCats) then
          Add(Format('%s +1.', [Language.GetLang(15)]));
          if (scDexterity = SubCats) then
          Add(Format('%s +1.', [Language.GetLang(16)]));
          if (scIntelligence = SubCats) then
          Add(Format('%s +1.', [Language.GetLang(17)]));
          if (scSpeed = SubCats) then
          Add(Format('%s +1.', [Language.GetLang(18)]));
          // Misc
          if (scFill = SubCats) then
          Add(Language.GetLang(80));
          if (scAntidote = SubCats) then
          Add(Language.GetLang(79));
          if (scKey = SubCats) then
          Add(Language.GetLang(112));
          if (scTeleport = SubCats) then
          Add(Language.GetLang(272));
          if (scSummon = SubCats) then
          Add(Language.GetLang(273));
          if (scIdentify = SubCats) then
          Add(Language.GetLang(274));
          if (scPortal = SubCats) then
          Add(Language.GetLang(275));
          if (scWizardEye = SubCats) then
          Add(Format('%s %d.', [Language.GetLang(115),
          Creatures.PC.TempSys.Power('WizardEye')]));
          if (scDispel = SubCats) then
          Add(Language.GetLang(230));
          // Repair
          if (scRepair = SubCats) then
          Add(Language.GetLang(270));
          if (scRepairAll = SubCats) then
          Add(Language.GetLang(271));
          if (scRepair3 = SubCats) then
          Add(Format('%s 3.', [Language.GetLang(89)]));
          if (scRepair6 = SubCats) then
          Add(Format('%s 6.', [Language.GetLang(89)]));
          if (scRepair9 = SubCats) then
          Add(Format('%s 9.', [Language.GetLang(89)]));
          if (scRepair12 = SubCats) then
          Add(Format('%s 12.', [Language.GetLang(89)]));
          if (scRepair15 = SubCats) then
          Add(Format('%s 15.', [Language.GetLang(89)]));
          if (scRepair25 = SubCats) then
          Add(Format('%s 25.', [Language.GetLang(89)])); }
      end;
      //
      Font.Color := cSkyBlue;
      if (ItemPatterns.Patterns[I].MaxDamage > 0) then
        Add(Format('%s %d-%d', [Language.GetLang(32),
          ItemPatterns.Patterns[I].MinDamage,
          ItemPatterns.Patterns[I].MaxDamage]));
      if (ItemPatterns.Patterns[I].Protect > 0) then
        Add(Format('%s %d', [Language.GetLang(33),
          ItemPatterns.Patterns[I].Protect]));
      // Bonuses
      { Font.Color := cSkyBlue;
        if (DungeonItems[I].BonusStrength > 0) then
        Add(Format('%s %d', [Language.GetLang(15),
        DungeonItems[I].BonusStrength]));
        if (DungeonItems[I].BonusDexterity > 0) then
        Add(Format('%s %d', [Language.GetLang(16),
        DungeonItems[I].BonusDexterity]));
        if (DungeonItems[I].BonusIntelligence > 0) then
        Add(Format('%s %d', [Language.GetLang(17),
        DungeonItems[I].BonusIntelligence]));
        if (DungeonItems[I].BonusSpeed > 0) then
        Add(Format('%s %d', [Language.GetLang(18),
        DungeonItems[I].BonusSpeed]));
        if (DungeonItems[I].BonusLife > 0) then
        Add(Format('%s %d', [Language.GetLang(22), DungeonItems[I].BonusLife]));
        if (DungeonItems[I].BonusMana > 0) then
        Add(Format('%s %d', [Language.GetLang(23), DungeonItems[I].BonusMana])); }
      //
      Font.Color := cWhiteGre;
      if (ItemPatterns.Patterns[I].ManaCost > 0) then
        Add(Format('%s -%d (%d/%d)', [Language.GetLang(23),
          ItemPatterns.Patterns[I].ManaCost, Creatures.PC.Mana.Cur,
          Creatures.PC.Mana.Max]));
      { if (ItemPatterns.Patterns[I].NeedMagic > 0) then
        Add(Format('%s %d (%d)', [Language.GetLang(280),
        ItemPatterns.Patterns[I].NeedMagic, Skills.GetSkill('MAGIC').Level])); }
      //
      Font.Color := cSkyBlue;
      if (ItemPatterns.Patterns[I].Weight > 0) then
        Add(Language.GetLang(42) + Items.GetWeight(I));
      if (ItemPatterns.Patterns[I].MaxTough > 0) then
      begin
        if (Creatures.PC.Inv.GetTough(ItemIndex) <= 0) then
          Font.Color := cRdRed;
        Add(Format('%s %d/%d', [Language.GetLang(40),
          Creatures.PC.Inv.GetTough(ItemIndex),
          ItemPatterns.Patterns[I].MaxTough]));
      end;
    end;
  end;

begin
  Commands := '';
  FMenuCount := 0;
  Tileset := Graphics.TBitmap.Create;
  with Graph do
    try
      I := KeyIDToInvItemID(ItemIndex);
      ID := ItemPatterns.Patterns[I].ID;
      P := Height div CharHeight div 2 - 5;
      Clear(0);
      if (ItemPatterns.Patterns[I].Sprite = '') then
        Tileset.Handle := Windows.LoadBitmap(hInstance, PChar(ID))
      else
        Tileset.Handle := Windows.LoadBitmap(hInstance,
          PChar(ItemPatterns.Patterns[I].Sprite));
      BitmapFromTileset(Icon, Tileset, 0);
      Items.Colors(Icon, I);
      ScaleBmp(Icon, 64, 64);
      Icon.Transparent := True;
      with Surface.Canvas do
      begin
        Draw((Surface.Width div 2) - 32, ((P - 2) * CharHeight) - 64, Icon);
        Text.TitleOut(Language.GetItemLang(ItemPatterns.Patterns[I].ID), P - 1);
        Inc(P, 2);
        T := ItemPatterns.Patterns[I].ColorTag;
        if (T = 0) then
          RenderItemInfo(I)
        else
        begin
          if (ItemPatterns.Patterns[I].Category = 'SCROLL') and
            Creatures.PC.Scrolls.IsDefined(T) then
            RenderItemInfo(I)
          else
            Add(Language.GetLang(23));
          if (ItemPatterns.Patterns[I].Category = 'POTION') and
            Creatures.PC.Potions.IsDefined(T) then
            RenderItemInfo(I)
          else
            Add(Language.GetLang(23));
        end;
      end;
      Text.BarOut('esc', Language.GetLang(49), True);
      if Items.IsCategory(ItemPatterns.Patterns[I].Category, EquipmentCategories)
      then
        AddCommand('W', Language.GetLang(95));
      if Items.IsCategory(ItemPatterns.Patterns[I].Category, UseCategories) then
        AddCommand('U', Language.GetLang(98));
      if Items.IsCategory(ItemPatterns.Patterns[I].Category, PotionCategories)
      then
        AddCommand('Q', Language.GetLang(93));
      if Items.IsCategory(ItemPatterns.Patterns[I].Category, ScrollCategories)
      then
        AddCommand('R', Language.GetLang(99));
      if Items.IsCategory(ItemPatterns.Patterns[I].Category, DropCategories) and
        not Creatures.PC.Inv.GetDoll(ItemIndex) then
        AddCommand('D', Language.GetLang(90));
      Render;
      Tileset.Free;
    except
      on E: Exception do
        Error.Add('SceneItem.Render', E.Message);
    end;
end;

function TSceneItem.KeyIDToInvItemID(I: Integer): Integer;
begin
  Result := Items.ItemIndex(I);
end;

procedure TSceneItem.Drop(I: Integer);
var
  J, T, C: Integer;
begin
  try
    if not(Map.Cell[Creatures.PC.Pos.Y][Creatures.PC.Pos.X].Tile in FloorSet +
      [tlOpenWoodChest, tlOpenBestChest, tlOpenBarrel]) then
      Exit;
    T := Creatures.PC.Inv.GetTough(I);
    J := KeyIDToInvItemID(I);
    C := Creatures.PC.Inv.GetCount(ItemPatterns.Patterns[J].ID);
    if Creatures.PC.Inv.Del(I, C) then
    begin
      if (C = 1) then
      begin
        Log.Add(Format(Language.GetLang(91),
          [Language.GetItemLang(ItemPatterns.Patterns[J].ID)]));
        Items.Add(Creatures.PC.Pos.X, Creatures.PC.Pos.Y,
          ItemPatterns.Patterns[J].ID);
        with Items.Item[High(Items.Item)] do
        begin
          Prop.Tough := T;
          Count := 1;
        end;
      end
      else
      begin
        Log.Add(Format(Language.GetLang(92),
          [Language.GetItemLang(ItemPatterns.Patterns[J].ID), C]));
        Items.Add(Creatures.PC.Pos.X, Creatures.PC.Pos.Y,
          ItemPatterns.Patterns[J].ID);
        Items.Item[High(Items.Item)].Count := C;
      end;
    end;
  except
    on E: Exception do
      Error.Add('SceneItem.Drop', E.Message);
  end;
end;

procedure TSceneItem.Use(I: Integer);
var
  J: Integer;
begin
  try
    J := KeyIDToInvItemID(I);
    SceneInv.ItemUseID := ItemPatterns.Patterns[J].ID;
    Scenes.Scene := SceneInv;
  except
    on E: Exception do
      Error.Add('SceneItem.Use', E.Message);
  end;
end;

procedure TSceneItem.Drink(I: Integer);
var
  J, T: Integer;
begin
  try
    J := KeyIDToInvItemID(I);
    with Creatures.PC do
      if Inv.Del(I, 1) then
      begin
        T := ItemPatterns.Patterns[J].ColorTag;
        Log.Add(Format(Language.GetLang(94),
          [Language.GetItemLang(ItemPatterns.Patterns[J].ID)]));
        if (T > 0) and not Creatures.PC.Potions.IsDefined(T) then
        begin
          Creatures.PC.Potions.SetDefined(T);
          Log.Add(Language.GetLang(225) + ' ' +
            AnsiLowerCase(Language.GetItemLang(ItemPatterns.Patterns[J]
            .ID)) + '.');
        end;
        Items.UseItem(J, PotionCategories);
      end;
  except
    on E: Exception do
      Error.Add('SceneItem.Drink', E.Message);
  end;
end;

procedure TSceneItem.Read(I: Integer);
var
  J, T: Integer;
begin
  try
    J := KeyIDToInvItemID(I);
    with Creatures.PC do
    begin
      if (Mana.Cur >= ItemPatterns.Patterns[J].ManaCost) then
      begin
        if Inv.Del(I, 1) then
        begin
          T := ItemPatterns.Patterns[J].ColorTag;
          Log.Add(Format(Language.GetLang(100),
            [Language.GetItemLang(ItemPatterns.Patterns[J].ID)]));
          if (T > 0) and not Creatures.PC.Scrolls.IsDefined(T) then
          begin
            Creatures.PC.Scrolls.SetDefined(T);
            Log.Add(Language.GetLang(220) + ' ' +
              AnsiLowerCase(Language.GetItemLang(ItemPatterns.Patterns[J]
              .ID)) + '.');
          end;
          Mana.Dec(ItemPatterns.Patterns[J].ManaCost);
          Items.UseItem(J, ScrollCategories);
        end;
      end
      else
      begin
        Log.Add(Language.GetLang(67));
      end;
    end;
  except
    on E: Exception do
      Error.Add('SceneItem.Read', E.Message);
  end;
end;

procedure TSceneItem.SetCursorPos(const Value: Integer);
begin
  FCursorPos := Value;
end;

procedure TSceneItem.SetItemIndex(const Value: Integer);
begin
  FItemIndex := Value;
end;

initialization

SceneItem := TSceneItem.Create;

finalization

SceneItem.Free;

end.
