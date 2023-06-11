unit sinput;

interface

uses Forms, SysUtils, Classes, Controls, Windows, Grids, Graphics;

procedure PostInputComPort;
procedure PostInputSocket(s: string);
function GetExtendedStr(exT: extended): string;

var
  cwRec:       word;

implementation

uses support, soutput, main, kernel, terminal, console, load, crc,
_sreal, _float, _relax, _graphs, crc_tariffs, timez, get_records, get_memory0, get_memory1;

var
  {Year,Month,Day,}Hour,Min,Sec,MSec:  word;
  bEsc_v,
  bEsc_l:             byte;

{}function GetTimes: times;
begin
  with Result do begin
    bSecond := Pop;
    bMinute := Pop;
    bHour   := Pop;
    bDay    := Pop;
    bMonth  := Pop;
    bYear   := Pop;
  end;
end;

{}function Times2Str(timT: times): string;
begin
  with timT do begin
    Result := ' ' + IntToStr2(bHour)   +
              ':' + IntToStr2(bMinute) +
              ':' + IntToStr2(bSecond) +
              ' ' + IntToStr2(bDay)    +
              '.' + IntToStr2(bMonth)  +
              '.' + IntToStr2(bYear);
  end;
end;

function GetTimes2Str: string;
begin
  Result := Times2Str(GetTimes);
end;

function GetBool2Str: string;
var
  i:  byte;
begin
  i := Pop();
  case i of
    0:    Result := 'нет';
    255:  Result := 'да';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

{}function GetDay: string;
begin
  Result := 'сутки назад: ' + IntToStr(bEsc_l);
end;

{}function GetHour(i: word): string;
begin
  Result := PackStrR(IntToStr(i),4) +
            IntToStr2(i div 2)+':'+IntToStr2((i mod 2)*30)+ '   ';
end;

{}function MultiBox(cwSize: word): boolean;
begin
  if cwSize = 5+1+2 then begin
    case mpbIn[5] of
      0:  InfBox('Операция завершена успешно');

      1:  WrnBox('Неправильная команда !');
      2:  WrnBox('Неправильный адрес !');
      3:  WrnBox('Неправильные данные !');
      4:  WrnBox('Неправильная длина запроса !');
      5:  WrnBox('Неправильный режим !');
      6:  WrnBox('Ошибка памяти !');
      7:  WrnBox('Ошибка цифрового счётчика !');
      8:  WrnBox('Неправильный порт сумматора !');
      9:  WrnBox('Ошибка доступа !');
      
      99: WrnBox('Переполнение выходного буфера !');

      100:  WrnBox('Требуется режим ''Программирование'' !');
      101:  WrnBox('Требуется режим ''Функционирование'' !');
      102:  WrnBox('Требуется режим ''Перепрограммирование'' !');

      200: WrnBox('Группы не заданы !');
      201: WrnBox('Время и дата не заданы !');
      202: WrnBox('Тарифные графики не заданы !');
      203: WrnBox('Каналы не заданы !');
      204: WrnBox('Начальные показания счётчиков не заданы !');
      205: WrnBox('Электронные счётчики не заданы !');

      else WrnBox('Неизвестная ошибка (код ответа ' + IntToStr(mpbIn[5]) + ')');
    end;
    Result := True;
  end
  else
    Result := False;
end;

{}procedure BadSizeBox(wSize1,wSize2: word);
begin
  ErrBox('Неправильная длина ответа: ' +
         IntToStr(wSize1) + ' вместо ' + IntToStr(wSize2) + ' байт');
end;

{}procedure ShowEscR;
var
  i:    word;
  szT:  array[0..100] of char;
  stT:  string;
begin
  with frmMain do begin
    InitPopZero;

    stT := '';
    for i := 0 to 20 do stT := stT + Chr(Pop);

//    OEMToChar( PChar(stT), @szT ); TODO
//    stT := szT;

    AddTerminal(stT,clGray);
    Stop;
  end;
end;

procedure ShowEscGPS_2;
var
  i:  byte;
  s:  string;

  mpcwPos,
  mpcwNeg,
  mpcwPosCount,
  mpcwNegCount:    array[0..14] of word;
    
begin
  with frmMain do begin
    for i := 0 to 14 do mpcwPos[i] := PopInt;
    for i := 0 to 14 do mpcwNeg[i] := PopInt;
    for i := 0 to 14 do mpcwPosCount[i] := PopInt;
    for i := 0 to 14 do mpcwNegCount[i] := PopInt;

    for i := 0 to 14 do begin
      case i of
        0: s := 'всего';
        1: s := 'часы GPS';
        2: s := 'клавиатура';
        3: s := 'запрос 0xFF 0x0B';
        4: s := 'Esc K';
        5: s := 'Esc k';
        6: s := 'коррекция 0x0B';
        7: s := 'коррекция 0x0C';
        8: s := 'коррекция 0xEE';
        else break;
      end;
      
      s := PackStrR(s,20);
      s := s + PackStrR('+'+IntToStr2(mpcwPos[i] div 60)+':'+ IntToStr2(mpcwPos[i] mod 60),8)+
               PackStrR('+'+IntToStr(mpcwPos[i]),8);
               
      s := s + PackStrR(IntToStr(mpcwPosCount[i]),6);
      
      s := s + PackStrR('-'+IntToStr2(mpcwNeg[i] div 60)+':'+ IntToStr2(mpcwNeg[i] mod 60),8)+
               PackStrR('-'+IntToStr(mpcwNeg[i]),8);
               
      s := s + PackStrR(IntToStr(mpcwNegCount[i]),6);
      AddTerminal(s,clGray);  
    end;
  end;
end;

procedure ShowEscGPS;
var
  i:  byte;
