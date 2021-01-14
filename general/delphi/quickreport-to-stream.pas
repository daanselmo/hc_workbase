{Chamada}
var
  fileStream: TFileStream;
 
fileStream:=TFileStream.Create(´c:\teste.qrp´,fmCreate);
SaveQuickReportToStream(rel_Bairros.QuickRep1,fileStream);
fileStream.Free;

{Método}
procedure TForm1.SaveQuickReportToStream(AQuickReport: TQuickRep; AStream: TStream);
var
    pageList: TQRPageList;
    i: Integer;
begin
pageList:=nil;
try
    pageList:=TQRPageList.Create;
    pageList.Stream:=TQRStream.Create(100000);
    AQuickReport.Prepare;
    pageList.LockList;
    try
        for i := 1 to AQuickReport.QRPrinter.PageCount do
            pageList.AddPage(AQuickReport.QRPrinter.GetPage(i));
        pageList.Finish;
    finally
        pageList.UnlockList;
        end;
    pageList.Stream.SaveToStream(AStream);
finally
    FreeAndNil(pageList);
    end;
end;