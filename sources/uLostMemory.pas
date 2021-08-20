unit uLostMemory;

interface

var
  HPs : THeapStatus;
  HPe : THeapStatus;
  Lost: Integer;

implementation

uses SysUtils, uUtils, uError;

initialization
   HPs := getHeapStatus;   

finalization
   HPe := getHeapStatus;
   Lost := HPe.TotalAllocated - HPs.TotalAllocated;
   if ParamDebug and (Lost > 0) then Error.Add(
     Format('Утечка памяти: %d байт.',[Lost]));
end.
