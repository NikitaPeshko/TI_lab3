unit Unit1;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
   ByteArray = array [1 .. 128] of Byte;
   TBytesToPrint = array of Byte;

   TForm1 = class(TForm)
      edtP: TEdit;
      lbP: TLabel;
      btConfirm: TButton;
      edtQ: TEdit;
      lbQ: TLabel;
      edtR: TEdit;
      lbR: TLabel;
      edtEuler: TEdit;
      lbEuler: TLabel;
      edtD: TEdit;
      lbD: TLabel;
      edtE: TEdit;
      lbE: TLabel;
      edtPublicKey: TEdit;
      lbPublicKey: TLabel;
      edtPrivateKey: TEdit;
      lbPrivateKey: TLabel;
      btnSignature: TButton;
      OpenDialog: TOpenDialog;
      SaveDialog1: TSaveDialog;
      lbM: TLabel;
      edtM: TEdit;
      lbS: TLabel;
      edtS: TEdit;
      btnCheck: TButton;
      edtM2: TEdit;
      mmRes: TMemo;
      lbM2: TLabel;
      procedure ProcessCode(FileName: string);
      procedure CheckEnteredNumber(Sender: TObject; Ident: Char;
        var Number: string; BottomLine: Integer; TopLine: Int64);
      procedure btConfirmClick(Sender: TObject);
      procedure CheckEnteredNumberExt(Sender: TObject; Ident: Char;
        var Number: string; BottomLine: Integer; TopLine: Int64);
      procedure edtPKeyPress(Sender: TObject; var Key: Char);
      procedure edtQKeyPress(Sender: TObject; var Key: Char);
      procedure edtDKeyPress(Sender: TObject; var Key: Char);
      procedure FormCreate(Sender: TObject);
      procedure btnSignatureClick(Sender: TObject);
      procedure btnCheckClick(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   Form1: TForm1;
   NumberP, NumberQ, NumberR, NumberD, NumberE: string;
   EulerFunc: string;
   fNameCipher, fNameDecipher: string;
   BytesArr: TBytesToPrint;
   Separator: Integer;

const
   cBytesMax = 128;

implementation

{$R *.dfm}
{ TForm1 }

function IsPrimeNumber(Number: Int64): Boolean;
var
   i: Integer;
begin
   result := false;
   if not Odd(Number) and (Number <> 2) then
      Exit;
   i := 3;
   while i <= Sqrt(Number) do
   begin
      if Number mod i = 0 then
         Exit;
      inc(i, 2);
   end;
   result := true;
end;

function IsPrimeButton(Number: Int64): Boolean;
begin
   if IsPrimeNumber(Number) then
      result := true
   else
      result := false;
end;

function ExtendedGCD(a, b: Integer; var x, y, gcd: Integer): Integer;
var
   x1, y1: Integer;
begin
   If b = 0 Then
   begin
      gcd := a;
      x := 1;
      y := 0;
      Exit
   end;
   ExtendedGCD(b, a mod b, x1, y1, gcd);
   x := y1;
   y := x1 - (a div b) * y1;
   result := gcd;
end;

function FastExp(Number, Degree, Module: Int64): Int64;
var
   Num, Deg, Res, TempNum: Int64;
begin
   Num := Number;
   Deg := Degree;
   Res := 1;
   while Deg <> 0 do
   begin
      while (Deg mod 2) = 0 do
      begin
         Deg := Deg div 2;
         TempNum := Num mod Module;
         Num := (TempNum * TempNum) mod Module;
      end;
      Deg := Deg - 1;
      Res := (Res * Num) mod Module;
   end;
   FastExp := Res;
end;

function HashFunction(StartValue: Integer; TempByte: Byte): Int64;
begin
   HashFunction := FastExp((StartValue + TempByte), 2, StrToInt(NumberR));
end;

function CalcHashFunction(StartValue: Integer; TempByte: Byte): Int64;
begin
   CalcHashFunction := HashFunction(StartValue, TempByte);
end;

procedure TForm1.btConfirmClick(Sender: TObject);
var
   Temp: Integer;
   x, y, gcd: Integer;
begin
   edtPublicKey.Clear;
   edtPrivateKey.Clear;
   EulerFunc := '';
   CheckEnteredNumber(edtP, 'p', NumberP, 2, 2147483647);
   CheckEnteredNumber(edtQ, 'q', NumberQ, 2, 2147483647);
   if (NumberP <> '') and (NumberQ <> '') then
   begin
      if ((StrToInt64(NumberP) = 2) and (StrToInt64(NumberQ) = 2)) or
        ((StrToInt64(NumberP) = 3) and (StrToInt64(NumberQ) = 2)) or
        ((StrToInt64(NumberP) = 2) and (StrToInt64(NumberQ) = 3)) then
      begin
         ShowMessage('φ(r) должно быть больше 3');
         NumberP := '';
         edtP.Text := '';
         NumberQ := '';
         edtQ.Text := '';
      end;
      if (NumberP <> '') and (NumberQ <> '') then
      begin
         NumberR := IntToStr(StrToInt64(NumberP) * StrToInt64(NumberQ));
         edtR.Text := NumberR;
         EulerFunc := IntToStr((StrToInt64(NumberP) - 1) *
           (StrToInt64(NumberQ) - 1));
         edtEuler.Text := EulerFunc;
      end;
   end;
   if (NumberP = '') or (NumberQ = '') then
   begin
      edtEuler.Clear;
      EulerFunc := '';
   end;
   if (EulerFunc <> '') then
      CheckEnteredNumberExt(edtD, 'd', NumberD, 2, StrToInt64(EulerFunc));
   numbere:='0';
   if (NumberD <> '') and (EulerFunc <> '') then
   begin
      Temp := ExtendedGCD(StrToInt64(NumberD), StrToInt64(EulerFunc),
        x, y, gcd);
      NumberE := IntToStr(x);
      if (StrToInt(NumberE) < 0) then
         NumberE := IntToStr(StrToInt64(NumberE) + StrToInt64(EulerFunc));
      edtE.Text := NumberE;
   end;
   if (NumberE <> '') and (NumberR <> '') then
      edtPublicKey.Text := NumberE + ', ' + NumberR;
   if (NumberD <> '') and (NumberR <> '') then
      edtPrivateKey.Text := NumberD + ', ' + NumberR;
end;

procedure TForm1.CheckEnteredNumber(Sender: TObject; Ident: Char;
  var Number: string; BottomLine: Integer; TopLine: Int64);
begin
   with Sender as TEdit do
      if Number <> '' then
      begin
         if (StrToInt64(Number) >= BottomLine) and (StrToInt64(Number) < TopLine)
         then
         begin
            if (Ident = 'p') or (Ident = 'q') then
               if not IsPrimeButton(StrToInt64(Number)) then
               begin
                  ShowMessage('Число ' + Ident + ' должно быть простым');
                  Number := '';
                  Clear;
               end;
         end
         else
         begin
            ShowMessage('Введите число ' + Ident + ' больше ' +
              IntToStr(BottomLine - 1) + ' меньше ' + IntToStr(TopLine));
            Number := '';
            Clear;
         end;
      end
      else
      begin
         ShowMessage('Введите простое число ' + Ident);
         Number := '';
         Clear;
      end;
end;

procedure TForm1.CheckEnteredNumberExt(Sender: TObject; Ident: Char;
  var Number: string; BottomLine: Integer; TopLine: Int64);
var
   x, y, gcd: Integer;
begin
   with Sender as TEdit do
   begin
      if Number <> '' then
      begin
         if (StrToInt64(Number) >= BottomLine) and (StrToInt64(Number) < TopLine)
         then
         begin
         end
         else
         begin
            ShowMessage('Введите число ' + Ident + ' больше ' +
              IntToStr(BottomLine - 1) + ' меньше ' + IntToStr(TopLine));
            Number := '';
            Clear;
         end;
      end
      else
      begin
         ShowMessage('Введите простое число ' + Ident);
         Number := '';
         Clear;
      end;
      if NumberD <> '' then
         if ExtendedGCD(StrToInt64(NumberD), StrToInt64(EulerFunc), x, y,
           gcd) <> 1 then
         begin
            ShowMessage('Введите число d взаимно простое с φ(r)');
            Number := '';
            Clear;
         end;
   end;
end;

procedure TForm1.edtDKeyPress(Sender: TObject; var Key: Char);
const
   Digit: set of Char = ['0' .. '9'];
begin
   if Key in Digit then
      NumberD := NumberD + Key;
   if Key = #8 then
   begin
      NumberD := '';
      edtD.Text := '';
   end;
end;

procedure TForm1.edtPKeyPress(Sender: TObject; var Key: Char);
const
   Digit: set of Char = ['0' .. '9'];
begin
   if Key in Digit then
      NumberP := NumberP + Key;
   if Key = #8 then
   begin
      NumberP := '';
      edtP.Text := '';
   end;
end;

procedure TForm1.edtQKeyPress(Sender: TObject; var Key: Char);
const
   Digit: set of Char = ['0' .. '9'];
begin
   if Key in Digit then
      NumberQ := NumberQ + Key;
   if Key = #8 then
   begin
      NumberQ := '';
      edtQ.Text := '';
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   NumberP := '';
   NumberQ := '';
   NumberR := '';
   NumberD := '';
   NumberE := '';
end;

procedure TForm1.ProcessCode(FileName: string);
var
   i: Integer;
begin
   fNameCipher := FileName;
   i := Length(fNameCipher);
   while fNameCipher[i] <> '.' do
      Dec(i);
   Insert('  CIPHER', fNameCipher, i);
   fNameDecipher := fNameCipher;
   Insert(' DE', fNameDecipher, pos('CIPHER', fNameDecipher));
end;

procedure Encrypt(InputFileName, OutputFileName: string;
  var Output: TBytesToPrint);
var
   InputBuffer: array [1 .. cBytesMax] of Byte;
   OutputBuffer: array [1 .. cBytesMax + 4] of Byte;
   InputStream, OutputStream: TFileStream;
   cBytes, i: Integer;
   IsOutputFilled: Boolean;
   M: Integer;
   S: Integer;
   F: TextFile;
begin
   M := 100;
   InputStream := TFileStream.Create(InputFileName, fmOpenRead);
   OutputStream := TFileStream.Create(OutputFileName, fmCreate);
   IsOutputFilled := false;
   SetLength(Output, cBytesMax);
   repeat
      cBytes := InputStream.ReadData(InputBuffer);
      i := 1;
      while i <= cBytes do
      begin
         OutputBuffer[i] := InputBuffer[i];
         begin
            Output[i - 1] := OutputBuffer[i];
            M := CalcHashFunction(M, Output[i - 1]);
         end;
         inc(i, 1);
      end;
      if not IsOutputFilled then
      begin
         SetLength(Output, cBytes);
         IsOutputFilled := true;
      end;
      OutputStream.WriteData(OutputBuffer, cBytes);
   until (InputStream.Position = InputStream.Size);
   OutputStream.Seek(0, soFromEnd);
   M := M mod StrToInt(NumberR);
   Form1.edtM.Text := IntToStr(M);
   S := FastExp(M, StrToInt64(NumberD), StrToInt64(NumberR));
   Form1.edtS.Text := IntToStr(S);
   InputStream.Free;
   OutputStream.Free;
   AssignFile(F, OutputFileName);
   Append(F);
   Write(F, '|');
   Write(F, Int64(S));
   CloseFile(F);
end;

function CountSeparators(InputFileName, OutputFileName: string;
  var Output: TBytesToPrint): Integer;
var
   InputBuffer: array [1 .. cBytesMax] of Byte;
   InputStream: TFileStream;
   cBytes, i: Integer;
   IsOutputFilled: Boolean;
   Counter: Integer;
const
   Digit: set of Char = ['0' .. '9'];
begin
   InputStream := TFileStream.Create(InputFileName, fmOpenRead);
   Counter := 0;
   IsOutputFilled := false;
   SetLength(Output, cBytesMax);
   repeat
      cBytes := InputStream.ReadData(InputBuffer);
      i := 1;
      while i <= cBytes do
      begin
         if (ord(InputBuffer[i]) = 124) then
            inc(Counter);
         inc(i);
      end;
      if not IsOutputFilled then
      begin
         SetLength(Output, cBytes);
         IsOutputFilled := true;
      end;
   until (InputStream.Position = InputStream.Size);
   CountSeparators := Counter;
   InputStream.Free;
end;

procedure Decrypt(InputFileName, OutputFileName: string;
  var Output: TBytesToPrint);
var
   InputBuffer: array [1 .. cBytesMax] of Byte;
   OutputBuffer: array [1 .. cBytesMax + 4] of Byte;
   InputStream: TFileStream;
   cBytes, i, j: Integer;
   IsOutputFilled, IsNotEmpty: Boolean;
   M2, M1, TempCounter: Integer;
   Valider: Integer;
   CheckNumber: string;
const
   Digit: set of Char = ['0' .. '9'];
begin
   M2 := 100;
   TempCounter := 0;
   InputStream := TFileStream.Create(InputFileName, fmOpenRead);
   IsOutputFilled := false;
   SetLength(Output, cBytesMax);
   IsNotEmpty := false;
   repeat
      cBytes := InputStream.ReadData(InputBuffer);
      i := 1;
      while (i <= cBytes) do
      begin
         if (ord(InputBuffer[i]) = 124) then
         begin
            inc(TempCounter);
            if (TempCounter = Separator) then
            begin
               inc(i);
               Valider := cBytes - i + 1;
               for j := i to cBytes do
               begin
                  if chr(InputBuffer[i]) in Digit then
                  begin
                     CheckNumber := CheckNumber + chr(InputBuffer[i]);
                     Dec(Valider);
                  end;
                  inc(i);
               end;
            end
            else
            begin
               OutputBuffer[i] := InputBuffer[i];
               begin
                  Output[i - 1] := OutputBuffer[i];
                  M2 := CalcHashFunction(M2, Output[i - 1]);
               end;
               inc(i, 1);
            end;
         end
         else
         {if (Valider <> 0) and (ord(InputBuffer[i - 1]) = 124) then }
         begin
            OutputBuffer[i] := InputBuffer[i];
            begin
               Output[i - 1] := OutputBuffer[i];
               M2 := CalcHashFunction(M2, Output[i - 1]);
            end;
            inc(i, 1);
         end;
      end;
      if not IsOutputFilled then
      begin
         SetLength(Output, cBytes);
         IsOutputFilled := true;
      end;
   until (InputStream.Position = InputStream.Size);
   InputStream.Free;
   Form1.edtS.Text := CheckNumber;
   M2 := M2 mod StrToInt(NumberR);
   Form1.edtM2.Text := IntToStr(M2);
   M1 := FastExp(StrToInt64(CheckNumber), StrToInt64(NumberE),
     StrToInt64(NumberR));
   Form1.edtM.Text := IntToStr(M1);
   if (M1 = M2) then
      Form1.mmRes.Text := 'Подпись действительна, т.к. m'' = m'
   else
      Form1.mmRes.Text := 'Подпись недействительна, т.к. m'' <> m';
   if (Valider <> 0) then
      Form1.mmRes.Text := 'Подпись содержит некорректные символы';
end;

procedure TForm1.btnCheckClick(Sender: TObject);
var
   Output: TBytesToPrint;
begin
   lbS.Visible := False;
   edtS.Visible := False;
   edtM2.Clear;
   mmRes.Clear;
   if (NumberP <> '') and (NumberQ <> '') and (NumberR <> '') and
     (NumberD <> '') and (NumberE <> '') then
   begin
      if OpenDialog.Execute then
      begin
         Separator := CountSeparators(OpenDialog.FileName,
           fNameDecipher, Output);
         Decrypt(OpenDialog.FileName, fNameDecipher, Output);
      end;
   end;
   lbM.Visible := true;
   edtM.Visible := true;
   lbM2.Visible := true;
   edtM2.Visible := true;
   mmRes.Visible := true;
end;

procedure TForm1.btnSignatureClick(Sender: TObject);
var
   Output: TBytesToPrint;
begin
   edtM.Clear;
   edtS.Clear;
   edtM2.Clear;
   mmRes.Clear;
   lbM2.Visible := False;
   edtM2.Visible := False;
   mmRes.Visible := False;
   if (NumberP <> '') and (NumberQ <> '') and (NumberR <> '') and
     (NumberD <> '') and (NumberE <> '') then
   begin
      if OpenDialog.Execute then
      begin
         ProcessCode(OpenDialog.FileName);
         Encrypt(OpenDialog.FileName, fNameCipher, Output);
      end;
   end;
   lbM.Visible := true;
   edtM.Visible := true;
   lbS.Visible := true;
   edtS.Visible := true;
end;

end.
