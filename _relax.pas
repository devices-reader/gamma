unit _relax;

interface

uses kernel, timez;

type
  TRelax = class
    public
      tiSelf: times;
      constructor Create(tiT: times);
  end;

implementation

constructor TRelax.Create(tiT: times);
begin
  tiSelf := tiT;
end;

end.
 