object formbiz: Tformbiz
  Left = 0
  Top = 0
  Caption = 'formbiz'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object StaticText1: TStaticText
    Left = 160
    Top = 96
    Width = 61
    Height = 19
    Caption = 'StaticText1'
    TabOrder = 0
  end
  object tdinero: TStaticText
    Left = 207
    Top = 10
    Width = 161
    Height = 45
    Caption = '180.000 '#8364
    Font.Charset = ANSI_CHARSET
    Font.Color = clLime
    Font.Height = -32
    Font.Name = 'Andorra'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 1
    Transparent = False
  end
  object Button1: TButton
    Left = 64
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
end