begin
  with frmMain do begin
    InitPopZero;
    AddTerminal(' ',clGray);
    AddTerminal('Параметры GPS',clGray);
    AddTerminal('Порт: '+IntToStr(Pop),clGray);
    AddTerminal('Последний прочитанный статус: '+IntToStr(Pop),clGray);
    AddTerminal('Последний прочитанная версия: '+IntToStr(Pop)+'.'+IntToStr(Pop),clGray);
    AddTerminal('Часовой пояс: '+IntToStr(Pop),clGray);

    AddTerminal(' ',clGray);
    AddTerminal('График коррекции:',clGray);
    for i := 1 to 48 do
      AddTerminal(PackStrR(IntToStr(i),5)+
      IntToStrX((i div 2),2)+'.'+IntToStrX((i mod 2)*30,2)+'   '+
      GetBool2Str,clGray);

    AddTerminal(' ',clGray);
    AddTerminal('Статистика GPS:',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество требований коррекции',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество ошибочных запросов',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество успешных запросов',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество состояний: ошибка',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество состояний: ОК',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество ошибок: ошибка формата времени',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество ошибок: даты различны',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество ошибок: получасы различны',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество успешных коррекций: всего',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество успешных коррекций: с разницей менее 2 секунд',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество успешных коррекций: с разницей менее 5 секунд',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество успешных коррекций: с разницей более 5 секунд',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество успешных коррекций: с разницей более 1 минуты',clGray);
    AddTerminal(PackStrR(IntToStr(PopInt),6) + 'количество успешных коррекций: с разницей более 10 минут',clGray);

    PopInt;
    PopInt;
    PopInt;
    PopInt;
    PopInt;
    PopInt;

    AddTerminal(' ',clGray);
    AddTerminal('Время до последней коррекции GPS:    '+GetTimes2Str,clGray);
    AddTerminal('Время после последней коррекции GPS: '+GetTimes2Str,clGray);
    
    AddTerminal(' ',clGray);
    AddTerminal('Коррекции за текущий месяц:',clGray);
    ShowEscGPS_2;
    AddTerminal(' ',clGray);
    AddTerminal('Коррекции за предыдущий месяц:',clGray);
    ShowEscGPS_2;

    AddTerminal(' ',clGray);
    AddTerminal('Сезонное время (1: зимнее время, 0: летнее время): '+IntToStr(Pop),clGray);
    AddTerminal('Признак добавления одного часа в летнее время:     '+GetBool2Str,clGray);
    
    Stop;
  end;
end;

{}procedure ShowRunFlow(cwIn: word);
var
  stT:  string;
  i:    word;
begin
  InitPopZero;

  stT := '';
  if cwIn > 2 then for i := 0 to cwIn-2 do stT := stT + Chr(Pop);

  with frmMain do AddTerminal(stT,clGray);
  Stop;
end;

{}procedure ShowGetDisplay(Esc: boolean);
type
  CyrillicString = type Ansistring(1251);
var
  i,j:    byte;
  stT:    CyrillicString;
begin
  with frmMain do begin
    if Esc then InitPopZero else InitPopCRC;
    if Assigned(frmConsole) then with frmConsole do begin
      if memDisplay.Lines.Count = 0 then begin
        memDisplay.Lines.Add('');
        memDisplay.Lines.Add('');
      end
      else if memDisplay.Lines.Count = 1 then begin
        memDisplay.Lines.Add('');
      end
    end;

    if Esc then begin Pop; Pop; end;
    stT := '';
    for i:=0 to 15 do begin
      j := Pop;
      if j < $20 then
        stT := stT + ' '
      else
        stT := stT + Chr(j);
    end;
    if Assigned(frmConsole) then frmConsole.memDisplay.Lines[0] := stT;
    AddTerminal(stT,clGray);

    if Esc then begin Pop; Pop; end;
    stT := '';
    for i:=0 to 15 do begin
      j := Pop;
      if j < $20 then
        stT := stT + ' '
      else
        stT := stT + Chr(j);
    end;
    if Assigned(frmConsole) then frmConsole.memDisplay.Lines[1] := stT;
    AddTerminal(stT,clGray);
{
    if Assigned(frmConsole) then with frmConsole.memDisplay do begin
      SelStart  := 0;
      SelLength := 0;
    end;
}
    Stop;

    if Assigned(frmConsole) then frmConsole.StartTimer(1);
  end;
end;

{
procedure ShowGetDisplay(Esc: boolean);
var
  i,j:    byte;
  stT:    string;
begin
  with frmMain do begin
    if Esc then InitPopZero else InitPopCRC;
    if Assigned(frmConsole) then frmConsole.memDisplay.Lines.Clear;

    if Esc then begin Pop; Pop; end;
    stT := '';
    for i:=0 to 15 do begin
      j := Pop;
      if j < $20 then
        stT := stT + ' '
      else
        stT := stT + Chr(j);
    end;
    if Assigned(frmConsole) then frmConsole.memDisplay.Lines.Append(stT);
    AddTerminal(stT,clGray);

    if Esc then begin Pop; Pop; end;
    stT := '';
    for i:=0 to 15 do begin
      j := Pop;
      if j < $20 then
        stT := stT + ' '
      else
        stT := stT + Chr(j);
    end;
    if Assigned(frmConsole) then frmConsole.memDisplay.Lines.Append(stT);
    AddTerminal(stT,clGray);

    if Assigned(frmConsole) then with frmConsole.memDisplay do begin
      SelStart  := 0;
      SelLength := 0;
    end;

    Stop;

    if Assigned(frmConsole) then with frmConsole do
      if chbConsole.Checked then with timConsole do begin
        Interval := updConsole.Position;
        Enabled  := True;
      end;
  end;
end;

}

procedure ShowGetTime;
var
  tiT:  times;
begin
  InitPopCRC;

  with frmMain.memGetTime do begin
    tiT := PopTimes;
    Lines.Add('');
    Lines.Add('Время сумматора:  ' + Times2Str(tiT));
    Lines.Add('Время компьютера: ' + Times2Str(ToTimes(Now)));
    Lines.Add('Разница:          ' + DeltaTimes2Str(tiT,ToTimes(Now)));
  end;
  
//  with frmMain do AddTerminal(stT,clGray);
  Stop;
end;

{}procedure OtherActionsEsc(cwIn: word);
var
  i,j,k:    word;
  sflT: sfloat;
  stT:  string;
  A,B:  times;
  A1,B1: TDateTime;
begin
  if cwIn <> queQueryEsc.cwIn then begin
    BadSizeBox(cwIn,queQueryEsc.cwIn)
  end
  else with frmMain do begin
    if Assigned(frmConsole) then
      frmConsole.UpdateStatus(0);
        
    case queQueryEsc.actAction of

      actEscR: ShowEscR;

      actEscGPS: ShowEscGPS;

      actEscDigital: begin
        InitPopZero;
        for i := 1 to 64 do begin
          AddTerminal(PackStrR(IntToStr(i),6)+
                      PackStrR(IntToHex(Pop,2),3)+PackStrL(IntToStr(PopInt),6)+':'+PackStrR(IntToStr(PopInt),6)+
                      PackStrR(IntToHex(Pop,2),3)+PackStrL(IntToStr(PopInt),6)+':'+PackStrR(IntToStr(PopInt),6)+
                      PackStrR(IntToHex(Pop,2),3)+PackStrL(IntToStr(PopInt),6)+':'+PackStrR(IntToStr(PopInt),6), clGray);
        end;
        Stop;
      end;

      actEscProfile: begin
        InitPopZero;
        for i := 1 to 64 do begin
          AddTerminal(PackStrR(IntToStr(i),6)+
                      PackStrR(IntToStr(PopInt),6)+
                      PackStrL(IntToStr(PopInt),6)+':'+PackStrR(IntToStr(PopInt),6)+
                      PackStrR(IntToStr(PopInt),6), clGray);
        end;
        Stop;
      end;

      actEscLogical: begin
        InitPopZero;
        AddTerminal('CRC программы:    '+IntToHex(Pop*$100+Pop,4),clGray);
        AddTerminal('заводской номер:  '+IntToStr(Pop*$100+Pop),clGray);
        AddTerminal('логический номер: '+IntToStr(Pop),clGray);
        Stop;
      end;

      actEscPrivate: begin
        InitPopZero;
        AddTerminal('заводской номер:  '+IntToStr(Pop*$100+Pop),clGray);
        Stop;
      end;

      actEsc0,
      actEsc1,
      actEsc2,
      actEsc3,
      actEsc4,
      actEsc5,
      actEsc6,
      actEsc7,
      actEsc8,
      actEsc9,
      actEscMinus,
      actEscPoint,
      actEscEnter,
      actEscProgram: EscSearch(actEscDisplay);
      actEscDisplay: ShowGetDisplay(True);

      actRunFlow:  ShowRunFlow(cwIn);
      actTestFlow: ShowRunFlow(cwIn);
      actExitFlow: ShowRunFlow(cwIn);

      actEscU: begin
        InitPopZero;

        for i := 1 to 16 do begin
          A := GetTimes;
          B := GetTimes;

          stT := '';
          try
            with A do A1 := EncodeDate(bYear,bMonth,bDay) + EncodeTime(bHour, bMinute, bSecond, 0);
            with B do B1 := EncodeDate(bYear,bMonth,bDay) + EncodeTime(bHour, bMinute, bSecond, 0);

            if A1 > B1 then
              begin A1 := A1 - B1; stT := stT + ' + '; end
            else
              begin A1 := B1 - A1; stT := stT + ' - '; end;

            DecodeTime(A1, Hour,Min,Sec,MSec);

            stT := stT + IntToStr2(Hour) + ':' + IntToStr2(Min)  + ':' + IntToStr2(Sec)  + '  ';
            if (A1 > 1) then stT := stT + DaysToStr(Trunc(A1));
          except
            stT := '?';
          end;

          AddTerminal(
          PackStrR(IntToStr(i),4) +
                 Times2Str(A) + '    ' +
                 Times2Str(B) + '    ' +stT,clGray);
        end;
        Stop;
      end;

      actEscV: begin
        InitPopZero;
        for i := 1 to 16 do begin
          sflT[0] := Pop;
          sflT[1] := Pop;
          sflT[2] := Pop;
          sflT[3] := Pop;

          AddTerminal(PackStrR(IntToStr(i),4) + FloatToStrF(ToFloat(sflT),ffFixed,8,3),clGray);
        end;
        Stop;
      end;

      actEscS: begin
        InitPopZero;
        for i := 1 to 16 do begin
          sflT[0] := Pop;
          sflT[1] := Pop;
          sflT[2] := Pop;
          sflT[3] := Pop;

          AddTerminal(PackStrR(IntToStr(i),4) + FloatToStrF(ToFloat(sflT),ffFixed,8,3),clGray);
        end;
        Stop;
      end;

      actEscS_time: begin
        InitPopZero;
        for i := 1 to 16 do
          AddTerminal(PackStrR(IntToStr(i),4) + GetTimes2Str,clGray);
        Stop;
      end;

      actEscV_time: begin
        InitPopZero;
        for i := 1 to 16 do
          AddTerminal(PackStrR(IntToStr(i),4) + GetTimes2Str,clGray);
        Stop;
      end;

      actEscL_hi: begin
        AddTerminal(GetDay,clGray);

        InitPopZero;
        for j := 0 to 47 do begin
          stT := GetHour(j);

          for i := 0 to 15 do
            stT := stT + PackStrL(IntToStr(Pop + Pop*$100),5);

          AddTerminal(stT,clGray);
        end;
        Stop;
      end;

      actEscUSD: begin
        AddTerminal(GetDay,clGray);

        InitPopZero;
        for j := 0 to 47 do begin
          stT := GetHour(j);

          for i := 0 to 5 do begin
            sflT[0] := Pop;
            sflT[1] := Pop;
            sflT[2] := Pop;
            sflT[3] := Pop;

            stT := stT + PackStrL( FloatToStrF(ToFloat(sflT),ffFixed,8,2), 8);
          end;

          AddTerminal(stT,clGray);
        end;
        Stop;
      end;

      actEscDef768: begin
        AddTerminal(GetDay,clGray);

        InitPopZero;
        for j := 0 to 47 do begin
          stT := GetHour(j);

          for i := 0 to 15 do
            if Pop = 0 then stT := stT + '- ' else stT := stT + '+ ';

          AddTerminal(stT,clGray);
        end;
        Stop;
      end;

      actEscDef96: begin
        AddTerminal(GetDay,clGray);

        InitPopZero;
        for j := 0 to 47 do begin
          stT := GetHour(j);

          k := PopInt;

          for i := 0 to 15 do
            if (k and ($0001 shl i) = 0) then stT := stT + '- ' else stT := stT + '+ ';

          AddTerminal(stT,clGray);
        end;
        Stop;
      end;

      actEscDef16: begin
        AddTerminal(GetDay,clGray);

        InitPopZero;
        stT := '';

        for i := 0 to 15 do
          stT := stT + IntToStr2(Pop) + '  ';

        AddTerminal(stT,clGray);
        Stop;
      end;

      actEscl_lo: begin
        InitPopZero;
        if Pop <> Ord('l') then ErrBox('!')
        else bEsc_l := Pop;
        Stop;
      end;

      actEscv_lo: begin
        InitPopZero;
        if Pop <> Ord('v') then ErrBox('!')
        else bEsc_v := Pop;
        Stop;
      end;
    end;
  end;
end;

{}function GetReal: extended;
var
  i:    byte;
  sreT: sreal;
begin
  for i := 0 to bREAL - 1 do sreT[i] := Pop;
  Result := FromSReal(sreT);
end;

function GetRealStr: string;
begin
  Result := FloatToStrF(GetReal,ffFixed,12,3);
end;

function GetExtendedStr(exT: extended): string;
begin
  Result := FloatToStrF(exT,ffFixed,12,3);
end;

procedure ShowGetTransEng;
var
  y:    word;
begin
  with frmMain,stgDigitals do begin
    InitPopCRC;

    for y := 0 to bCANALS-1 do with mpCanals[y] do begin
      exKtrans := GetReal;
      Rows[y+1].Strings[digTRANS] := ' ' + FloatToStrF(exKtrans,ffFixed,12,3);

      AddTerminal(PackStrR(IntToStr(y+1),4)+': '+GetExtendedStr(exKtrans),clGray);
    end;
  end;

  SetLoad(bCANALS*1);
  QueryCRC(acGetPulseHou);
end;

procedure ShowGetPulseHou;
var
  y:    word;
begin
  with frmMain,stgDigitals do begin
    InitPopCRC;

    for y := 0 to bCANALS-1 do with mpCanals[y] do begin
      exKpulse := GetReal;
      Rows[y+1].Strings[digPULSE] := ' ' + FloatToStrF(exKpulse,ffFixed,12,3);

      AddTerminal(PackStrR(IntToStr(y+1),4)+': '+GetExtendedStr(exKpulse),clGray);
    end;
  end;

  SetLoad(bCANALS*2);
  QueryCRC(acGetLosse);
end;

procedure ShowGetLosse;
var
  y:    word;
begin
  with frmMain,stgDigitals do begin
    InitPopCRC;

    for y := 0 to bCANALS-1 do with mpCanals[y] do begin
      exKlosse := GetReal*100;
      Rows[y+1].Strings[digLOSSE] := ' ' + FloatToStrF(exKlosse,ffFixed,12,3);

      AddTerminal(PackStrR(IntToStr(y+1),4)+': '+GetExtendedStr(exKlosse),clGray);
    end;
  end;

  SetLoad(bCANALS*3);
  QueryCRC(acGetCount);
end;

procedure ShowGetCount;
var
  y:    word;
begin
  with frmMain,stgDigitals do begin
    InitPopCRC;

    for y := 0 to bCANALS-1 do with mpCanals[y] do begin
      exKcount := GetReal;
      Rows[y+1].Strings[digCOUNT] := ' ' + FloatToStrF(exKcount,ffFixed,12,3);;

      AddTerminal(PackStrR(IntToStr(y+1),4)+': '+GetExtendedStr(exKcount),clGray);
    end;
  end;

  SetLoad(bCANALS*4);

  iwAlfa := 0;
  InitPushCRC;
  Push(iwAlfa);
  QueryCRC(acGetDigit);
end;

procedure ShowGetDigit;
begin
  InitPopCRC;

  with frmMain,mpDigitals[iwAlfa] do begin
    ibPort   := Pop+1;
    ibPhone  := Pop;
    bDevice  := Pop;
    bAddress := Pop;
    ibLine   := Pop+1;

    MakeDigital(iwAlfa);

    AddTerminal(PackStrR(IntToStr(iwAlfa+1),4)+': ' +
      IntToStr2(ibPort)+'.'+IntToStr2(ibPhone)+'.'+IntToStrX(bDevice,3)+'.'+
      IntToStr2(bAddress)+'.'+IntToStr2(ibLine),clGray);

    SetLoad(bCANALS*4+iwAlfa);

    if iwAlfa < bCANALS-1 then begin
      Inc(iwAlfa);

      InitPushCRC;
      Push(iwAlfa);
      QueryCRC(acGetDigit);
    end
    else begin
      if chbLevel.Checked then
        QueryCRC(acGetLevel)
      else
        InfBox('Список каналов прочитан успешно');
    end;
  end;
end;

procedure ShowGetLevel;
var
  y:    word;
begin
  with frmMain,stgDigitals do begin
    InitPopCRC;

    for y := 0 to bCANALS-1 do with mpCanals[y] do begin
      exKlevel := GetReal;
      Rows[y+1].Strings[digLEVEL] := ' ' + FloatToStrF(exKlevel,ffFixed,12,3);;

      AddTerminal(PackStrR(IntToStr(y+1),4)+': '+GetExtendedStr(exKlevel),clGray);
    end;
  end;

  InfBox('Список каналов прочитан успешно');
end;

procedure ShowGetGroups;
var
  x:    word;
begin
  InitPopCRC;

  with frmMain,mpgrGroups[iwAlfa] do begin
    bSize := Pop;
    for x := 0 to bCANALS-1 do with mpnoNodes[x] do ibCanal := Pop;

    for x := 0 to bCANALS-1 do mpbGroups[iwAlfa,x] := 0;

    if bSize > 0 then begin
      for x := 0 to bSize-1 do with mpnoNodes[x] do begin
        if (ibCanal and $80) = 0 then
          mpbGroups[iwAlfa,ibCanal and $7F] := 1
        else
          mpbGroups[iwAlfa,ibCanal and $7F] := 2;
      end;
    end;

    MakeGroup(iwAlfa);

    IncLoad;
    if iwAlfa < bGROUPS-1 then begin
      Inc(iwAlfa);

      InitPushCRC;
      Push(iwAlfa);
      QueryCRC(acGetGroups);
    end
    else InfBox('Список групп прочитан успешно');
  end;
end;

procedure ShowSetGroups;
begin
  if iwAlfa < bGROUPS-1 then begin
    Inc(iwAlfa);
    IncLoad;

    with frmMain do begin
      SaveGroups(iwAlfa);
      QueryCRC(acSetGroups);
    end;
  end
  else InfBox('Список групп записан успешно');
end;

procedure ShowGetPhones;
var
  x,i:  word;
  stT:  string;
begin
  InitPopCRC;

  with frmMain do begin
    stT := ' ';
    for x := 1 to NUMBERS do begin
      i := Pop;
      if Chr(i) in ['0'..'9','a'..'z','A'..'Z'] then
        stT := stT + Chr(i)
      else
        stT := stT + ' ';
    end;

    stgPhones.Rows[iwAlfa+1].Strings[1] := stT;
//    AddInfo(IntToStr2(iwAlfa+1) + ': ' + stT);

    IncLoad;
    if iwAlfa < bCANALS-1 then begin
      Inc(iwAlfa);

      InitPushCRC;
      Push(1);
      Push(iwAlfa);
      QueryCRC(acGetPhones);
    end
    else InfBox('Список телефонов прочитан успешно');
  end;
end;

procedure ShowSetPhones;
begin
  if iwAlfa < bCANALS-1 then begin
    Inc(iwAlfa);
    IncLoad;

    with frmMain do begin
      SavePhones(iwAlfa);
      QueryCRC(acSetPhones);
    end;
  end
  else InfBox('Список телефонов записан успешно');
end;

procedure ShowGetAddresses;
begin
  InitPopCRC;

  with frmMain do begin
    with stgAddresses.Rows[iwAlfa+1] do begin
      Strings[1] := ' '+IntToStr(PopLong);
      Strings[2] := ' '+IntToStr(PopLong);

//      AddInfo(IntToStr2(iwAlfa+1) + ': ' + Strings[1] + '.' + Strings[2]);
    end;

    IncLoad;
    if iwAlfa < bCANALS-1 then begin
      Inc(iwAlfa);

      InitPushCRC;
      Push(28);
      Push(iwAlfa);
      QueryCRC(acGetAddresses);
    end
    else InfBox('Список адресов и паролей прочитан успешно');
  end;
end;

procedure ShowSetAddresses;
begin
  if iwAlfa < bCANALS-1 then begin
    Inc(iwAlfa);
    IncLoad;

    with frmMain do begin
      SaveAddresses(iwAlfa);
      QueryCRC(acSetAddresses);
    end;
  end
  else InfBox('Список адресов и паролей записан успешно');
end;

procedure ShowGetAddresses2;
var
  x,i:  word;
  stT:  string;
begin
  InitPopCRC;

  with frmMain do begin
    stgAddresses2.Rows[iwAlfa+1].Strings[1] := ' '+IntToStr(PopLong);

    stT := ' ';
    for x := 1 to NUMBERS do begin
      i := Pop;
      if Chr(i) in ['0'..'9','a'..'z','A'..'Z'] then
        stT := stT + Chr(i)
      else
        stT := stT + ' ';
    end;

    stgAddresses2.Rows[iwAlfa+1].Strings[2] := stT;

    IncLoad;
    if iwAlfa < bCANALS-1 then begin
      Inc(iwAlfa);

      InitPushCRC;
      Push(136);
      Push(iwAlfa);
      QueryCRC(acGetAddresses2);
    end
    else InfBox('Список адресов и паролей прочитан успешно');
  end;
end;

procedure ShowSetAddresses2;
begin
  if iwAlfa < bCANALS-1 then begin
    Inc(iwAlfa);
    IncLoad;

    with frmMain do begin
      SaveAddresses2(iwAlfa);
      QueryCRC(acSetAddresses2);
    end;
  end
  else InfBox('Список адресов и паролей записан успешно');
end;

procedure ShowGetObjectName;
var
  x,i:  word;
  stT:  string;
begin
  InitPopCRC;

  with frmMain do begin
    stT := ' ';
    for x := 1 to NAMES do begin
      i := Pop;
      if i >= 32 then
        stT := stT + Chr(i)
      else
        stT := stT + ' ';
    end;

    edtObjectName.Text := TrimRight(stT);
    InfBox('Название объекта прочитано успешно');
  end;
end;

procedure ShowSetObjectName;
begin
  InfBox('Название объекта записано успешно');
end;

procedure ShowGetCanalsNames;
var
  x,i:  word;
  stT:  string;
begin
  InitPopCRC;

  with frmMain do begin
    stT := ' ';
    for x := 1 to NAMES do begin
      i := Pop;
      if i >= 32 then
        stT := stT + Chr(i)
      else
        stT := stT + ' ';
    end;

    stgCanalsNames.Rows[iwAlfa+1].Strings[1] := TrimRight(stT);

    IncLoad;
    if iwAlfa < bCANALS-1 then begin
      Inc(iwAlfa);

      InitPushCRC;
      Push(113);
      Push(iwAlfa);
      QueryCRC(acGetCanalsNames);
    end
    else InfBox('Список названий каналов прочитан успешно');
  end;
end;

procedure ShowSetCanalsNames;
begin
  if iwAlfa < bCANALS-1 then begin
    Inc(iwAlfa);
    IncLoad;

    with frmMain do begin
      SaveCanalsNames(iwAlfa);
      QueryCRC(acSetCanalsNames);
    end;
  end
  else InfBox('Список названий каналов записан успешно');
end;

procedure ShowGetGroupsNames;
var
  x,i:  word;
  stT:  string;
begin
  InitPopCRC;

  with frmMain do begin
    stT := ' ';
    for x := 1 to NAMES do begin
      i := Pop;
      if i >= 32 then
        stT := stT + Chr(i)
      else
        stT := stT + ' ';
    end;

    stgGroupsNames.Rows[iwAlfa+1].Strings[1] := TrimRight(stT);

    IncLoad;
    if iwAlfa < bGROUPS-1 then begin
      Inc(iwAlfa);

      InitPushCRC;
      Push(115);
      Push(iwAlfa);
      QueryCRC(acGetGroupsNames);
    end
    else InfBox('Список названий групп прочитан успешно');
  end;
end;

procedure ShowSetGroupsNames;
begin
  if iwAlfa < bGROUPS-1 then begin
    Inc(iwAlfa);
    IncLoad;

    with frmMain do begin
      SaveGroupsNames(iwAlfa);
      QueryCRC(acSetGroupsNames);
    end;
  end
  else InfBox('Список названий групп записан успешно');
end;

procedure ShowGetRelaxs;
var
  i,j:  word;
begin
  try
    InitPopCRC; Pop; Pop;
    with frmMain,lbxRelaxs do begin
      j := Pop;
      for i := 1 to j do AddItem('', TRelax.Create(GetTimes));
      ShowRelaxs;
      InfBox('Список праздников прочитан успешно: '+IntToStr(Count));
    end;
  except
    ErrBox('Ошибка при чтении праздников !');
  end;  
end;

procedure ShowSetRelaxs;
begin
  InfBox('Список праздников записан успешно');
end;

function GetTime: string;
var
  bSecond,
  bMinute,
  bHour,
  bDay,
  bMonth,
  bYear:        byte;
begin
  bSecond := Pop;
  bMinute := Pop;
  bHour   := Pop;
  bDay    := Pop;
  bMonth  := Pop;
  bYear   := Pop;

  Result  := IntToStr2( bHour    ) + ':' +
             IntToStr2( bMinute  ) + ':' +
             IntToStr2( bSecond  ) + ' ' +
             IntToStr2( bDay     ) + '.' +
             IntToStr2( bMonth   ) + '.' +
             IntToStr2( bYear    );
end;
(*
function GetRecReal(j: byte): string;
var
  i:    byte;
  sreT: sreal;
begin
  for i := 0 to bREAL - 1 do sreT[i] := mpbRec[j + i];
  Result := FloatToStrF(FromSReal(sreT),ffFixed,12,3);
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

    Result := IntToStr2(bHour)   + ':' +
              IntToStr2(bMinute) + ':' +
              IntToStr2(bSecond) + ' ' +
              IntToStr2(bDay)    + '.' +
              IntToStr2(bMonth)  + '.' +
              IntToStr2(bYear);
  end;
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

function GetRecEvent: string;
var
  i:  byte;
begin
  i := mpbRec[7] and $0F;
  case i of
    1: Result := ' прибор';
    3: Result := ' фаза 1';
    4: Result := ' фаза 2';
    5: Result := ' фаза 3';
    else Result := ' неизвестное событие '+IntToStr(i);
  end;

  if i in [1,3,4,5] then begin
  if (mpbRec[7] and $F0) >0 
  then 
   Result := ', событие - выкл. '+ Result
  else
   Result := ', событие - вкл.  '+ Result;
  end; 
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

function GetRecord: string;
var
  i:    byte;
  stT:  string;
begin
  Result := PackStrL(GetTime,20) + ' ' +
            PackStrL(IntToStr((PopInt shl 16)+PopInt),4) + ' ';

  bRecCode := Pop;

  Result := Result + PackStrL(IntToStr(bRecCode),3) + '  ';

  for i := 0 to bRECORD_BUFF-1 do begin
    mpbRec[i] := Pop;
    Result := Result + ' ' +IntToHex(mpbRec[i],2);
  end;

  case bRecCode of
    0: stT := 'начало догонки';
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

    62: stT := 'канал запрещен !';
    63: stT := 'получас запрещен !';
    64: stT := 'регул. опрос: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    65: stT := 'ручной опрос: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    66: stT := 'готовность: '+IntToStr(mpbRec[1]*$100+mpbRec[2])+' ========';
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
    80: stT := 'ошибка '+IntToHex(mpbRec[1],2)+'.'+IntToHex(mpbRec[2],2);
    81: stT := 'начало дозвона';
    82: stT := 'конец  дозвона';
    83: stT := 'начало отбоя';
    84: stT := 'конец  отбоя';
    85: stT := 'опрос завершен ==========';
    86: stT := 'опрос завершен ! ========';
    87: stT := 'опрос прерван ===========';
    88: stT := 'начало расчёта';
    89: stT := 'конец  расчёта';
    90: stT := 'без расчёта';

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
    161: stT := 'без соединения !';
    162: stT := 'без разъединения !';

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

    210: stT := 'коррекция c клавиатуры: '+GetRecTime(0);
    211: stT := 'коррекция - запрос 0xFF 0x0B: '+GetRecTime(0);
    212: stT := 'коррекция - запрос Esc K: '+GetRecTime(0);
    213: stT := 'коррекция - запрос Esc k: '+GetRecTime(0);
    214: stT := 'коррекция 1: '+GetRecTime(0);
    215: stT := 'коррекция 2: '+GetRecTime(0);
    216: stT := 'коррекция 3: '+GetRecTime(0);
    217: stT := 'коррекция: ОК';
    
    else stT := '?';
  end;

 if bRecCode in [62..84,126..162] then stT := IntToStr(mpbRec[0]+1)+': '+stT;
 Result := Result + '   ' + stT;
end;
*)
procedure ShowGetRecords;
var
  i:    word;
  stT:  string;
begin
  InitPopCRC;

  PopLong; PopInt;

  with frmMain do begin
    for i := 0 to bRECORD_BLOCK-1 do begin
{      if iwAlfa*bRECORD_BLOCK+i < wRECORDS then
        redRecords.Lines.Append(PackStrR(IntToStr(iwAlfa*bRECORD_BLOCK+i),4)+GetRecord); }
     stT := GetRecord;
     if bRecCode = $FF then begin
       //redRecords.Lines.Append('-')
     end
     else begin
        Inc(cwRec);
        redRecords.Lines.Append(PackStrR(IntToStr(cwRec),4)+stT);
     end;

    end;

    redRecords.Lines.Append('-');

    IncLoad;
    if iwAlfa < bRECORD_PAGES-1 then begin
      Inc(iwAlfa);

      InitPushCRC;
      Push(20);
      Push(rgrEvent.ItemIndex);
      Push(iwAlfa);
    end
    else InfBox('Список событий прочитан успешно');
  end;
end;

{
function GetRecordIndex: string;
begin
  cdwRec   := PopInt*$10000+PopInt;
  cwRecMax := PopInt;

  Result := IntToStr(cdwRec)+' % '+
            IntToStr(cwRecMax)+' = '+
            IntToStr(cdwRec mod cwRecMax)+'  ';
end;


procedure ShowRecordsBlock;
var
i: byte;
w: word;
begin
  with frmMain do begin
    InitPop;
    memRecord.Lines.Append(GetRecordIndex);

    for i := 0 to bRECORD_BLOCK-1 do
      mpstRecords[i] := PackStrR(IntToStr(i+iwAlfa*bRECORD_BLOCK),6)+GetRecord;

    if iwAlfa = 0 then
      w := ((cdwRec mod cwRecMax) mod bRECORD_BLOCK)-1
    else
      w := bRECORD_BLOCK-1;

    for i := w downto 0 do
      memRecord.Lines.Append(mpstRecords[i]);

    ShowLoad(iwAlfa + 1);
    if iwAlfa < bRECORD-1 then begin
      Inc(iwAlfa);

      InitPush;
      Push(20);
      Push(rgrEvent.ItemIndex);
      Push(iwAlfa mod $100);
      Query(acGetRecordsBlock);
    end
    else LoadOK;
  end;
end;

}

procedure ShowGetDivid;
begin
  with frmMain,stgParams do begin
    InitPopCRC;

    with mpParams2[iwAlfa] do begin
      exKdivid := GetReal;
      Rows[iwAlfa+1].Strings[digDIVID] := ' ' + FloatToStrF(exKdivid,ffFixed,12,3);

      AddTerminal(PackStrR(IntToStr(iwAlfa+1),4)+': '+GetExtendedStr(exKdivid),clGray);
    end;
  end;

  SetLoad(iwAlfa);

  if iwAlfa < wPARAMS-1 then begin
    Inc(iwAlfa);

    InitPushCRC;
    Push(iwAlfa div $100);
    Push(iwAlfa mod $100);
    QueryCRC(acGetDivid);
  end
  else begin
    iwAlfa := 0;
    InitPushCRC;
    Push(iwAlfa div $100);
    Push(iwAlfa mod $100);
    QueryCRC(acGetParam);
  end;
end;

procedure ShowGetParam;
begin
  InitPopCRC;

  with frmMain,mpParams1[iwAlfa] do begin
    ibPort   := Pop+1;
    ibPhone  := Pop;
    bDevice  := Pop;
    bAddress := Pop;
    ibLine   := Pop;

    MakeParams1(iwAlfa);

    AddTerminal(PackStrR(IntToStr(iwAlfa+1),4)+': ' +
      IntToStr2(ibPort)+'.'+IntToStr2(ibPhone)+'.'+IntToStrX(bDevice,3)+'.'+
      IntToStr2(bAddress)+'.'+IntToStr2(ibLine),clGray);
  end;

  SetLoad(wPARAMS*1+iwAlfa);

  if iwAlfa < wPARAMS-1 then begin
    Inc(iwAlfa);

    InitPushCRC;
    Push(iwAlfa div $100);
    Push(iwAlfa mod $100);
    QueryCRC(acGetParam);
  end
  else InfBox('Список параметров прочитан успешно');
end;

{}procedure OtherActionsCRC(cwIn: word);
var
  i,j:    word;
  sreT: sreal;
begin
  cbRepeat := 0;

  if cwIn <> queQueryCRC.cwIn then begin
    if not queQueryCRC.fConsole then
      BadSizeBox(cwIn,queQueryCRC.cwIn)
    else if Assigned(frmConsole) then begin
      frmConsole.UpdateStatus(3);
      frmConsole.StartTimer(2);
    end;
  end
  else with frmMain do begin
    if Assigned(frmConsole) then
      frmConsole.UpdateStatus(0);

    case queQueryCRC.actAction1 of

    crcGetPublic: ShowGetPublic;

    acSetTransEng: begin
      if mpbIn[5] = 0 then begin
        SetLoad(bCANALS*1);
        InitPushCRC;

        for i := 0 to bCANALS do with mpCanals[i] do begin
          sreT := ToSReal( 1{exKtrans} );
          for j := 0 to bREAL - 1 do Push(sreT[j]);

          AddTerminal(PackStrR(IntToStr(i+1),4)+': '+GetExtendedStr(1{exKtrans}),clGray);
        end;

        QueryCRC(acSetTransCnt);
      end;
    end;

    acSetTransCnt: begin
      if mpbIn[5] = 0 then begin
        SetLoad(bCANALS*2);
        InitPushCRC;

        for i := 0 to bCANALS do with mpCanals[i] do begin
          sreT := ToSReal( exKpulse );
          for j := 0 to bREAL - 1 do Push(sreT[j]);

          AddTerminal(PackStrR(IntToStr(i+1),4)+': '+GetExtendedStr(exKpulse),clGray);
        end;

        QueryCRC(acSetPulseHou);
      end;
    end;

    acSetPulseHou: begin
      if mpbIn[5] = 0 then begin
        SetLoad(bCANALS*3);
        InitPushCRC;

        for i := 0 to bCANALS do with mpCanals[i] do begin
          sreT := ToSReal( exKpulse );
          for j := 0 to bREAL - 1 do Push(sreT[j]);

          AddTerminal(PackStrR(IntToStr(i+1),4)+': '+GetExtendedStr(exKpulse),clGray);
        end;

        QueryCRC(acSetPulseMnt);
      end;
    end;

    acSetPulseMnt: begin
      if mpbIn[5] = 0 then begin
        SetLoad(bCANALS*4);
        InitPushCRC;

        for i := 0 to bCANALS do with mpCanals[i] do begin
          sreT := ToSReal( exKlosse/100 );
          for j := 0 to bREAL - 1 do Push(sreT[j]);

          AddTerminal(PackStrR(IntToStr(i+1),4)+': '+GetExtendedStr(exKlosse),clGray);
        end;

        QueryCRC(acSetLosse);
      end;
    end;

    acSetLosse: begin
      if mpbIn[5] = 0 then begin
        SetLoad(bCANALS*5);
        InitPushCRC;

        for i := 0 to bCANALS do with mpCanals[i] do begin
          sreT := ToSReal( exKcount );
          for j := 0 to bREAL - 1 do Push(sreT[j]);

          AddTerminal(PackStrR(IntToStr(i+1),4)+': '+GetExtendedStr(exKcount),clGray);
        end;

        QueryCRC(acSetCount);
      end;
    end;

    acSetCount: begin
      if mpbIn[5] = 0 then begin
        SetLoad(bCANALS*6);

        iwAlfa := 0;

        InitPushCRC;
        with mpDigitals[iwAlfa] do begin
          Push(iwAlfa);

          if ibPort > 0 then Push(ibPort-1) else Push(0);
          Push(ibPhone);
          Push(bDevice);
          Push(bAddress);
          if ibLine > 0 then Push(ibLine-1) else Push(0);
        end;

        QueryCRC(acSetDigit);
      end;
    end;

    acSetDigit: begin
      if mpbIn[5] = 0 then begin
        SetLoad(bCANALS*6+iwAlfa+1);

        if iwAlfa < bCANALS-1 then begin
          Inc(iwAlfa);

          InitPushCRC;
          with mpDigitals[iwAlfa] do begin
            Push(iwAlfa);

            if ibPort > 0 then Push(ibPort-1) else Push(0);
            Push(ibPhone);
            Push(bDevice);
            Push(bAddress);
            if ibLine > 0 then Push(ibLine-1) else Push(0);
          end;
          QueryCRC(acSetDigit);
        end
        else begin
          if chbLevel.Checked then begin
            InitPushCRC;

            for i := 0 to bCANALS do with mpCanals[i] do begin
              sreT := ToSReal( exKlevel );
              for j := 0 to bREAL - 1 do Push(sreT[j]);

              AddTerminal(PackStrR(IntToStr(i+1),4)+': '+GetExtendedStr(exKlevel),clGray);
            end;

            QueryCRC(acSetLevel);
          end
          else begin
            InfBox('Список каналов записан успешно');
            InfBox('После задания каналов следует задать таймауты по программе 98:' + #13#10 +
                   'для прямой связи 500..1000 мс, для модемной связи 4000..8000 мс');
          end;         
        end;
      end;
    end;

    acSetLevel: begin
      if mpbIn[5] = 0 then begin
            InfBox('Список каналов записан успешно');
            InfBox('После задания каналов следует задать таймауты по программе 98:' + #13#10 +
                   'для прямой связи 500..1000 мс, для модемной связи 4000..8000 мс');
      end;
    end;

    acSetDivid: begin
      if mpbIn[5] = 0 then begin
        if iwAlfa < wPARAMS-1 then begin
          SetLoad(iwAlfa);

          Inc(iwAlfa);

          InitPushCRC;
          Push(iwAlfa div $100);
          Push(iwAlfa mod $100);

          with mpParams2[iwAlfa] do begin
            sreT := ToSReal( exKdivid );
            for j := 0 to bREAL - 1 do Push(sreT[j]);

            AddTerminal(PackStrR(IntToStr(iwAlfa+1),4)+': '+GetExtendedStr(exKdivid),clGray);
          end;

          QueryCRC(acSetDivid);
        end
        else begin
          iwAlfa := 0;

          InitPushCRC;
          with mpParams1[iwAlfa] do begin
            Push(iwAlfa div $100);
            Push(iwAlfa mod $100);

            if ibPort > 0 then Push(ibPort-1) else Push(0);
            Push(ibPhone);
            Push(bDevice);
            Push(bAddress);
            Push(ibLine);
          end;

          QueryCRC(acSetParam);
        end;
      end;
    end;

    acSetParam: begin
      if mpbIn[5] = 0 then begin
        SetLoad(wPARAMS*1+iwAlfa);

        if iwAlfa < wPARAMS-1 then begin
          Inc(iwAlfa);

          InitPushCRC;
          with mpParams1[iwAlfa] do begin
            Push(iwAlfa div $100);
            Push(iwAlfa mod $100);

            if ibPort > 0 then Push(ibPort-1) else Push(0);
            Push(ibPhone);
            Push(bDevice);
            Push(bAddress);
            Push(ibLine);
          end;
          QueryCRC(acSetParam);
        end else begin
          if frmMain.chbResetDivid.Checked then
            QueryCRC(acResetDivid)
          else
            InfBox('Список параметров записан успешно');
        end;
      end;
    end;

    acSetOldPowTariff: begin
      if mpbIn[5] = 0 then InfBox('Запись раздельного тарифа для мощности за месяц ' + IntToStr(iwAlfa + 1) + ' завершена успешно');
      Stop;
    end;

    acSetOldEngTariff: begin
      if mpbIn[5] = 0 then InfBox('Запись раздельного тарифа для энергии за месяц ' + IntToStr(iwAlfa + 1) + ' завершена успешно');
      Stop;
    end;

    acSetOldPubTariff: begin
      if mpbIn[5] = 0 then InfBox('Запись совмещённых тарифов за месяц ' + IntToStr(iwAlfa + 1) + ' завершена успешно');
      Stop;
    end;

    acSetAllOldPowTariffs: SetAllOldPowTariffs;
    acSetAllOldEngTariffs: SetAllOldEngTariffs;
    acSetAllOldPubTariffs: SetAllOldPubTariffs;

    crcGetOldPowTariff: begin ShowGetOldPowTariffs; end;
    crcGetOldEngTariff: begin ShowGetOldEngTariffs; end;
    crcGetOldPubTariff: begin ShowGetOldPubTariffs; end;

      acGetTransEng: ShowGetTransEng;
      acGetPulseHou: ShowGetPulseHou;
      acGetLosse: ShowGetLosse;
      acGetCount: ShowGetCount;
      acGetDigit: ShowGetDigit;
      acGetLevel: ShowGetLevel;

      acGetGroups: ShowGetGroups;
      acSetGroups: ShowSetGroups;

      acGetGraphInquiry: ShowGetGraphInquiry;
      acSetGraphInquiry: ShowSetGraphInquiry;
      acGetGraphCorrect: ShowGetGraphCorrect;
      acGetGraphRecalc:  ShowGetGraphRecalc;
      acGetGraphTransit: ShowGetGraphTransit;

      acGetPhones: ShowGetPhones;
      acSetPhones: ShowSetPhones;

      acGetAddresses: ShowGetAddresses;
      acSetAddresses: ShowSetAddresses;

      acGetAddresses2: ShowGetAddresses2;
      acSetAddresses2: ShowSetAddresses2;

      acGetObjectName: ShowGetObjectName;
      acSetObjectName: ShowSetObjectName;
      acGetCanalsNames: ShowGetCanalsNames;
      acSetCanalsNames: ShowSetCanalsNames;
      acGetGroupsNames: ShowGetGroupsNames;
      acSetGroupsNames: ShowSetGroupsNames;

      acGetRelaxs: ShowGetRelaxs;
      acSetRelaxs: ShowSetRelaxs;
      
      acGetRecords: ShowGetRecords;
      acGetMemory0: ShowGetMemory0;
      acGetMemory1: ShowGetMemory1;

      acGetDivid: ShowGetDivid;
      acGetParam: ShowGetParam;

      crcSetKey:     QueryCRC(crcGetDisplay);
      crcGetDisplay: ShowGetDisplay(False);
      
      crcGetTime: ShowGetTime;
    end;
  end;
end;

{}procedure PostInputComPort;
var
  cwIn: word;
begin
  with frmMain do begin

    cwIn := ComPort.InBuffUsed;
    AddTerminal('// принято с порта: ' + IntToStr(cwIn) + ' байт',clGray);

    ComPort.GetBlock(mpbIn, cwIn);

    ShowInData(cwIn);
    ShowTimeout;

    if system1 = system_esc then begin
      if queQueryEsc.actAction in [actNone,actCtrlZ,actEscA] then begin
      end

      else begin
        if cwIn = 0 then ErrBox('Нет ответа от сумматора !')
        else
  {      if (CRC16(mpbIn,cwIn) <> 0) then ErrBox('Ошибка контрольной суммы !')
        else}
        OtherActionsEsc(cwIn);
      end;
    end

    else begin
      if queQueryCRC.actAction1 in [crcNone] then begin
      end;

      if (cwIn = 0) and (cbRepeat < 5) then with frmMain do begin
        Inc(cbRepeat);
        Inc(cbMaxRepeat); ShowRepeat;
        AddTerminal('повтор: ' + IntToStr(cbRepeat),clGray);
        QueryCRC(queQueryCRC.actAction1);
      end

      else begin
        if cwIn = 0 then begin
          if not queQueryCRC.fConsole then
            ErrBox('Нет ответа от сумматора !')
          else if Assigned(frmConsole) then begin
            frmConsole.UpdateStatus(1);
            frmConsole.StartTimer(1);
          end;
        end
        else if (CRC16(mpbIn,cwIn) <> 0) then begin
          if not queQueryCRC.fConsole then
            ErrBox('Ошибка контрольной суммы !')
          else if Assigned(frmConsole) then begin
            frmConsole.UpdateStatus(2);
            frmConsole.StartTimer(3);
          end;
        end
        else if not MultiBox(cwIn) then begin
          OtherActionsCRC(cwIn);
        end;
      end;
    end

  end;
end;

{}procedure PostInputSocket(s: string);
var
  cwIn: word;
  i:  word;
begin
  with frmMain do begin

    cwIn := Length(s);
    AddTerminal('// принято с сокета: ' + IntToStr(cwIn) + ' байт',clGray);

    if cwIn = 0 then exit;
    for i := 0 to Length(s) - 1 do  mpbIn[i] := Ord(s[i+1]);

    ShowInData(cwIn);
    ShowTimeout;

    if system1 = system_esc then begin
      if queQueryEsc.actAction in [actNone,actCtrlZ,actEscA] then begin
      end

      else begin
        if cwIn = 0 then ErrBox('Нет ответа от сумматора !')
        else
  {      if (CRC16(mpbIn,cwIn) <> 0) then ErrBox('Ошибка контрольной суммы !')
        else}
        OtherActionsEsc(cwIn);
      end;
    end

    else begin
      if queQueryCRC.actAction1 in [crcNone] then begin
      end;

      if (cwIn = 0) and (cbRepeat < 5) then with frmMain do begin
        Inc(cbRepeat);
        Inc(cbMaxRepeat); ShowRepeat;
        AddTerminal('повтор: ' + IntToStr(cbRepeat),clGray);
        QueryCRC(queQueryCRC.actAction1);
      end

      else begin
        if cwIn = 0 then begin
          if not queQueryCRC.fConsole then
            ErrBox('Нет ответа от сумматора !')
          else if Assigned(frmConsole) then begin
            frmConsole.UpdateStatus(1);
            frmConsole.StartTimer(1);
          end;
        end
        else if (CRC16(mpbIn,cwIn) <> 0) then begin
          if not queQueryCRC.fConsole then
            ErrBox('Ошибка контрольной суммы !')
          else if Assigned(frmConsole) then begin
            frmConsole.UpdateStatus(2);
            frmConsole.StartTimer(3);
          end;
        end
        else if not MultiBox(cwIn) then begin
          OtherActionsCRC(cwIn);
        end;
      end;
    end

  end;
end;

end.


