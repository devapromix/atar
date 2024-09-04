unit Trollhunter.Lang;

interface

uses
  System.Classes,
  Trollhunter.Item,
  Trollhunter.Creature,
  Trollhunter.Map;

const
  Lang: array [0 .. 399 + 1, 0 .. 1] of string = (

    ('Start new game', 'Начало новой игры'), // 000
    ('Load previous game', 'Загрузить игру'),
    ('Game settings', 'Игровые настройки'),
    ('High scores table', 'Таблица рекордов'),
    ('Character creation', 'Создание персонажа'), ('', ''), ('', ''), ('', ''),
    ('Character', 'Персонаж'), ('Escape to reality', 'Выход в реальность'),
    ('You need a key.', 'Тебе нужен ключ.'), // 010
    ('You are carrying a too much!', 'Ты перегружен!'),
    ('You pick up a %s.', 'Ты поднял %s.'), ('Yes', 'Да'), ('No', 'Нет'),
    ('Strength', 'Сила'), ('Dexterity', 'Ловкость'),
    ('Intelligence', 'Интеллект'), ('Speed', 'Скорость'), ('', ''),
    ('Hello #g%s$, welcome to #r%s$! Be careful!',
    'Здравствуй #g%s$, добро пожаловать в #r%s$! Будь осторожен!'), // 020
    ('Pickup', 'Поднять предмет'), ('Life', 'Жизнь'), ('Mana', 'Мана'),
    ('select item', 'выбрать предмет'), ('Inventory', 'Инвентарь'),
    ('pickup item', 'поднять предмет'), ('to return to game',
    'вернуться в игру'), ('select character', 'выбор персонажа'),
    ('back to main menu', 'назад в главное меню'), ('Level', 'Уровень'), // 030
    ('Experience', 'Опыт'), ('Damage', 'Урон'), ('Protect', 'Защита'),
    ('Kills', 'Убито'), ('Turns', 'Ходов'), ('Rating', 'Рейтинг'),
    ('Name', 'Имя'), ('What is your name?', 'Введи свое имя?'),
    ('Map', 'Карта'), ('Durability', 'Прочность'), // 040
    ('Count', 'Слоты'), ('Weight', 'Вес'), ('You find the hidden door.',
    'Ты нашел потайную дверь.'), ('You unlock the locked door.',
    'Тебе удалось открыть закрытую дверь.'), ('You open the chest.',
    'Ты открыл сундук.'), ('You open the door.', 'Ты открыл дверь.'),
    ('There is an open chest.', 'Открытый сундук.'),
    ('random name', 'генерировать имя'), ('to return to inventory',
    'вернуться в инвентарь'), ('pickup all items', 'поднять все предметы'),
    // 050
    ('There are many items lays in the chest (#w%s$).',
    'Несколько предметов лежат в сундуке (#w%s$).'),
    ('A #w%s$ lays in the chest.', '#w%s$ лежит в сундуке.'),
    ('There are many items lays in the ground (#w%s$).',
    'Несколько предметов лежат на земле (#w%s$).'),
    ('A #w%s$ lays in the ground.', '#w%s$ лежит на земле.'),
    ('You open the barrel.', 'Ты открыл бочку.'),
    ('There is a barrel.', 'Бочка.'), ('There is a closed barrel.',
    'Закрытая бочка.'), ('A locked door.', 'Закрытая дверь.'),
    ('A door.', 'Дверь.'), ('Congratulations!', 'Поздравляем!'), // 060
    ('You have advanced to level %d!', 'Ты поднялся на уровень %d!'),
    ('You have reached a new character level!',
    'Ты поднялся на новый уровень!'), ('Choose an attribute to improve...',
    'Выбери атрибут для улучшения ...'),
    ('Gained %d exp.', 'Накоплено %d опыта.'), ('You are now a level %d!',
    'Ты теперь на уровне %d!'), ('Radius', 'Обзор'),
    ('Not enought mana!', 'Недостаточно маны!'),
    ('The %s hits you %d.', '%s атакует тебя (%d).'),
    ('You hit the %s %d.', '%s получает урон %d.'),
    ('The poison takes %d HP (%d m).', 'Яд забирает %d HP (%d m).'), // 070
    ('You are healed!', 'Ты исцелился!'), ('You die.', 'Ты умер.'),
    ('The %s dies.', '%s повержен.'), ('You miss the %s.', '%s избежал урона.'),
    ('The %s poison you %d (%d m).', '%s отравил тебя %d (%d х).'),
    ('The %s misses you!', '%s промахивается!'), ('The trap hits you %d.',
    'Ловушка повреждает тебя %d.'), ('The trap misses you!',
    'Ты избежал урона ловушки!'), ('Cures poison.', 'Лечит отравление.'),
    ('Instantly Regain Life and Mana.', 'Восполнить все здоровье и ману.'),
    // 080
    ('Heals %d hit points.', 'Восстанавливает %d здоровья.'),
    ('Restores %d spell points.', 'Восстанавливает %d маны.'),
    ('There is a stone staircase leading upwards here (%s).',
    'Каменная лестница, ведущая вверх (%s).'),
    ('There is a stone staircase leading down here (%s).',
    'Каменная лестница, ведущая вниз (%s).'), ('There is an empty well.',
    'Пустой колодец.'), ('There is a well.', 'Колодец.'),
    ('There is a closed chest.', 'Закрытый сундук.'),
    ('There is a locked chest.', 'Закрытый на ключ сундук.'),
    ('Repair Item', 'Отремонтировать предмет'), ('Drop', 'Выбросить'), // 090
    ('You drop a %s.', 'Ты выбросил %s.'), ('You drop a %s (%d).',
    'Ты выбросил %s (%d).'), ('Drink', 'Выпить'),
    ('You drink a %s.', 'Ты выпил %s.'), ('Wear/Wield', 'Одеть/Взять'),
    // Снарядить
    ('You equip a %s.', 'Ты надел/взял %s.'),
    ('You unequip a %s.', 'Ты снял/спрятал %s.'), ('Use', 'Использовать'),
    ('Read', 'Прочитать'), ('You read a %s.', 'Ты прочитал %s.'), // 100
    ('There are many items lays in the barrel (#w%s$).',
    'Несколько предметов лежат в бочке (#w%s$).'),
    ('A #w%s$ lays in the barrel.', '#w%s$ лежит в бочке.'),
    ('Trap', 'Ловушка'), ('The trap hits the %s %d.',
    '%s получает урон %d от ловушки.'), ('You are poison %d (%d m).',
    'Ты отравлен %d (%d х).'), ('The trap hits the %s %d.',
    '%s теряет ману %d от ловушки.'), ('The %s hits you %d.',
    '%s высасывает твою ману (%d).'), ('You hit the %s %d.',
    '%s теряет ману %d.'), ('You find then hidden trap.',
    'Ты нашел скрытую ловушку.'), ('Area', 'Локация'), // 110
    ('Items on the ground', 'Предметы на земле'),
    ('Allows you to open the lock.', 'Позволяет открыть замок.'),
    ('You are webbed %d (%d m).', 'Ты запутался в паутине %d (%d х).'),
    ('', ''), ('Shows enemies. Radius -', 'Показывает врагов. Обзор -'),
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), // 120
    ('Look', 'Осмотреть'), ('Shoot', 'Стрелять'), ('Wait', 'Ждать'),
    ('Rest', 'Отдохнуть'), ('Help', 'Справка'),
    ('Take screenshot', 'Сделать скриншот'), ('', ''), ('', ''), ('', ''),
    ('Language', 'Язык'), // 130
    ('Font Size', 'Размер Шрифта'), ('Tile Size', 'Размер Тайла'),
    ('Full Screen', 'Полный Экран'), ('', ''), ('', ''),
    // 135
    ('', ''), ('', ''), ('', ''), ('', ''), ('Date/Time', 'Дата/Время'), // 140
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('You are blinded.', 'Ты ослеплен.'), ('', ''), ('', ''), // 150
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('', ''), // 160
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('', ''), // 170
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('Race', 'Раса'), // 180
    ('select race', 'выбор расы'), ('Human', 'Человек'),
    ('Halfling', 'Халфлинг'), ('Forest Gnome', 'Лесной Гном'),
    ('Gray Dwarf', 'Серый Дварф'), ('Orc', 'Орк'), ('High Elf', 'Высокий Эльф'),
    ('Night Elf', 'Ночной Эльф'), ('Dark Elf', 'Темный Эльф'),
    ('Deep Dwarf', 'Глубинный Дварф'), // 190
    ('Cave Dwarf', 'Пещерный Дварф'), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('', ''), ('', ''), ('Skills', 'Навыки'), // 200
    ('Daggers and knives', 'Кинжалы и Ножи'), ('Axes', 'Топоры'),
    ('Swords', 'Мечи'), ('Maces and Mauls', 'Булавы и Молоты'),
    ('Spears', 'Копья'), ('Bows', 'Луки'), ('Crossbows', 'Арбалеты'),
    ('Shield use', 'Щиты'), ('Detect traps', 'Обнaружение ловушек'),
    ('Magic', 'Магия'), // 210
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('You define a scroll:', 'Ты определил свиток:'), // 220
    ('Scroll', 'Свиток'), ('Potion', 'Эликсир'),
    ('Instantly regenerates all of a character''s life.',
    'Восстанавливает все здоровье.'),
    ('Instantly regenerates all of a character''s mana.',
    'Восстанавливает всю ману.'), ('You define a potion:',
    'Ты определил зелье:'), // 225
    ('', ''), ('', ''), ('', ''), ('', ''), ('Removing all effects.',
    'Снятие всех эффектов.'), // 230
    ('on left hand', 'в левой руке'), ('on right hand', 'в правой руке'),
    ('on body', 'на торсе'), ('on head', 'на голове'), ('on feet', 'на ногах'),
    ('on finger', 'на пальце'), ('on neck', 'на шее'), ('', ''), ('', ''),
    ('Not Identified!', 'Не Определен!'), // 240
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('Golden', 'Золотой'), // 250
    ('Indigo', 'Фиолетовый'), ('Jade', 'Зеленый'), ('Azure', 'Синий'),
    ('Light', 'Светлый'), ('Dark', 'Темный'), ('Gray', 'Серый'),
    ('Brown', 'Коричневый'), ('Black', 'Черный'), ('White', 'Белый'),
    ('Blue', 'Голубой'), // 260
    ('Yellow', 'Желтый'), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('', ''), ('Repair item.',
    'Отремонтировать предмет полностью.'), // 270
    ('Repair all items in inventory.', 'Ремонтирует все предметы в инвентаре.'),
    ('', 'Телепортирует игрока в другое место.'),
    ('', 'Телепортирует монстра к игроку.'),
    ('Identify all items in inventory.',
    'Идентифицирует все предметы в инвентаре.'),
    ('Open portal.', 'Открывает портал.'), ('', ''), ('', ''), ('', ''),
    ('', ''), ('You need to master magic!', 'Вам нужно овладеть магией!'),
    // 280
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('Entering The', 'Ты входишь в'), // 290
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('Points', 'Очки'), // 300
    ('Statistics', 'Статистика'), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), // 310
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('Descriptions', 'Описание'), // 320
    ('They have great physical strength.',
    'Они обладают большой физической силой.'),
    ('They do not have great physical strength.',
    'Они не обладают большой физической силой.'), ('They are strong enough.',
    'Они достаточно сильны.'), ('They are extremely strong.',
    'Они очень сильны.'), ('They are physically weak.', 'Они физически слабы.'),
    ('They have very great dexterity.', 'У них очень большая ловкость.'),
    ('Their dexterity is also within the norm.',
    'Их ловкость также в пределах нормы.'), ('Their agility is below average.',
    'Их ловкость ниже среднего.'), ('They are extremely agile.',
    'Они очень ловки.'), ('They are clumsy..', 'Они неповоротливы.'), // 330
    ('They have great intelligence.', 'Они обладают большым интеллектом.'),
    ('They do not have great intelligence.',
    'Они не обладают большым интеллектом.'), ('They are quite smart.',
    'Они достаточно умны.'), ('They have superior intelligence.',
    'Они обладают превосходным интеллектом.'), ('They have weak intelligence.',
    'У них слабый интеллект.'), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), // 340
    ('', ''), (
    'Humans are versatile creatures with a variety of physical characteristics. They have an average height and a physical structure adapted to different conditions.',
    'Люди — универсальные существа с разнообразными физическими характеристиками. Они имеют средний рост и физическую структуру, адаптированную к различным условиям.'),
    ('Halflings are a small, friendly and resourceful people. Their height usually does not exceed a meter. Halflings have round faces, bright eyes, and are always friendly. Their hair is often curly or wavy, with mostly brown hues.',
    'Халфлинги — это маленький, дружелюбный и находчивый народ. Их рост обычно не превышает метра. У них круглые лица, яркие глаза, и они всегда дружелюбны. Их волосы часто вьющиеся или волнистые, в основном каштанового оттенка.'),
    ('A forest gnome is a small, hardy people closely connected to nature. They have skin in shades of bark or moss, which allows them to blend in with the forest. Wood gnomes possess natural magic and use the forest for protection.',
    'Лесной гном — это маленький, выносливый народец, тесно связанный с природой. У них кожа в оттенках коры или мха, что позволяет им сливаться с лесом. Лесные гномы обладают природной магией и используют лес для защиты.'),
    ('The gray dwarf is a grim and hardy race that dwells in the deepest caves. They have pale gray skin that helps them blend in with the stone walls. Their eyes are dark adapted, often reddish or pale in color.',
    'Серый гном — мрачная и выносливая раса, обитающая в самых глубоких пещерах. У них бледно-серая кожа, которая помогает им сливаться с каменными стенами. Их глаза адаптированы к темноте, часто красноватые или бледные.'),
    ('Orcs are huge, muscular creatures with dark green skin. Their large fangs and pointed ears give them a wild and formidable appearance.',
    'Орки — огромные, мускулистые существа с темно-зеленой кожей. Их большие клыки и заостренные уши придают им дикий и грозный вид.'),
    ('A high elf is a noble and refined race known for their wisdom and mastery of magic. They are tall, slender, and have light skin. The eyes of high elves shine, reflecting their deep knowledge of the magic.',
    'Высший эльф — благородная и утонченная раса, известная своей мудростью и мастерством магии. Они высокие, стройные и имеют светлую кожу. Глаза высших эльфов сияют, отражая их глубокие познания в магии.'),
    ('Night elves are a mysterious and hardy race with golden skin that allows them to blend into their surroundings in the eternal autumn forests. Their eyes glow in the dark, helping them see at night.',
    'Ночные эльфы — таинственная и выносливая раса с золотистой кожей, которая позволяет им сливаться с окружающей средой в вечных осенних лесах. Их глаза светятся в темноте, помогая им видеть ночью.'),
    ('Dark elves are a race that lives in deep dungeons and shadow realms. They have pale skin. Their eyes have a reddish or purple tint, which allows them to see in almost complete darkness.',
    'Темные эльфы — раса, живущая в глубоких подземельях и теневых мирах. У них бледная кожа. Их глаза имеют красноватый или фиолетовый оттенок, что позволяет им видеть почти в полной темноте.'),
    ('Deep dwarves are short, stout, light-skinned creatures adapted to life in deep caves. They are excellent at mountain crafts and survive in harsh underground conditions.',
    'Глубинные гномы — невысокие, крепкие, светлокожие существа, приспособленные к жизни в глубоких пещерах. Они отлично справляются с горными ремеслами и выживают в суровых подземных условиях.'),
    // 350
    ('A cave dwarf is a race that lives in dark caves in the mountains. Their skin is brown. These dwarves have learned to survive in the difficult conditions of the mountains.  Their underground dwellings consist of complex well protected tunnels and chambers.',
    'Пещерный гном — раса, живущая в темных пещерах в горах. Их кожа коричневого цвета. Эти гномы научились выживать в сложных условиях гор. Их подземные жилища состоят из сложных, хорошо защищенных туннелей и камер.'),
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), (
    'Their flexibility and adaptability allow them to successfully survive in any environment using a wide range of combat skills and magic.',
    'Их гибкость и приспособляемость позволяют им успешно выживать в любых условиях, используя широкий спектр боевых навыков и магии.'),
    // 360
    ('Halflings do not possess powerful magic or physical strength, but their skill in evading danger, agility, and agility make them important allies in any adventure.',
    'Они не обладают мощной магией или физической силой, но их умение избегать опасностей, ловкость и проворство делают их важными союзниками в любом приключении.'),
    ('They live in hidden dwellings and expertly navigate in forest thickets. Distrustful of strangers, but kind and defend their homes with all cunning and tenacity.',
    'Они живут в скрытых жилищах и искусно ориентируются в лесных чащах. Недоверчивы к чужакам, но добры и защищают свои жилища со всей хитростью и упорством.'),
    ('Gray dwarves are known for their skill in smithing, especially in the creation of magical weapons and armor. They are hermits, distrustful of others, but extremely devoted to their communities.',
    'Серые дворфы известны своим мастерством в кузнечном деле, особенно в создании магического оружия и доспехов. Они отшельники, недоверчивые к другим, но чрезвычайно преданные своим общинам.'),
    ('Living in strict tribes, orcs adhere to a code of strength and honor, where every battle is an opportunity to prove their power and dominance.',
    'Живя строгими племенами, орки придерживаются кодекса силы и чести, где каждая битва — это возможность доказать свою силу и господство.'),
    ('High elves live in forests. They have a sharp mind, skillfully use magic. High elves are proud, sometimes aloof, but always strive for perfection in everything they do.',
    'Высшие эльфы живут в лесах. Они обладают острым умом, умело используют магию. Высшие эльфы горды, иногда отчуждены, но всегда стремятся к совершенству во всем, что они делают.'),
    ('They live in harmony with nature. Night elves have little to no magic, but their physical strength and stealth skills make them effective in combat and survival. They rarely come into contact with other races.',
    'Они живут в гармонии с природой. У ночных эльфов мало или совсем нет магии, но их физическая сила и навыки скрытности делают их эффективными в бою и выживании. Они редко вступают в контакт с другими расами.'),
    ('Their underground cities are often complex labyrinths protected by powerful charms and traps. Although their culture and society can be brutal, dark elves are fiercely loyal to their communities and loyal to their allies.',
    'Их подземные города часто представляют собой сложные лабиринты, защищенные мощными чарами и ловушками. Хотя их культура и общество могут быть жестокими, темные эльфы яростно преданы своим общинам и преданы своим союзникам.'),
    ('They live in closed communities, value traditions and crafts.',
    'Они живут замкнутыми общинами, ценят традиции и ремесла.'),
    ('Despite lacking significant magical power, cave dwarves make up for it with their practical skills and technical excellence. They can be distrustful of strangers, but are loyal allies and have a strong sense of community.',
    'Несмотря на отсутствие значительной магической силы, пещерные гномы компенсируют это практическими навыками и техническим совершенством. Они могут быть недоверчивы к незнакомцам, но являются верными союзниками и обладают сильным чувством общности.'),
    ('', ''), // 370
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('', ''), // 380
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''), ('', ''), // 390
    ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''), ('', ''),
    ('', ''), ('', ''),

    //
    ('#', '#'));

