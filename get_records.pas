unit get_records;

interface

function GetRecord: string;

var
  bRecCode:     byte;

implementation

uses SysUtils, kernel, support, soutput, main, timez, realz;

var
  bClass,
  bPage:        byte;

  cwRec:        word;
  mpbRec:       array[0..bRECORD_BUFF-1] of byte;

function Int2Str(wT: word; bSize: byte = 2): string;
begin
  Result := IntToStrX(wT, bSize);
end;
  
function GetRecTime(i: byte): string;
var
  timT: times;
begin
  with timT do begin
    bSecond := mpbRec[i+0];
    bMinute := mpbRec[i+1];
    bHour   := mpbRec[i+2];
    bDay    := mpbRec[i+3];
    bMonth  := mpbRec[i+4];
    bYear   := mpbRec[i+5];

    Result := Int2Str(bHour)   + ':' +
              Int2Str(bMinute) + ':' +
              Int2Str(bSecond) + ' ' +
              Int2Str(bDay)    + '.' +
              Int2Str(bMonth)  + '.' +
              Int2Str(bYear);
  end;
end;

function GetRecDate(i: byte): string;
begin
    Result := Int2Str(mpbRec[i+0])  + '.' +
              Int2Str(mpbRec[i+1])  + '.' +
              Int2Str(mpbRec[i+2]);
end;

function GetRecDay(i: byte): string;
begin
    Result := Int2Str(mpbRec[i+0])  + '.' +
              Int2Str(mpbRec[i+1])  + '.' +
              Int2Str(mpbRec[i+2]);
end;

function GetRecMon(i: byte): string;
begin
    Result := Int2Str(mpbRec[i+1])  + '.' +
              Int2Str(mpbRec[i+2]);
end;

function GetRecInt(i: byte): string;
begin
  Result := IntToStr(mpbRec[i]*$100+mpbRec[i+1]);
end;

function GetRecLong2(i: byte): string;
begin
  Result := IntToStr(mpbRec[i]*$1000000+mpbRec[i+1]*$10000+mpbRec[i+2]*$100+mpbRec[i+3]);
end;

function GetRecReal(j: byte): string;
var
  i:    byte;
  sreT: reals;
begin
  for i := 0 to 3 do sreT[i] := mpbRec[j + i];
  Result := FloatToStrF(FromReals(sreT),ffFixed,12,3);
end;

function GetRecContact(i: byte): string;
begin
  if i = 0 then begin
    case mpbRec[0] of
      0: Result := '1 вкл.';
      1: Result := '1 выкл.';
      2: Result := '2 вкл.';
      3: Result := '2 выкл.';
      else Result := 'неизвестная команда';
    end;
  end
  else if i = 1 then begin
    case mpbRec[0] of
      0: Result := '1 вкл. 2 выкл.';
      1: Result := '2 вкл. 1 выкл.';
      else Result := 'неизвестная команда';
    end;
  end
  else Result := 'неизвестный режим';  
end;

function GetRecMode: string;
begin
  case mpbRec[0] of
    0: Result := 'без управления';
    1: Result := 'основной';
    2: Result := 'специальный 1';
    3: Result := 'специальный 2';
    4: Result := 'специальный 3';
    else Result := 'неизвестный режим';
  end;
end;

function GetRecValue(c: char): string;
begin
  Result := GetRecReal(0)+' '+c+' '+GetRecReal(4);
end;

function GetRecEvent(bT: byte): string;
var
  i:  byte;
begin
  i := bT and $0F;
  case i of
    1: Result := 'прибор';
    2: Result := 'фаза 1';
    3: Result := 'фаза 2';
    4: Result := 'фаза 3';
    else Result := 'неизвестное событие '+IntToStr(i);
  end;

  if i in [1,2,3,4] then begin
  if (bT and $F0) > 0 
  then 
   Result := '  событие - выкл. '+ Result
  else
   Result := '  событие - вкл.  '+ Result;
  end; 
end;

