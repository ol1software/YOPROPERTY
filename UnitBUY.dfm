object formcompras: Tformcompras
  Left = 0
  Top = 0
  Caption = 'formcompras'
  ClientHeight = 485
  ClientWidth = 667
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object contenedor1: TPageControl
    Left = 0
    Top = 78
    Width = 667
    Height = 411
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'CARS'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 659
        Height = 381
        Align = alTop
        TabOrder = 0
        object fotocoche: TImage
          Left = 34
          Top = 22
          Width = 306
          Height = 154
          Align = alClient
          Center = True
          Proportional = True
          ExplicitLeft = 40
          ExplicitTop = 16
          ExplicitHeight = 199
        end
        object izq: TImage
          Left = 1
          Top = 22
          Width = 33
          Height = 154
          Align = alLeft
          Picture.Data = {
            0A544A504547496D61676536040000FFD8FFE000104A46494600010100000100
            010000FFDB0043000302020302020303030304030304050805050404050A0707
            06080C0A0C0C0B0A0B0B0D0E12100D0E110E0B0B1016101113141515150C0F17
            1816141812141514FFDB00430103040405040509050509140D0B0D1414141414
            1414141414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC00011080014001403012200021101031101
            FFC4001F0000010501010101010100000000000000000102030405060708090A
            0BFFC400B5100002010303020403050504040000017D01020300041105122131
            410613516107227114328191A1082342B1C11552D1F02433627282090A161718
            191A25262728292A3435363738393A434445464748494A535455565758595A63
            6465666768696A737475767778797A838485868788898A92939495969798999A
            A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
            D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
            01010101010101010000000000000102030405060708090A0BFFC400B5110002
            0102040403040705040400010277000102031104052131061241510761711322
            328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
            292A35363738393A434445464748494A535455565758595A636465666768696A
            737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
            A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
            E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FAB3
            F68EFDA86EFC29A9CBE1EF0D14FB5A644D72DC84E71DBA9C83EDDCE735F37689
            FB59F8B2D7C57259A789C5DEA76F189E5B450A0C719381B828C7D0366A97C75D
            12F34CF89BE27D335132C5702775DE09462847C8EA7A8CAE181F715E23F0EFC1
            73FC3C9B51B02B6F77A6CACD729AB39C5DC8C5B256E09FBE403C382380781DFF
            000EC7E638BA988AF52759C250768C13B697DFB3B76DDDFB23FACB27C8F2EA18
            2C1D0A7858D4A756379D46B9B5B5EDA6AAFF00CDA455ADBB47EAF7C1CF8F3A47
            C48F0441AA5EDC41A76A11C8D6F7503360798A01CAFB10C0FB648ED457C4DFB3
            DFC23F187C62F065FF0088FC3D27D9F467D4E6B7B691DC209C22A2991327952D
            B867D54FA515FACE0ABE2AA61A9CEAC3DE695FD6C7F39E6B84C051C7D7A787AB
            EE2934BAE97D353ED2FDA03E027857E2E68535FEAC97565AB69D6F23C1A969B2
            08A7DAAACDE5B1656564CF382091CE08C9CFE7EFECC7F02F4AFDA33E22EAFA0F
            8C75AD6E5D174E5127D8AC6E23B74B9009F9252B1EE6538E7041F7A28ACF1185
            C3CF171A92A69CBBD95FEF36C1E618CA5974E8D3AD251ECA4D2FBAF63F52FC35
            E1AD2BC1DA058689A25841A5E93610AC16D676C9B6389074007F5EFD4D14515E
            E1F267FFD9}
          OnClick = izqClick
          ExplicitTop = 28
          ExplicitHeight = 33
        end
        object dere: TImage
          Left = 340
          Top = 22
          Width = 33
          Height = 154
          Align = alRight
          Picture.Data = {
            0A544A504547496D61676534040000FFD8FFE000104A46494600010100000100
            010000FFDB0043000302020302020303030304030304050805050404050A0707
            06080C0A0C0C0B0A0B0B0D0E12100D0E110E0B0B1016101113141515150C0F17
            1816141812141514FFDB00430103040405040509050509140D0B0D1414141414
            1414141414141414141414141414141414141414141414141414141414141414
            14141414141414141414141414FFC00011080014001403012200021101031101
            FFC4001F0000010501010101010100000000000000000102030405060708090A
            0BFFC400B5100002010303020403050504040000017D01020300041105122131
            410613516107227114328191A1082342B1C11552D1F02433627282090A161718
            191A25262728292A3435363738393A434445464748494A535455565758595A63
            6465666768696A737475767778797A838485868788898A92939495969798999A
            A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
            D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
            01010101010101010000000000000102030405060708090A0BFFC400B5110002
            0102040403040705040400010277000102031104052131061241510761711322
            328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
            292A35363738393A434445464748494A535455565758595A636465666768696A
            737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
            A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
            E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FAB3
            F68EFDA86EFC29A9CBE1EF0D14FB5A644D72DC84E71DBA9C83EDDCE735F38783
            BF6B0F176A4B6BAE69BE26FED4B397E68DE30A148FEEE001D3D1871DC554F8DB
            A55EE87F157C4765A82B2DCC772D82C31BD3F8187B32E08FAD785F803C072F87
            753D53C417CF1585DEA7FBC974BB0629676E07720FDF93FBCF80393803A9FC3B
            1F9962EAE271152A5674E54DDA293D1EAF4B6FE77D96CF747F5964F91E5D4303
            83A3470B1AD1AD16E726AED689F3733D2D776E5D1BDD7C2CFD60F839F1E748F8
            91E088354BDB8834ED42391ADEEA066C0F3140395F62181F6C91DA8AF89BF67B
            F847E30F8C5E0CBFF11F87A4FB3E8CFA9CD6F6D23B84138454532264F2A5B70C
            FAA9F4A2BF59C157C554C3539D587BCD2BFAD8FE73CD70980A38FAF4F0F57DC5
            26975D2FA6A7DA5FB407C04F0AFC5CD0A6BFD592EACB56D3ADE478352D364114
            FB5559BCB62CACAC99E7041239C11939FCFDFD98FE05E95FB467C45D5F41F18E
            B5ADCBA2E9CA24FB158DC476E972013F24A563DCCA71CE083EF45159E230B879
            E2E35254D3977B2BFDE6D83CC3194B2E9D1A75A4A3D949A5F75EC7EA5F86BC35
            A5783B40B0D1344B0834BD26C21582DACED936C7120E800FEBDFA9A28A2BDC3E
            4CFFD9}
          OnClick = dereClick
          ExplicitLeft = 215
          ExplicitTop = 77
          ExplicitHeight = 33
        end
        object nombrevehtxt: TLabel
          Left = 56
          Top = 1
          Width = 109
          Height = 21
          Caption = 'nombrevehtxt'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape1: TShape
          Left = 1
          Top = 1
          Width = 657
          Height = 21
          Align = alTop
        end
        object Memoingresos: TMemo
          Left = 567
          Top = 232
          Width = 73
          Height = 89
          TabOrder = 0
          Visible = False
        end
        object Memogastos: TMemo
          Left = 567
          Top = 327
          Width = 73
          Height = 89
          TabOrder = 1
          Visible = False
        end
        object valores: TValueListEditor
          Left = 373
          Top = 22
          Width = 285
          Height = 154
          Align = alRight
          Strings.Strings = (
            'Mes=0'
            'A'#241'o=0'
            'km=1'
            'PRECIO=1'
            'Precio compra='
            'Nombre='
            'matricula='
            'modelo='
            'averia='
            'motor='
            'ruedas=')
          TabOrder = 2
          TitleCaptions.Strings = (
            '.'
            '..')
          ExplicitHeight = 199
          ColWidths = (
            82
            180)
        end
        object Button1: TButton
          Left = 1
          Top = 176
          Width = 657
          Height = 45
          Align = alBottom
          Caption = 'COMPRAR COCHE'
          TabOrder = 3
          OnClick = Button1Click
          ExplicitTop = 221
        end
        object propcheck: TCheckBox
          Left = 215
          Top = 198
          Width = 97
          Height = 17
          Caption = 'S'#237
          TabOrder = 4
        end
        object PanelV: TPanel
          Left = 1
          Top = 266
          Width = 657
          Height = 114
          Align = alBottom
          Caption = '.'
          Color = clHighlightText
          ParentBackground = False
          TabOrder = 5
          object Label1: TLabel
            Left = 1
            Top = 18
            Width = 655
            Height = 21
            Align = alBottom
            Caption = 'Tienes una oferta por...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 173
          end
          object Label2: TLabel
            Left = 1
            Top = -3
            Width = 655
            Height = 21
            Align = alBottom
            Alignment = taCenter
            Caption = 'VENDER TU COCHE'
            Color = clLime
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            OnClick = Label2Click
            ExplicitWidth = 146
          end
          object precioofrecidotxt: TNumberBox
            Left = 1
            Top = 39
            Width = 655
            Height = 33
            Align = alBottom
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Value = 900.000000000000000000
          end
          object VenderVBtn: TButton
            Left = 1
            Top = 72
            Width = 655
            Height = 41
            Align = alBottom
            Caption = 
              'MERCADO DE COMPRA VENTA>>> AQU'#205' PUEDES COMPRAR COCHES O VENDER E' +
              'L TUYO.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = VenderVBtnClick
          end
        end
        object Button2: TButton
          Left = 1
          Top = 221
          Width = 657
          Height = 45
          Align = alBottom
          Caption = 'X'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = Button2Click
          ExplicitLeft = 2
          ExplicitTop = 233
        end
      end
    end
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 667
    Height = 78
    Bands = <
      item
        ImageIndex = -1
        Width = 661
      end
      item
        Control = dinerotxt
        ImageIndex = -1
        MinHeight = 45
        Width = 661
      end>
    object dinerotxt: TStaticText
      Left = 11
      Top = 27
      Width = 652
      Height = 45
      Caption = '180.000 '#8364
      Font.Charset = ANSI_CHARSET
      Font.Color = clLime
      Font.Height = -32
      Font.Name = 'Andorra'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
      Transparent = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 456
    Top = 88
    object AYUDA1: TMenuItem
      Caption = 'AYUDA !!'
      OnClick = AYUDA1Click
    end
    object XCERRAR1: TMenuItem
      Caption = 'X CERRAR'
      OnClick = XCERRAR1Click
    end
  end
end