const
  MapName: array [0 .. MapsCount, 0 .. 2] of string = (

    // Village
    ('VILLAGE', 'Village', 'Деревня'),

    // Spider Forest
    ('SPIDERFOREST', 'Spider Forest', 'Лес Пауков'),
    ('SPIDERCAVERN', 'Spider Cavern', 'Пещера Пауков'),
    ('SPIDERNEST', 'Spider Nest', 'Гнездо Пауков'),

    // The Underground Passage
    ('THEUNDERGROUNDP', 'The Underground Passage', 'Подземный Проход'),

    // Valley of Bear
    ('VALLEYOFBEAR', 'Valley of Bear', 'Долина Медведей'),
    ('INTERNALPIT', 'Internal Pit', 'Яма'),
    ('CAVEOFDARKNESS', 'Cave of Darkness', 'Пещера Тьмы'),

    // Stony Field
    ('STONYFIELD', 'Stony Field', 'Каменное Поле'),
    ('BATCAVE', 'Bat Cave', 'Пещера Летучих Мышей'),

    // Twilight Forest
    ('TWILIGHTFOREST', 'Twilight Forest', 'Сумеречный Лес'),
    ('DENOFTHIEVES', 'Den of Thieves', 'Логово Воров'),

    // Forest Marsh
    ('FORESTMARSH', 'Forest Marsh', 'Лесное Болото'),
    ('SWAMPYPIT', 'Swampy Pit', 'Болотная яма'),

    // Black Marsh
    ('BLACKMARSH', 'Black Marsh', 'Черная Топь'), ('BLACKCAVE', 'Black Cave',
    'Черная Пещера'), ('BLACKCAVEPIT', 'Black Cave Pit', 'Яма Черной Пещеры'),

    // Badlands
    ('BADLANDS', 'Badlands', 'Бесплодные Земли'),
    ('FARCAVE', 'Far Cave', 'Дальняя Пещера'),
    ('FORGOTTENCAVE', 'Forgotten Cave', 'Забытая Пещера'),

    // Graveyards
    ('GRAVEYARDS', 'Graveyards', 'Могильники'),
    ('HALLOFTHEDEAD', 'Hall of the Dead', 'Зал Мертвих'),

    // Plain of Bones
    ('PLAINOFBONES', 'Plain of Bones', 'Равнина Костей'),
    ('MOONCAVE', 'Moon Cave', 'Лунная Пещера'),
    ('GROTTOOFCLAWS', 'Grotto of Claws', 'Грот Когтей'),

    // Bloody Fields
    ('BLOODYFIELDS', 'Bloody Fields', 'Кровавые Поля'),
    ('PASSAGEOFTHEDEAD', 'Passage of the Dead', 'Проход Мертвых'),
    ('CITADELOFCHAOS', 'Citadel of Chaos', 'Цитадель Хаоса'),
    ('STONEWORMLAIR', 'Stoneworm Lair', 'Логово Каменного Червя'),
    ('ASYLUMOFDEATH', 'Asylum of Death', 'Убежище Смерти'),

    //
    ('#', '#', '#'), ('#', '#', '#'));