function GetSMSStart: string;
begin
 Result := 'телефоны ' + IntToHex(mpbRec[0],2)+IntToHex(mpbRec[1],2)+IntToHex(mpbRec[2],2)+IntToHex(mpbRec[3],2);
end;

function GetSMSResult: string;
begin
 Result := IntToHex(mpbRec[7],2);
 if mpbRec[7] = 1 then
   Result := Result + ' - OK'
 else  
   Result := Result + ' - ошибка';
end;

function GetCurrentStat: string;
var
  i,a,b: byte;
begin
  Result := '';
  for i := 0 to 64-1 do begin
      a := i div 8;
      b := $80 shr (i mod 8);
      if (mpbRec[a] and b) <> 0 then begin
        Result := Result + IntToStr(i+1) + ' ';
      end;
  end;
  if Result = '' then Result := 'нет ошибочных каналов' else Result := 'ошибочные каналы - ' + Result;
end;

function GetRecDigital: string;
begin
  Result := 'канал '+IntToStr(mpbRec[0]+1)+'  '
   +Int2Str(mpbRec[1]+1)+'.'+Int2Str(mpbRec[2])+'.'+Int2Str(mpbRec[3])+'.'+Int2Str(mpbRec[4],3)+'.'+Int2Str(mpbRec[5]+1)+'  '+GetDeviceName(mpbRec[3]);
end;

function GetRecKey1: string;
var
  i: byte;
begin
  Result := 'канал '+IntToStr(mpbRec[0]+1)+'  ';
  for i := 1 to 7 do Result := Result + Chr(mpbRec[i])
end;

function GetRecKey2: string;
var
  i: byte;
begin
  Result := '                ';
  for i := 0 to 5 do Result := Result + Chr(mpbRec[i])
end;

function GetRecLong: string;
begin
  Result := 'канал '+IntToStr(mpbRec[0]+1)+'  ';
  Result := Result + IntToStr(mpbRec[1]*$1000000+mpbRec[2]*$10000+mpbRec[3]*$100+mpbRec[4])
end;

function GetRecCheckupMode: string;
begin
  if (mpbRec[0] = 0) then
    Result := 'рабочий режим'
  else
    Result := 'проверочный режим';
end;

function GetRecord: string;
var
  i:    byte;
  stT:  string;
  w1:   word;
