unit Trollhunter.Zip;

interface

uses
  SysUtils,
  ZipForge;

const
  PWD = '4444';

type
  TZip = class(TZipForge)
    function ExtractToText(const AFileName: string): string;
    function ExtractTextFromFile(const ArchiveFileName,
      AFileName: string): string;
    function ExtractTextFromFileUTF8(const ArchiveFileName,
      AFileName: string): string;
    function FileExists(const AFileName: string): boolean;
  end;

implementation

function TZip.ExtractTextFromFile(const ArchiveFileName,
  AFileName: string): string;
begin
  Result := '';
  Password := PWD;
  FileName := ArchiveFileName;
  OpenArchive;
  try
    if FileExists(AFileName) then
      Result := ExtractToText(AFileName);
  finally
    CloseArchive;
  end;
end;

function TZip.ExtractTextFromFileUTF8(const ArchiveFileName,
  AFileName: string): string;
begin
  Result := UTF8ToString(ExtractTextFromFile(ArchiveFileName, AFileName));
end;

function TZip.ExtractToText(const AFileName: string): string;
begin
  ExtractToString(AFileName, Result);
end;

function TZip.FileExists(const AFileName: string): boolean;
var
  ArchiveItem: TZFArchiveItem;
begin
  Result := False;
  if (FindFirst('*.*', ArchiveItem, faAnyFile - faDirectory)) then
    repeat
      if (Trim(ArchiveItem.FileName) = Trim(AFileName)) then
      begin
        Result := True;
        Exit;
      end;
    until (not FindNext(ArchiveItem));
end;

end.
