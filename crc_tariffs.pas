unit crc_tariffs;

interface

uses Grids, SysUtils;

procedure ShowGetPublic;

procedure ShowGetOldPowTariffs;
procedure ShowGetOldEngTariffs;
procedure ShowGetOldPubTariffs;

procedure SetAllOldPowTariffs;
procedure SetAllOldEngTariffs;
procedure SetAllOldPubTariffs;

implementation

uses kernel, main, soutput, support, load, terminal;

procedure ShowGetPublic;
begin
  with frmMain,rgrPublic do begin
    InitPopCRC;

    if Pop = 0 then ItemIndex := 0 else ItemIndex := 1;
    rgrPublicClick(nil);
    Stop;

    if ItemIndex < 2 then InfBox('Тип учёта тарифов для мощности и энергии: ' + Items[ItemIndex]);
  end;
end;

procedure ShowTariffs(stgAllTariffs: TStringGrid);
var
  i:    word;
begin
  with stgAllTariffs,stZone do begin
    InitPopCRC;
    bSize := Pop;

    for i := 1 to bBREAKS do begin
      with mpTariffs[i] do begin
        bHour   := Pop;
        bMinute := Pop;
        bTariff := Pop;

        if (bHour > 0) or (bMinute > 0) then
          Cols[iwAlfa+1].Strings[i] := ' ' + IntToStr2(bHour) +
                                       ':' + IntToStr2(bMinute) +
                                       ' - ' + IntToStr(bTariff+1)
        else
          Cols[iwAlfa+1].Strings[i] := '';
      end;
    end;
  end;
end;

procedure ShowGetOldPowTariffs;
begin
  with frmMain do begin
    ShowTariffs(stgAllTariffsPow);

    if iwAlfa < 12-1 then begin
      IncLoad;

      Inc(iwAlfa);
      InitPushCRC;
      Push(iwAlfa);
      Push(0);
      QueryCRC(crcGetOldPowTariff);
    end
    else begin
      pgcTariffs.ActivePage := tbsEng;

      iwAlfa := 0;
      InitPushCRC;
      Push(iwAlfa);
      Push(0);
      InitLoad('Чтение раздельных тарифов для энергии', 12-1, crcGetOldEngTariff);
    end;
  end;
end;

procedure ShowGetOldEngTariffs;
begin
  with frmMain do begin
    ShowTariffs(stgAllTariffsEng);

    if iwAlfa < 12-1 then begin
      IncLoad;

      Inc(iwAlfa);
      InitPushCRC;
      Push(iwAlfa);
      Push(0);
      QueryCRC(crcGetOldEngTariff);
    end
    else InfBox('Чтение раздельных тарифов для мощности и энергии завершено успешно');
  end;
end;

procedure ShowGetOldPubTariffs;
begin
  with frmMain do begin
    ShowTariffs(stgAllTariffsPub);

    if iwAlfa < 12-1 then begin
      IncLoad;

      Inc(iwAlfa);
      InitPushCRC;
      Push(iwAlfa);
      Push(0);
      QueryCRC(crcGetOldPubTariff);
    end
    else InfBox('Чтение совмещённых тарифов для мощности и энергии завершено успешно');
  end;
end;

procedure SetAllOldPowTariffs;
begin
  with frmMain do begin
    InitPopCRC;
    if Pop = 0 then begin
      if iwAlfa < 12-1 then begin
        IncLoad;

        Inc(iwAlfa);
        SaveTariff(stgAllTariffsPow,iwAlfa,0);
        QueryCRC(acSetAllOldPowTariffs);
      end
      else begin
        pgcTariffs.ActivePage := tbsEng;

        iwAlfa := 0;
        SaveTariff(stgAllTariffsEng,iwAlfa,0);
        InitLoad('Запись раздельных тарифов для энергии', 12-1, acSetAllOldEngTariffs);
      end;
    end
    else ErrBox('Ошибка при записи раздельных тарифов для мощности за весь год !');
  end;
end;

procedure SetAllOldEngTariffs;
begin
  with frmMain do begin
    InitPopCRC;
    if Pop = 0 then begin
      if iwAlfa < 12-1 then begin
        IncLoad;

        Inc(iwAlfa);
        SaveTariff(stgAllTariffsEng,iwAlfa,0);
        QueryCRC(acSetAllOldEngTariffs);
      end
      else InfBox('Запись раздельных тарифов для мощности и энергии за весь год завершена успешно')
    end
    else ErrBox('Ошибка при записи раздельных тарифов для энергии за весь год !');
  end;
end;

procedure SetAllOldPubTariffs;
begin
  with frmMain do begin
    InitPopCRC;
    if Pop = 0 then begin
      if iwAlfa < 12-1 then begin
        IncLoad;

        Inc(iwAlfa);
        SaveTariff(stgAllTariffsPub,iwAlfa,0);
        QueryCRC(acSetAllOldPubTariffs);
      end
      else InfBox('Запись совмещённых тарифов для мощности и энергии за весь год завершена успешно')
    end
    else ErrBox('Ошибка при записи совмещённых тарифов для мощности и энергии за весь год !');
  end;
end;

end.





