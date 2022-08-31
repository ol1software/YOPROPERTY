object FGlobal1: TFGlobal1
  Left = 0
  Top = 0
  Caption = 'FGlobal1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object FDTable1: TFDTable
    Connection = FDConnection1
    TableName = 'coches'
    Left = 152
    Top = 192
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'CacheSize=1'
      'DriverID=SQLite'
      'Database=C:\Users\USR\Desktop\OL1soft\_PRO\YPRO\baseY.db'
      'SharedCache=False')
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 192
  end
end