begin
  Result := PackStrL(PopTimes2Str,20) + ' ' +
            PackStrL(IntToStr((PopInt shl 16)+PopInt),4) + ' ';

  bRecCode := Pop;

  Result := Result + PackStrL(IntToStr(bRecCode),3) + '  ';

  for i := 0 to bRECORD_BUFF-1 do begin
    mpbRec[i] := Pop;
    Result := Result + ' ' +IntToHex(mpbRec[i],2);
  end;

  w1 := mpbRec[1]*$100+mpbRec[2];

  case bRecCode of
    0: stT := 'начало догонки';
    26: stT := 'начало догонки после выключения ' + GetRecTime(0);
    1: stT := 'конец  догонки';
    2: stT := 'watchdog reset';
    3: stT := 'запуск';
    4: stT := 'перезапуск';
    5: stT := 'распароливание';
    6: stT := 'дверца открыта';
    7: stT := 'дверца закрыта';
    8: stT := 'режим реле 1: '+GetRecContact(0);
    9: stT := 'режим реле 2: '+GetRecContact(1);
    10: stT := 'изменение режима реле: '+GetRecMode;    
    11: stT := 'спец. 3: авто  - реле 1 вкл.  '+GetRecValue('>');
    12: stT := 'спец. 3: авто  - реле 1 выкл. '+GetRecValue('<');
    13: stT := 'спец. 3: авто  - реле 2 вкл.  '+GetRecValue('<');
    14: stT := 'спец. 3: авто  - реле 2 выкл. '+GetRecValue('>');
    15: stT := 'спец. 3: ручн. - реле 1 вкл.  ';
    16: stT := 'спец. 3: ручн. - реле 1 выкл. ';
    17: stT := 'спец. 3: ручн. - реле 2 вкл.  ';
    18: stT := 'спец. 3: ручн. - реле 2 выкл. ';
    19: stT := 'спец. 3: задание уровеня вкл. реле 1: '+GetRecReal(0);
    20: stT := 'спец. 3: задание уровеня вкл. реле 2: '+GetRecReal(0);
    21: stT := 'спец. 3: задание таймаута (*3 мин.): '+IntToStr(mpbRec[0]);
    22: stT := 'спец. 3: отсчет таймаута (*3 мин.) '+IntToStr(mpbRec[0])+'-'+IntToStr(mpbRec[1]);
    23: stT := 'спец. 3: старт  таймаута (*3 мин.) '+IntToStr(mpbRec[0])+'-'+IntToStr(mpbRec[1]);
    24: stT := 'начало аварийного расчета';
    25: stT := 'конец  аварийного расчета';

    32: stT := 'нет связи со счетчиком: код '+IntToStr(mpbRec[0])+'.'+IntToStr(mpbRec[1]);
    33: stT := 'нет событий в таблице счетчика !';
    34: stT := 'пропущены события после последного опроса:'+GetRecEvent(mpbRec[1]);
    35: stT := 'время - '+GetRecTime(1)+GetRecEvent(mpbRec[7]);   // СЭТ-4ТМ.02
    36: stT := 'время - '+GetRecTime(1)+GetRecEvent(mpbRec[7]);   // Меркурий-230

    40: stT := 'редактирование каналов: до     '+GetRecDigital;
    41: stT := 'редактирование каналов: после  '+GetRecDigital;
    42: stT := 'редактирование простых паролей: до     '+GetRecKey1;
    43: stT := '                                       '+GetRecKey2;
    44: stT := 'редактирование простых паролей: после  '+GetRecKey1;
    45: stT := '                                       '+GetRecKey2;
    46: stT := 'редактирование сложных адресов: до     '+GetRecLong;
    47: stT := 'редактирование сложных адресов: после  '+GetRecLong;
    48: stT := 'редактирование сложных паролей: до     '+GetRecLong;
    49: stT := 'редактирование сложных паролей: после  '+GetRecLong;

    62: stT := 'канал запрещен !';
    63: stT := 'получас запрещен !';
    64: stT := 'регул. опрос: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    65: stT := 'ручной опрос: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    66: stT := 'готовность: '+IntToStr(mpbRec[1]*$100+mpbRec[2])+' ========';
    99: stT := 'готовность: '+GetRecInt(0)+'-'+GetRecInt(2)+' ========';
    67: stT := 'готовность: опрос счётчиков';
    68: stT := 'опрос счётчиков';
    69: stT := 'Esc V: OK';
    70: stT := 'Esc V: ошибка';
    71: stT := 'данные: '+GetRecReal(1);
    72: stT := 'Esc S: OK';
    73: stT := 'Esc S: ошибка';
    74: stT := 'данные: '+GetRecReal(1);
    75: stT := 'Esc U: OK';
    76: stT := 'Esc U: ошибка';
    77: stT := 'данные: '+GetRecTime(1);
    78: stT := 'завершение: опрос счётчиков';
    79: stT := 'завершение: '+IntToStr(mpbRec[3]*$100+mpbRec[4])+'/'+IntToStr(mpbRec[1]*$100+mpbRec[2]);
    97: stT := 'завершение: '+GetRecInt(2)+'-'+GetRecInt(4)+'; принято '+GetRecInt(0);
    80: stT := 'ошибка '+IntToHex(mpbRec[1],2)+'.'+IntToHex(mpbRec[2],2);
    81: stT := 'начало дозвона';
    82: stT := 'конец  дозвона';
    83: stT := 'начало отбоя';
    84: stT := 'конец  отбоя';
    85: stT := 'опрос завершен ==========';
    86: stT := 'опрос завершен ! ========';
    87: stT := 'опрос прерван ===========';
    88: stT := 'начало расчёта 1';
    89: stT := 'конец  расчёта 1';
    90: stT := 'без расчёта';
    91: stT := 'начало расчёта 2';
    92: stT := 'конец  расчёта 2';
    93: stT := 'ошибка '+IntToHex(mpbRec[1],2)+'.'+IntToHex(mpbRec[2],2)+'.'+IntToHex(mpbRec[3],2);
    94: stT := 'опрос завершен за ' + Int2Str(w1 div 60)+':'+Int2Str(w1 mod 60);
    95: stT := 'начало очистки пустых профилей '+GetRecInt(1)+' '+GetRecInt(3)+'/'+GetRecInt(5);
    96: stT := 'конец  очистки пустых профилей ';
    98: stT := 'специальный старт: 0x'+IntToHex(mpbRec[0]*$100+mpbRec[1], 4);

    100: stT := 'СМС превышение: '+GetRecValue('>');
    101: stT := 'СМС отправка: '+ GetSMSStart+'  '+GetSMSResult;
    102: stT := 'СМС тест';

    109: stT := 'Трехминутный опрос: '+GetCurrentStat;
    110: stT := 'Трехминутный опрос: перерасчет '+GetRecLong2(1)+'/'+GetRecInt(5);
    111: stT := 'Трехминутный опрос: перерасчет невозможен';
    112: stT := 'Трехминутный опрос: переполнение';

    113: stT := 'дублированный профиль: ' + GetRecTime(0);

    126: stT := 'регул. опрос: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    127: stT := 'ручной опрос: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    128: stT := 'готовность: '+IntToStr(mpbRec[1]*$100+mpbRec[2])+' ========';
    129: stT := 'ошибка конфигурации !';
    130: stT := 'модем ...';
    131: stT := 'модем: OK';
    132: stT := 'модем ... повтор';
    133: stT := 'настройки 1 ...';
    134: stT := 'настройки 1: OK';
    135: stT := 'настройки 1 ... повтор';
    136: stT := '+++ ...                 ~аварийное соединение';
    137: stT := 'отключение ...          ~аварийное соединение';
    138: stT := 'отключение ... повтор   ~аварийное соединение';
    139: stT := 'настройки 1 ...         ~аварийное соединение';
    140: stT := 'настройки 1 ... повтор  ~аварийное соединение';
    141: stT := 'настройки 2 ...';
    142: stT := 'настройки 2: OK';
    143: stT := 'настройки 2 ... повтор';
    144: stT := 'соединение ...';
    145: stT := 'соединение: ОК';
    146: stT := 'соединение ... повтор';
    147: stT := 'сброс с клавиатуры ======';
    148: stT := 'завершение: '+IntToStr(mpbRec[3]*$100+mpbRec[4])+'/'+IntToStr(mpbRec[1]*$100+mpbRec[2]);
    149: stT := 'ошибка '+IntToHex(mpbRec[1],2)+'.'+IntToHex(mpbRec[2],2);
    150: stT := 'опрос завершен A';
    151: stT := 'опрос завершен B';
    152: stT := '+++ ...';
    153: stT := '+++: OK';
    154: stT := 'отключение ... повтор   ~аварийное отсоединение';
    155: stT := 'отключение: OK          ~аварийное отсоединение';
    156: stT := '+++ ... повтор          ~аварийное отсоединение';
    157: stT := 'отключение ...';
    158: stT := 'отключение: OK';
    159: stT := 'отключение ... повтор';
    160: stT := 'сброс по DTR';
    161: stT := 'ошибка '+IntToHex(mpbRec[1],2)+'.'+IntToHex(mpbRec[2],2)+'.'+IntToHex(mpbRec[3],2);

    192: stT := 'GPS ручное требование коррекции';
    193: stT := 'GPS авто. требование коррекции';
    194: stT := 'GPS ошибочный запрос';
    195: stT := 'GPS ответ: '+GetRecTime(0);
    196: stT := 'GPS ошибка состояния: '+IntToStr(mpbRec[0]);
    197: stT := 'GPS время: '+GetRecTime(0) + ' пояс ' +IntToStr(mpbRec[6]);
    198: stT := 'GPS ошибка формата времени';
    199: stT := 'GPS ошибка: даты различны';
    200: stT := 'GPS ошибка: получасы различны';
    201: stT := 'GPS коррекция: ОК';

    210: stT := 'коррекция c клавиатуры: '+GetRecTime(0);
    211: stT := 'коррекция - запрос 0xFF 0x0B: '+GetRecTime(0);
    212: stT := 'коррекция - запрос Esc K: '+GetRecTime(0);
    213: stT := 'коррекция - запрос Esc k: '+GetRecTime(0);
    214: stT := 'коррекция 1: '+GetRecTime(0);
    215: stT := 'коррекция 2: '+GetRecTime(0);
    216: stT := 'коррекция 3: '+GetRecTime(0);
    217: stT := 'коррекция: ОК';

    218: begin
           stT := 'GPS сезон: ' + IntToStr(mpbRec[0]) + ' - ';
           case mpbRec[0] of
             0:   stT := stT +'лето';
             1:   stT := stT +'зима';
             else stT := stT +'?';
           end;
           stT := stT + ', флаг: ' + IntToStr(mpbRec[1]) + ' - ';
           case mpbRec[1] of
             0:    stT := stT + 'нет';
             255:  stT := stT + 'да';
             else  stT := stT + '?';
           end;           
         end;

    220: stT := 'СИМЭК-48 ручное требование коррекции';
    221: stT := 'СИМЭК-48 авто. требование коррекции';
    222: stT := 'СИМЭК-48 ошибочный запрос';
    223: stT := 'СИМЭК-48 ответ: '+GetRecTime(0);
    224: stT := 'СИМЭК-48 ошибка состояния: ?';
    225: stT := 'СИМЭК-48 время: '+GetRecTime(0);
    226: stT := 'СИМЭК-48 ошибка формата времени';
    227: stT := 'СИМЭК-48 ошибка: даты различны';
    228: stT := 'СИМЭК-48 ошибка: получасы различны';
    229: stT := 'СИМЭК-48 коррекция: ОК';

    230: stT := 'достоверность: старт - '+GetRecCheckupMode+'; глубина опроса - сутки: '+IntToStr(mpbRec[1])+', месяцы: '+IntToStr(mpbRec[2]);
    231: stT := 'достоверность: финиш - принято '+GetRecInt(0)+' получасов';
    232: stT := 'достоверность:   разница данных - сумматор '+GetRecLong2(0)+', счетчик '+GetRecLong2(4);
    233: stT := 'достоверность:   сутки '+GetRecDay(0)+' - требуют переопроса';
    234: stT := 'достоверность:   месяц '+GetRecMon(0)+' - требует переопроса';
    235: stT := 'достоверность:  '+GetRecDigital;
    236: stT := 'достоверность:   сутки '+GetRecDay(0)+' - уже добавлены для переопроса';
    237: stT := 'достоверность:   месяц '+GetRecMon(0)+' - уже добавлен для переопроса';
    238: stT := 'достоверность:   сутки '+GetRecDay(0)+' - повтор '+IntToStr(mpbRec[6]);
    239: stT := 'достоверность:   месяц '+GetRecMon(0)+' - повтор '+IntToStr(mpbRec[6]);
    240: stT := 'достоверность:   сутки '+GetRecDay(0)+' - слишком много повторов, переопрос невозможен';
    241: stT := 'достоверность:   месяц '+GetRecMon(0)+' - слишком много повторов, переопрос невозможен';
    242: stT := 'достоверность:  требуют переопроса '+IntToStr(mpbRec[0])+' суток'+'; разница данных - сутки: '+IntToStr(mpbRec[1])+', месяцы: '+IntToStr(mpbRec[2]);

    else stT := '?';
  end;

  if bRecCode in [32..36,62..84,93,95,96,126..162] then stT := PackStrL(IntToStr(mpbRec[0]+1),2)+': '+stT;
  Result := Result + '   ' + stT;
end;

end.
