object iform: Tiform
  Left = 0
  Top = 0
  Caption = 'iform'
  ClientHeight = 441
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnClose = FormClose
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 707
    Height = 441
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      object StaticText2: TStaticText
        Left = 96
        Top = 3
        Width = 4
        Height = 4
        TabOrder = 0
      end
      object RichEdit1: TRichEdit
        Left = 0
        Top = 29
        Width = 699
        Height = 307
        Align = alClient
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = '@Arial Unicode MS'
        Font.Style = [fsBold, fsItalic]
        Lines.Strings = (
          'BIENVENIDO A YPROPERTY, un juego de simulaci'#243'n.'
          ''
          'Aqu'#237' debes comprar y vender coches.'
          ''
          'Puedes ir cambiando de ciudad (VIAJAR), trabajar (TRABAJAR) o'
          ' comprar/vender coches.'
          ''
          'JUEGO GRATUITO POR OL1SOFTWARE.COM'
          ''
          ''
          ''
          'HELP>>>>>>>>>>>>>>>>>>>>>>>>>'
          'WELCOME!'
          'This is <YPROPERTY>, a business simulation game'
          ''
          'Here you must buy, sell cars.'
          ''
          'You muts travel between the cities available.'
          ''
          'To continue playing press WORK button.')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
        Transparent = True
        OnClick = RichEdit1Click
      end
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 699
        Height = 29
        Caption = 'ToolBar1'
        TabOrder = 2
      end
      object Button1: TButton
        Left = 0
        Top = 336
        Width = 699
        Height = 75
        Align = alBottom
        Caption = 'X CERRAR'
        TabOrder = 3
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'AUTOR DEL JUEGO'
      ImageIndex = 1
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 699
        Height = 411
        Align = alClient
        Color = clInactiveCaptionText
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'Showcard Gothic'
        Font.Style = []
        Lines.Strings = (
          'BY OL1 SOFTWARE (2022)'
          '********************************************************'
          'FREE GAME FOR WINDOWS.'
          ''
          'DEVELOPED IN DELPHI 11.'
          '--'
          'www.ol1software.com'
          ''
          '')
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object StaticText1: TStaticText
        Left = 144
        Top = 32
        Width = 61
        Height = 19
        Caption = 'StaticText1'
        TabOrder = 1
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 9000
    Left = 512
    Top = 64
  end
end