const
  ItemName: array [0 .. ItemsCount, 0 .. 2] of string = (

    ('GOLDCOINS', 'Gold Coin', 'Золото'), ('KEY', 'Key', 'Ключ'),
    ('MINIPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('MINILIFEPOTION', 'Minor Healing Potion', 'Малый Эликсир Здоровья'),
    ('MINIMANAPOTION', 'Minor Mana Potion', 'Малый Эликсир Маны'),
    ('MINIMEGAPOTION', 'Minor Rejuvenation Potion',
    'Малый Эликсир Восстановления'), ('MINIOILPOTION', 'Minor Oil Potion',
    'Малое Кузнечное Масло'), ('NORMPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('NORMLIFEPOTION', 'Light Healing Potion', 'Легкий Эликсир Здоровья'),
    ('NORMMANAPOTION', 'Light Mana Potion', 'Легкий Эликсир Маны'),
    ('NORMMEGAPOTION', 'Light Rejuvenation Potion',
    'Легкий Эликсир Восстановления'), ('NORMOILPOTION', 'Light Oil Potion',
    'Легкое Кузнечное Масло'), ('BASEPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('BASELIFEPOTION', 'Healing Potion', 'Эликсир Здоровья'),
    ('BASEMANAPOTION', 'Mana Potion', 'Эликсир Маны'),
    ('BASEMEGAPOTION', 'Rejuvenation Potion', 'Эликсир Восстановления'),
    ('BASEOILPOTION', 'Oil Potion', 'Кузнечное Масло'),
    ('NANOPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('NANOLIFEPOTION', 'Greater Healing Potion', 'Большой Эликсир Здоровья'),
    ('NANOMANAPOTION', 'Greater Mana Potion', 'Большой Эликсир Маны'),
    ('NANOMEGAPOTION', 'Greater Rejuvenation Potion',
    'Большой Эликсир Восстановления'), ('NANOOILPOTION', 'Greater Oil Potion',
    'Большое Кузнечное Масло'), ('BIGPOTION', 'Empty Bottle', 'Пустой Флакон'),
    ('BIGLIFEPOTION', 'Super Healing Potion', 'Супер Эликсир Здоровья'),
    ('BIGMANAPOTION', 'Super Mana Potion', 'Супер Эликсир Маны'),
    ('BIGMEGAPOTION', 'Super Rejuvenation Potion',
    'Супер Эликсир Восстановления'), ('BIGOILPOTION', 'Super Oil Potion',
    'Супер Кузнечное Масло'), ('SLEDGEHAMMER', 'Sledge Hammer',
    'Кузнечный Mолот'), ('STONEHAMMER', 'Stone Hammer', 'Каменный Молот'),
    ('HATCHET', 'Hatchet', 'Топор Лесоруба'),
    ('WARAXE', 'War Axe', 'Топор Войны'), ('LARGEAXE', 'Large Axe',
    'Большой Топор'), ('BROADAXE', 'Broad Axe', 'Broad Axe'),
    ('BATTLEAXE', 'Battle Axe', 'Боевой Топор'), ('GREATAXE', 'Great Axe',
    'Большой Топор'), ('GIANTAXE', 'Giant Axe', 'Гигантский Топор'),
    ('SHORTSWORD', 'Short Sword', 'Короткий Меч'),
    ('SMALLSHIELD', 'Small Shield', 'Малый Щит'),
    ('LARGESHIELD', 'Large Shield', 'Большой Щит'),
    ('TOWERSHIELD', 'Tower Shield', 'Башенный Щит'),
    ('GOTHICSHIELD', 'Gothic Shield', 'Готический Щит'),
    ('LEATHERARMOR', 'Leather Armor', 'Кожаный Доспех'),
    ('STUDDEDLEATHER', 'Studded Leather', 'Клепаный Доспех'),
    ('RINGMAIL', 'Ring Mail', 'Кольчужный Доспех'), ('SCALEMAIL', 'Scale Mail',
    'Чешуйчатый Доспех'), ('CAP', 'Cap', 'Шлем'), ('HELM', 'Helm', 'Шлем'),
    ('MESHBOOTS', 'Mesh Boots', 'Меховые Сапоги'), ('HEAVYBOOTS', 'Heavy Boots',
    'Тяжелые Сапоги'), ('EARTHRING', 'Earth Ring', 'Кольцо Земли'),
    ('FIRERING', 'Fire Ring', 'Кольцо Огня'), ('TAMARILIS', 'Tamarilis',
    'Taмарилис'), ('ARROW', 'Quiver of Arrows', 'Колчан Стрел'),
    ('HUNTBOW', 'Hunter''s Bow', 'Лук Охотника'),
    ('LONGBOW', 'Long Bow', 'Длинный Лук'), ('BOLT', 'Case of Bolts',
    'Колчан Болтов'), ('LIGHTCROSSBOW', 'Light Crossbow', 'Легкий Арбалет'),
    ('SIEGECROSSBOW', 'Siege Crossow', 'Осадный Арбалет'),
    // Scrolls
    ('SCROLLA', 'Scroll of Summon', 'Свиток Призыва'),
    ('SCROLLB', 'Scroll of Power Cure', 'Свиток Восстановления'),
    ('SCROLLC', 'Scroll of Teleportation', 'Свиток Телепортации'),
    ('SCROLLD', 'Scroll of Unlocking', 'Свиток Отпирания'),
    ('SCROLLE', 'Scroll of Identify', 'Свиток Идентификации'),
    ('SCROLLF', 'Scroll of Portal', 'Свиток Портала'),
    ('SCROLLG', 'Scroll of Wizard Eye', 'Свиток Глаза Чародея'),
    ('SCROLLH', 'Scroll of Dispel Effects', 'Свиток Снятие Эффектов'),
    ('SCROLLI', 'Scroll of Repair', 'Свиток Ремонта'),
    // Potions
    ('POTIONA', 'Antidote Potion', 'Эликсир Противоядия'),
    ('POTIONB', 'Full Healing Potion', 'Эликсир Полного Здоровья'),
    ('POTIONC', 'Full Mana Potion', 'Эликсир Полной Маны'),
    ('POTIOND', 'Full Rejuvenation Potion', 'Эликсир Полного Восстановления'),
    ('POTIONE', 'Strength Potion', 'Эликсир Силы'),
    ('POTIONF', 'Dexterity Potion', 'Эликсир Ловкости'),
    ('POTIONG', 'Intelligence Potion', 'Эликсир Интеллекта'),
    ('POTIONH', 'Speed Potion', 'Эликсир Проворности'),
    // Bag of Stones
    //
    ('#', '#', '#'));

const
  CreatureName: array [0 .. CreaturesCount, 0 .. 2] of string = (

    ('BIGSPIDER', 'Big Spider', 'Большой Паук'), ('REDSPIDER', 'Red Spider',
    'Кровавый Паук'), ('CAVESPIDER', 'Cave Spider', 'Пещерный Паук'),
    ('GOBLIN', 'Goblin', 'Гоблин'), ('DARKGOBLIN', 'Dark Goblin',
    'Темный Гоблин'), ('CAVEGOBLIN', 'Cave Goblin', 'Пещерный Гоблин'),
    ('SLUG', 'Slug', 'Слизень'), ('BIGSLIME', 'Big Slime',
    'Большой Комок Слизи'), ('SLIME', 'Slime', 'Комок Слизи'),
    ('SMALLSLIME', 'Small Slime', 'Крохотный Комок Слизи'),
    ('BAT', 'Bat', 'Вампир'), ('BLUEBAT', 'Blue Bat', 'Небесный Вампир'),
    ('CAVEBAT', 'Cave Bat', 'Пещерный Вампир'), ('SKELETON', 'Skeleton',
    'Скелет'), ('SKELETONMAGE', 'Skeleton Mage', 'Скелет Маг'),
    ('MAGAN', 'Magan', 'Маган'), ('DARKEYE', 'Dark Eye', 'Темный Глаз'),
    ('NECROMANCER', 'Necromancer', 'Некромант'), ('TUORG', 'Tuorg', 'Туорг'),
    //
    ('#', '#', '#'));

type
  TLanguageString = class(TObject)
  private
    FId: TStringList;
    FEn: TStringList;
    FRu: TStringList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const AId, AEn, ARu: string);
    property ID: TStringList read FId write FId;
    property En: TStringList read FEn write FEn;
    property Ru: TStringList read FRu write FRu;
  end;

type
  TLanguage = class(TObject)
  private
    FCurrentLanguageIndex: Byte;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromResources;
    property CurrentLanguageIndex: Byte read FCurrentLanguageIndex
      write FCurrentLanguageIndex;
    function GetLang(const AIdent: string): string; overload;
    function GetLang(const AIdent: Integer): string; overload;
    function GetItemLang(const AItemIdent: string): string;
    procedure ChangeLanguage;
    function LanguageName: string;
  end;

var
  Language: TLanguage;

implementation

uses
  System.SysUtils,
  System.JSON,
  Vcl.Dialogs,
  Trollhunter.Zip,
  Trollhunter.Utils,
  Trollhunter.Error,
  Trollhunter.Creatures,
  Trollhunter.MainForm;

var
  LanguageString: TLanguageString;

  { TLanguageString }

procedure TLanguageString.Add(const AId, AEn, ARu: string);
begin
  FId.Add(AId);
  FEn.Add(AEn);
  FRu.Add(ARu);
end;

procedure TLanguageString.Clear;
begin
  FId.Clear;
  FEn.Clear;
  FRu.Clear;
end;

constructor TLanguageString.Create;
begin
  FId := TStringList.Create;
  FEn := TStringList.Create;
  FRu := TStringList.Create;
end;

destructor TLanguageString.Destroy;
begin
  FreeAndNil(FId);
  FreeAndNil(FEn);
  FreeAndNil(FRu);
  inherited;
end;

{ TLanguage }

procedure TLanguage.ChangeLanguage;
begin
  if (FCurrentLanguageIndex = 0) then
    FCurrentLanguageIndex := 1
  else
    FCurrentLanguageIndex := 0;
end;

constructor TLanguage.Create;
begin
  LanguageString := TLanguageString.Create;
  FCurrentLanguageIndex := 0;
end;

destructor TLanguage.Destroy;
begin
  FreeAndNil(LanguageString);
  inherited;
end;

function TLanguage.GetLang(const AIdent: Integer): string;
begin
  Result := GetLang(AIdent.ToString);
end;

function TLanguage.GetLang(const AIdent: string): string;
var
  I: Integer;
begin
  Result := '';
  I := LanguageString.FId.IndexOf(AIdent);
  if I < 0 then
    Exit;
  if (FCurrentLanguageIndex = 0) then
    Result := LanguageString.En[I]
  else
    Result := LanguageString.Ru[I];
end;

function TLanguage.GetItemLang(const AItemIdent: string): string;
var
  LColorTag, LItemIndex: Integer;
  LColorPrefix: string;
begin
  Result := '';
  LItemIndex := Items.ItemIndex(AItemIdent);
  // Scrolls and Potions
  LColorTag := DungeonItems[LItemIndex].ColorTag;
  with Creatures.PC do
  begin
    if (LColorTag > 0) and (DungeonItems[LItemIndex].Category = dsPotion) and
      not Potions.IsDefined(LColorTag) then
    begin
      Result := '#r' + Potions.GetColorName(LColorTag) + ' ' +
        Language.GetLang(222) + '$';
      Exit;
    end;
    if (LColorTag > 0) and (DungeonItems[LItemIndex].Category = dsScroll) and
      not Scrolls.IsDefined(LColorTag) then
    begin
      Result := '#r' + Language.GetLang(221) + ' ' + '"' +
        Scrolls.GetName(LColorTag) + '"';
      Exit;
    end;
  end;
  // Items
  case DungeonItems[LItemIndex].Category of
    dsPotion:
      LColorPrefix := '#g';
    dsScroll:
      LColorPrefix := '#b';
  else
    LColorPrefix := '#w';
  end;
  Result := LColorPrefix + GetLang(AItemIdent) + '$';
end;

function TLanguage.LanguageName: string;
begin
  case FCurrentLanguageIndex of
    0:
      Result := 'English';
    1:
      Result := 'Russian';
    2:
      Result := 'Ukrainian';
  end;
end;

procedure TLanguage.LoadFromResources;

  procedure LoadFromFile(const AFileName: string);
  var
    LStringList: TStringList;
    LJSONObject: TJSONObject;
    LJSONArray: TJSONArray;
    LZip: TZip;
    I: Integer;
    ID, En, Ru: string;
  begin
    try
      LStringList := TStringList.Create;
      try
        LZip := TZip.Create(MainForm);
        try
          LStringList.Text := LZip.ExtractTextFromFileUTF8
            (Path + 'resources.res', AFileName);
          LJSONArray := TJSONObject.ParseJSONValue(LStringList.Text)
            as TJSONArray;
          try
            for I := 0 to LJSONArray.Count - 1 do
            begin
              LJSONObject := LJSONArray.Items[I] as TJSONObject;
              ID := LJSONObject.GetValue('id').Value;
              En := LJSONObject.GetValue('en').Value;
              Ru := LJSONObject.GetValue('ru').Value;
              LanguageString.Add(ID, En, Ru);
            end;
          finally
            FreeAndNil(LJSONArray);
          end;
        finally
          FreeAndNil(LZip);
        end;
      finally
        FreeAndNil(LStringList);
      end;
    except
      on E: Exception do
        Error.Add('Lang.LoadFromFile', E.Message);
    end;
  end;

begin
  try
    if not FileExists(Path + 'resources.res') then
      Exit;
    LanguageString.Clear;
    LoadFromFile('languages.json');
    LoadFromFile('languages.maps.json');
    LoadFromFile('languages.creatures.json');
  except
    on E: Exception do
      Error.Add('Lang.LoadFromResources', E.Message);
  end;
end;

procedure SaveLang;
var
  SL: TStringList;
  I: Integer;
  S: string;
begin
  S := ',';
  SL := TStringList.Create;
  SL.WriteBOM := False;
  try
    SL.Append('[');
    for I := 0 to 999 do
    begin
      SL.Append('	{');
      SL.Append('		"id": "' + IntToStr(I) + '",');
      if I > 399 then
      begin
        SL.Append('		"en": "",');
        SL.Append('		"ru": "",');
      end
      else
      begin
        SL.Append('		"en": "' + Lang[I][0] + '",');
        SL.Append('		"ru": "' + Lang[I][1] + '",');
      end;
      SL.Append('		"uk": ""');
      if I = 999 then
        S := '';
      SL.Append('	}' + S);
    end;
    SL.Append(']');
    SL.SaveToFile(Path + 'languages.json', TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

procedure SaveMapLang;
var
  SL: TStringList;
  I: Integer;
  S: string;
begin
  S := ',';
  SL := TStringList.Create;
  SL.WriteBOM := False;
  try
    SL.Append('[');
    for I := 0 to MapsCount - 1 do
    begin
      SL.Append('	{');
      SL.Append('		"id": "' + MapName[I][0] + '",');
      SL.Append('		"en": "' + MapName[I][1] + '",');
      SL.Append('		"ru": "' + MapName[I][2] + '",');
      SL.Append('		"uk": ""');
      if I = MapsCount - 1 then
        S := '';
      SL.Append('	}' + S);
    end;
    SL.Append(']');
    SL.SaveToFile(Path + 'languages.maps.json', TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

procedure SaveCrLang;
var
  SL: TStringList;
  I: Integer;
  S: string;
begin
  S := ',';
  SL := TStringList.Create;
  SL.WriteBOM := False;
  try
    SL.Append('[');
    for I := 0 to CreaturesCount - 1 do
    begin
      SL.Append('	{');
      SL.Append('		"id": "' + CreatureName[I][0] + '",');
      SL.Append('		"en": "' + CreatureName[I][1] + '",');
      SL.Append('		"ru": "' + CreatureName[I][2] + '",');
      SL.Append('		"uk": ""');
      if I = CreaturesCount - 1 then
        S := '';
      SL.Append('	}' + S);
    end;
    SL.Append(']');
    SL.SaveToFile(Path + 'languages.creatures.json', TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

procedure SaveItLang;
var
  SL: TStringList;
  I: Integer;
  S: string;
begin
  S := ',';
  SL := TStringList.Create;
  SL.WriteBOM := False;
  try
    SL.Append('[');
    for I := 0 to ItemsCount - 1 do
    begin
      SL.Append('	{');
      SL.Append('		"id": "' + ItemName[I][0] + '",');
      SL.Append('		"en": "' + ItemName[I][1] + '",');
      SL.Append('		"ru": "' + ItemName[I][2] + '",');
      SL.Append('		"uk": ""');
      if I = ItemsCount - 1 then
        S := '';
      SL.Append('	}' + S);
    end;
    SL.Append(']');
    SL.SaveToFile(Path + 'languages.items.json', TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

initialization

Language := TLanguage.Create;
Language.LoadFromResources;
SaveLang;
SaveMapLang;
SaveCrLang;
SaveItLang;

finalization

FreeAndNil(Language);

end.
